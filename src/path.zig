const std = @import("std");
const math = std.math;

//initiate grid with 0s
const Point = @Vector(2, i32);

///you just provide a 2d array
pub fn Path_Finder(comptime T: type) type {
    const t_info = @typeInfo(T);
    const child_info = @typeInfo(t_info.Array.child);

    const height = t_info.Array.len;
    const width  = child_info.Array.len;
    return struct {
        collision_nodes: [height][width]Node = undefined,
        grid_2d: *const T,

        const Self = @This();
        pub inline fn init(grid: *const T) Self {
            return .{ .grid_2d = grid};
        }
        const Node = struct {
            parent: ?Point = null,
            g_distance: i32 = 0,
            l_distance: i32 = 0,
            visited: bool   = false,
        };

        const Direction = struct {
            const left  = Point{-1 , 0 };
            const right = Point{ 1 , 0 };
            const up    = Point{ 0 ,-1 };
            const down  = Point{ 0 , 1 };
        };
        inline fn heuristic(a: Point, b: Point) i32 {
            return @reduce(.Add, math.absInt(a - b) catch unreachable);
        }

        inline fn add_point(
                            self: *Self,
                            pending_points: *std.ArrayList(Point),
                            parent: Point,
                            direction_point: Point,
                            end: Point
        ) void {
            //checking if index are valid
            const point = parent + direction_point;
            if(@reduce(.Or, ( point < @as(Point, @splat(0) )))) return;
            if(point[0] > width-1 or point[1] > height-1) return;

            const x: u32 = @bitCast(point[0]);
            const y: u32 = @bitCast(point[1]);
            if(self.grid_2d[y][x] != 0) return; //checking if its a valid place in map

            const p_x: u32 = @bitCast(parent[0]);
            const p_y: u32 = @bitCast(parent[1]);

            const p_node = &self.collision_nodes[p_y][p_x];
            const node = &self.collision_nodes[y][x];

            //global distance bigger than 0 means it has been added already
            if(node.g_distance > 0) {
                if(node.parent == null) return;// only start point should be here
                const np_x: u32 = @bitCast(node.parent.?[0]);
                const np_y: u32 = @bitCast(node.parent.?[1]);
                const np_node = &self.collision_nodes[np_y][np_x];

                if(np_node.g_distance > p_node.g_distance) {
                    node.l_distance = p_node.l_distance + 1;
                    node.g_distance = node.l_distance + heuristic(point, end);
                    node.parent.? = parent;
                }
            } else {
                node.l_distance = p_node.l_distance + 1;
                node.g_distance = node.l_distance + heuristic(point, end);
                node.parent = parent;
                pending_points.append(point) catch {};
            }

        }

        inline fn push_smallest_end(self: *Self, pending_points: *std.ArrayList(Point)) void {
            //finding smallest global distance point in the list
            var smallest: Point = pending_points.getLast();
            var s_index: usize = pending_points.items.len - 1;
            for(pending_points.items, 0..) |item, i| {
                const x: u32 = @bitCast(item[0]);
                const y: u32 = @bitCast(item[1]);

                const s_x: u32 = @bitCast(smallest[0]);
                const s_y: u32 = @bitCast(smallest[1]);

                const node = self.collision_nodes[y][x];
                const s_node = self.collision_nodes[s_y][s_x];

                if(node.g_distance < s_node.g_distance) {
                    s_index = i;
                    smallest = pending_points.items[i];
                }
            }
            //swap smalles with the last pending point so that it is checked first
            const len = pending_points.items.len;

            pending_points.items[s_index] = pending_points.getLast();
            pending_points.items[len-1] = smallest;
        }

        pub fn a_start(self: *Self, start: Point, end: Point) void {
            self.clear();
            var buff: [10000]u8 = undefined;
            var allocator = std.heap.FixedBufferAllocator.init(&buff);

            var pending_points = std.ArrayList(Point).init(allocator.allocator());

            pending_points.append(start) catch {};

            while(true) {
                //the last item is always the one choosen by the heuristc
                const current_point = pending_points.pop();
                //checking if its over
                if(@reduce(.And, (current_point == end))) break;

                const c_x: u32 = @bitCast(current_point[0]);
                const c_y: u32 = @bitCast(current_point[1]);
                self.collision_nodes[c_y][c_x].visited = true;
                self.collision_nodes[c_y][c_x].g_distance = heuristic(start, end);

                //add all directions to the pending points
                self.add_point(&pending_points, current_point, Direction.left, end);
                self.add_point(&pending_points, current_point, Direction.right, end);
                self.add_point(&pending_points, current_point, Direction.up, end);
                self.add_point(&pending_points, current_point, Direction.down, end);

                if(pending_points.items.len == 0) break; // todo return exception
                self.push_smallest_end(&pending_points);
            }

            return;
        }
        inline fn clear(self: *Self) void{
            self.collision_nodes = comptime .{ [_]Node{Node{}} ** width } ** height;
        }
    };
}
test "testing and printing to see if path is working" {
    var map: [40][30]u8 = comptime blk: {
        @setEvalBranchQuota(40*30*3);
        var value: [40][30]u8 = undefined;
        for(&value,0..) |*i, in|{
            for(i, 0..) |*j, jn|{
                //creating non free blocks in the path
                // _ = in;
                // _ = jn;
                j.* = 0;
                if(in%2 == 0 and jn%2 == 0) {
                    j.* = 'b';
                }
                if(in%4 == 0 and jn != 0) {
                    j.* = '-';
                }else if(in%6 == 0 and jn < i.len - 1) {
                    j.* = '-';
                }
                if(in%6 == in%4 and jn == i.len/2) {
                    j.* = 0;
                }
            }
        }
        break :blk value; 
    };

    var path = Path_Finder(@TypeOf(map)).init(&map);

    const start = Point{0,0};
    const end   = Point{13,37};

    path.a_start(start, end);

    for (path.collision_nodes, 0..) |c, y| {
        for (c, 0..) |node, x| {
            //not changing the blocks
            if(map[y][x] == '-') continue;
            //inserting the printing board with all the visualized nodes visible
            map[y][x] = if (node.visited) '.' else ' ';
        }
    }

    //puting in the path as @ in place
    var p: ?Point = end;
    while(p != null) {
        const x: u32 = @bitCast(p.?[0]);
        const y: u32 = @bitCast(p.?[1]);
        map[y][x] = '@';
        p = path.collision_nodes[y][x].parent;
    }
    for(map) |m| {
        std.debug.print("{s}\n", .{m});
    }
    std.debug.print("(- are all the solid block)\n", .{});
    std.debug.print("(. are all the visulized nodes)\n", .{});
    std.debug.print("(@ is the actual path block)\n\n\n", .{});
}

