const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const n_age = 1;
    // swtich with range
    switch (n_age) {
        0...3 => {
            print("you are baby", .{});
        },
        4...10 => {
            print("you are todder.", .{});
        },
        11...15 => {
            print("you are yong", .{});
        },
        16...17 => {
            print("young but old enough to drive", .{});
        },
        else => {
            print("invalid age", .{});
        },
    }

    // without range
    const n_code = 404;
    const s_response = switch (n_code) {
        200 => "Page found",
        301 => "Redirect",
        404 => "Not Found",
        else => "unknown error",
    };
    print("\nThe address responded with: {d} '{s}'.\n", .{ n_code, s_response });

    // switch with capture
    const t_resp = switch (n_code) {
        200...399 => |n_c| .{ n_c, "Page exists or is being redirected" },
        400...499 => |n_c| .{ n_c, "Client error" },
        500...599 => |n_c| .{ n_c, "Server error" },
        else => |n_c| .{ n_c, "Unknown error" },
    };
    print("The address responded with: {d} - '{s}'.\n", t_resp);
}
