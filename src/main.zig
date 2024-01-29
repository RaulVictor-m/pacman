const std = @import("std");
const ray = @cImport(@cInclude("raylib.h"));

var map: [36][28]u8 = undefined;
const resolution = 30.0;

pub fn load_map(map_level: u8) void {
    switch (map_level) {
        else => {
            map = [_][28]u8{[_]u8{0,0,0,1} ** 7, [_]u8{1,0,0,0} ** 7} ** 18;
        },
    }
}

const Ghost = struct {
    pos: ray.Vector2,
    velocity: f32,

    const mode = enum {
        HUNT,
        CHILL,
    };

    pub fn move_ghosts(ghosts: []Ghost) void {
        _ = ghosts;
    }

    pub fn draw_ghosts(ghosts: []const Ghost) void {
        //TODO draw a sprite for a ghosts
        for(ghosts) |ghost|{
            // const x = ghost.pos.x*resolution;
            // const y = ghost.pos.y*resolution;

            const size: ray.Vector2 = .{.x = resolution, .y = resolution};
            ray.DrawRectangleV(ghost.pos, size,ray.WHITE);
        }
    }
};

const Player = struct {
    pos: ray.Vector2,
    size: ray.Vector2,
    velocity: f32,

    pub fn move_player(player: *Player) void {
        //simple enum to be able to more easely remap if needed
        const Keys = enum(c_int){
            UP    = ray.KEY_UP,
            DOWN  = ray.KEY_DOWN,
            LEFT  = ray.KEY_LEFT,
            RIGHT = ray.KEY_RIGHT,
        };

        const distance = player.velocity * ray.GetFrameTime();

        if(ray.IsKeyDown(@intFromEnum(Keys.UP))){
            const y           = player.pos.y - distance;
            const x           = player.pos.x;
            const x_width     = player.pos.x + player.size.x;

            const map_y       = @as(usize, @intFromFloat(y / resolution));
            const map_x       = @as(usize, @intFromFloat(x / resolution));
            const map_x_width = @as(usize, @intFromFloat(x_width / resolution));

            if(map[map_y][map_x] == 0 and map[map_y][map_x_width] == 0){
                player.pos.y = y;
            } 
        }

        if(ray.IsKeyDown(@intFromEnum(Keys.DOWN))){
            const y           = player.pos.y + player.size.y + distance;
            const x           = player.pos.x;
            const x_width     = player.pos.x + player.size.x;

            const map_y       = @as(usize, @intFromFloat(y / resolution));
            const map_x       = @as(usize, @intFromFloat(x / resolution));
            const map_x_width = @as(usize, @intFromFloat(x_width / resolution));

            if(map[map_y][map_x] == 0 and map[map_y][map_x_width] == 0){
                player.pos.y += distance;
            } 
        }

        if(ray.IsKeyDown(@intFromEnum(Keys.LEFT))){
            const x            = player.pos.x - distance;
            const y            = player.pos.y;
            const y_height     = player.pos.y + player.size.y;

            const map_y        = @as(usize, @intFromFloat(y / resolution));
            const map_x        = @as(usize, @intFromFloat(x / resolution));
            const map_y_height = @as(usize, @intFromFloat(y_height / resolution));

            if(map[map_y][map_x] == 0 and map[map_y_height][map_x] == 0){
                player.pos.x = x;
            } 
        }

        if(ray.IsKeyDown(@intFromEnum(Keys.RIGHT))){
            const x            = player.pos.x + player.size.x + distance;
            const y            = player.pos.y;
            const y_height     = player.pos.y + player.size.y;

            const map_y        = @as(usize, @intFromFloat(y / resolution));
            const map_x        = @as(usize, @intFromFloat(x / resolution));
            const map_y_height = @as(usize, @intFromFloat(y_height / resolution));

            if(map[map_y][map_x] == 0 and map[map_y_height][map_x] == 0){
                player.pos.x += distance;
            } 
        }
    }

    pub fn draw_player(player: Player) void {
        //TODO draw a sprite for a player
        // const x = player.pos.x*resolution;
        // const y = player.pos.y*resolution;

        ray.DrawRectangleV(player.pos, player.size,ray.YELLOW);
    }
};

pub fn main() !void {
    const int_reso: usize = @intFromFloat(resolution);
    const screenWidth = map[0].len * int_reso;
    const screenHeight = map.len * int_reso;

    ray.InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
    defer ray.CloseWindow();

    ray.SetTargetFPS(60);

    //setup
    load_map(0);
    var player =
    Player{
        .pos  = .{.x = 0.0, .y = 0.0},
        .size = .{.x = 20.0, .y = 20.0},
        .velocity = 300.0
    };
    var ghosts = [_]Ghost{
        .{.pos = .{.x = 10.0, .y = 10.0}, .velocity = 500.0},
        .{.pos = .{.x = 20.0, .y = 20.0}, .velocity = 500.0},
    };
    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        //draw map
        for(map, 0..) |line, map_y| {
            for(line, 0..) |tile, map_x| {
                const x = @as(c_int, @intCast(map_x * int_reso));
                const y = @as(c_int, @intCast(map_y * int_reso));

                if(tile != 0)
                    ray.DrawRectangle(x, y, resolution, resolution, ray.RED);
            }
        }
        //handle player input
        Player.move_player(&player);

        //handle entities movent
        Ghost.move_ghosts(&ghosts);

        //drawing entities
        Player.draw_player(player);
        Ghost.draw_ghosts(&ghosts);

        ray.ClearBackground(ray.BLACK);

        ray.EndDrawing();
    }
}

