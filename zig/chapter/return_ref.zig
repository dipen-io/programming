const std = @import("std");
const print = std.debug.print;

// increments a value and returns the memory address
// pointed to by parameter n_x
fn inc(n_x: *u8) *const *u8 {

    // we print the address contained in n_x
    print("Address arriving contained in n_x = {}\n", .{n_x});

    // we print the address of n_x
    print("Address of n_x: {}\n", .{&n_x});

    print("What n_x points to: {}\n", .{&n_x.*});

    // we modify the data pointed to by the address
    // contained in n_x
    n_x.* += 1;

    return &n_x;
}

pub fn main() void {

    // variable
    var n_a: u8 = 41;

    print("Value n_a = {}\n", .{n_a});

    // print the address of the variable
    print("Address of n_x in main {}\n", .{&n_a});

    // increment n_a
    const p_x = inc(&n_a);

    print("Get the pointer: {}\n", .{p_x});

    print("But it already shows undefined behavior, it points to {}\n", .{p_x.*});

    // we print the incremented n_a
    print("Value n_a = {}\n", .{n_a});
}
