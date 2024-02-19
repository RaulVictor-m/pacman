const std = @import("std");
const ray = @cImport(@cInclude("raylib.h"));

var map: [36][28]u8 = undefined;
const resolution = 30;

pub fn load_map(map_level: u8) void {
    switch (map_level) {
        1 => {
            map =[_][28]u8 {
                [_]u8{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,1,0,1,0,1,0,1,0,1,1,1,0,0,1,1,1,0,1,0,1,0,1,0,1,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,},
                [_]u8{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,},
            };
        },
        else => {
            map = [_][28]u8{[_]u8{0,0,0,1} ** 7, [_]u8{1,0,0,0} ** 7} ** 18;
        },
    }
}


const Entity = struct {
    grid_pos: @Vector(2, u32),  //x,y
    screen_pos: @Vector(2, i32),  //x,y
    size: i32,
    velocity: i32,
    busy: bool,
    e_type: enum { GHOST, PACMAN, },
    move_direction: enum { LEFT, RIGHT, DOWN, UP, NONE },

    pub inline fn init() Entity {
        return Entity{
            .grid_pos       = [_]u32{14,15},
            .screen_pos     = [_]i32{14*resolution,15*resolution},
            .size           = resolution,
            .velocity       = 3,
            .busy           = false,
            .e_type         = .GHOST,
            .move_direction = .NONE,
        };
    }

    pub fn handle_input(player: *Entity) void {
        //simple enum to be able to more easely remap if needed
        const Keys = enum(c_int){
            UP    = ray.KEY_UP,
            DOWN  = ray.KEY_DOWN,
            LEFT  = ray.KEY_LEFT,
            RIGHT = ray.KEY_RIGHT,
        };
        if(player.move_direction != .NONE) return;

        player.move_direction = .NONE;
        const x = player.grid_pos[0];
        const y = player.grid_pos[1];

        if(ray.IsKeyDown(@intFromEnum(Keys.UP))){
            if(map[y-1][x] == 0) {
                player.grid_pos = @Vector(2, u32){x,y-1};
                player.move_direction = .UP;
            }
        }

        else if(ray.IsKeyDown(@intFromEnum(Keys.DOWN))){
            if(map[y+1][x] == 0) {
                player.grid_pos = @Vector(2, u32){x,y+1};
                player.move_direction = .DOWN;
            }
        }

        else if(ray.IsKeyDown(@intFromEnum(Keys.LEFT))){
            if(map[y][x-1] == 0) {
                player.grid_pos = @Vector(2, u32){x-1,y};
                player.move_direction = .LEFT;
            }
        }

        else if(ray.IsKeyDown(@intFromEnum(Keys.RIGHT))){
            if(map[y][x+1] == 0) {
                player.grid_pos = @Vector(2, u32){x+1,y};
                player.move_direction = .RIGHT;
            }
        }
    }
    pub inline fn draw(entities: []const Entity) void {
        for(entities) |e| {
            ray.DrawRectangle(e.screen_pos[0], e.screen_pos[1], e.size, e.size, ray.WHITE);
        }
    }
    pub inline fn move(entities: []Entity) void {
        const move_table = [_]@Vector(2, i32){
            // LEFT, RIGHT, DOWN, UP
            @Vector(2, i32){-1,0},
            @Vector(2, i32){ 1,0},
            @Vector(2, i32){0, 1},
            @Vector(2, i32){0,-1},
        };
        for(entities) |*e| {
            if (e.move_direction == .NONE) continue;

            const direction = @intFromEnum(e.move_direction);
            const velocity: @Vector(2, i32) = @splat(e.velocity);

            const px_distance = move_table[direction] * velocity;
            e.screen_pos += px_distance;

            const res: @Vector(2, i32) = @splat(resolution);

            const off_grid_aspect = @rem(e.screen_pos, res);
            const end_move = off_grid_aspect == @as(@Vector(2, i32), @splat(0));

            if(@reduce(.And, end_move)) {
                e.move_direction = .NONE;
            }
        }
    }

};
pub fn ghosts_ai(ghosts: []Entity) void {
    const random = struct {
        var rng: std.rand.Xoshiro256 = undefined;//std.rand.DefaultPrng.init(std.time.milliTimestamp());
    };

    random.rng = std.rand.DefaultPrng.init(@bitCast(std.time.milliTimestamp()));
    for(ghosts) |*g| {
        if(g.move_direction != .NONE) continue;
        const direction = random.rng.random().int(u2);
        g.move_direction = @enumFromInt(direction);
    }
}

pub fn main() !void {
    const screenWidth = map[0].len * resolution;
    const screenHeight = map.len * resolution;

    ray.InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
    defer ray.CloseWindow();

    ray.SetTargetFPS(60);

    //setup
    load_map(1);
    var entities = [_]Entity{
        Entity.init(),  //player

        Entity.init(),  //ghosts
        Entity.init(),
    };
    const player = &entities[0];
    const ghosts = entities[1..];

    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        ray.ClearBackground(ray.BLACK);
        //draw map
        for(map, 0..) |line, map_y| {
            for(line, 0..) |tile, map_x| {
                const x = @as(c_int, @intCast(map_x * resolution));
                const y = @as(c_int, @intCast(map_y * resolution));

                if(tile != 0)
                    ray.DrawRectangle(x, y, resolution, resolution, ray.RED);
            }
        }

        //handle player input
        player.handle_input();

        //handle ghost AI
        ghosts_ai(ghosts);
        // _ = ghosts;
        //TODOO

        //handle map events
        //TODOO

        //handle entities movent
        Entity.move(&entities);

        //drawing entities
        Entity.draw(&entities);

        ray.EndDrawing();
    }
}

