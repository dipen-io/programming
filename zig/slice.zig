const std = @import("std");
const print = std.debug.print;

fn sum(nums: []const i32) i32 {
    var total: i32 = 0;
    for (nums) |n| {
        total += n;
    }
    return total;
}

pub fn main() !void {
    const arr = [_]u8 { 10, 20 , 30, 40, 50 };
    const s1 = arr[1..4]; // { 20, 30, 40 }
    const s2 = arr[2..]; // { 30, 40, 50 }

    print("{} {}\n", . { s1.len, s2.len });

    print("{any} {any}\n", .{ s1.*, s2.*});
    print("arr: {any} \n", .{ arr });

    print("address of s1: {*} and s2: {*}\n",.{ s1.ptr, s2.ptr});

    const value = [_]i32 {1,2,3,4};
    const result = sum(value[0..]);
    print("result: {}\n", . { result });

}
