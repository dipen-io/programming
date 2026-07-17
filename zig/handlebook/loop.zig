// while statement/expression
const std = @import("std");
const print = std.debug.print;


pub fn main() void {
    var i: u8 = 1;

    //classic
    while (i <= 5) {
        std.log.info("i : {}", .{i});
        i += 1;
    }

    print("TRUE NEUTRAL\n", .{});
    // true neutral
    var j: u8 = 5;
    // while (j > 0 ): (j -= 1) {
    //     std.log.info("j : {}", .{j});
    // }

    while (j > 0 ) {
        std.log.info("j : {}", .{j});
        j -= 1;
    }


    print("EVIL\n", .{});

    var k: u8 = 0;
    const f: u8 = while(k < 50) : (k = k+3) {
        if (k > 10) break k;
    } else 4;
    std.log.info("k : {}, f: {}", .{k,f});


    print("FOOR LOOP\n", .{});

    for (0..3) |p| {
        std.log.info("i: {}",.{p});
    }

    // loop over collection
    const names = [_][]const u8{"a", "b", "c", "banana"};
    for (names) |value| {
        std.log.debug("name: {s}", .{value});
    }

    // multiple collection
    const intergers = [_]u16 {1,6,33,9,2,567};
    const floats = [_]f16{1.1, 6.4,-33.555, 9.1, -2.1111, 567.8};
    for (intergers, floats) |r,s| {
        std.log.debug("numbers: [{}] [{}]", .{r,s});
    }

    // collection and ranges
    for (names, 0..) |name, ii| {
        std.log.debug("i, name: [{}]: [{s}]", .{ii, name});
    }

    // pointer to collection change
    var samples = [_]i32{1,1,1,1,1};
    for (&samples) |*sample| {
        sample.* *= 2;
    }

    std.log.info("Modified array: {any}", .{samples});

    const x = for (11..111) |values| {
        if (values%31 == 0) break i;
    } else 
        123;

    std.log.info("x: {}", .{x});

}
