const std = @import("std");

const Hidden = opaque {};
// declare the type
// u cant access its field because there are none visible

pub fn main() void {
    const x: *Hidden = undefined;
    _=x;
}

