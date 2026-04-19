const std = @import("std");

const MulRes  = struct {
    quotent: i32,
    reminder : i32,
};

fn divmod (a: i32, b: i32) MulRes {
    return .{.quotent = a/b, .reminder = a % b };
}

const r = divmod(11, 4);
