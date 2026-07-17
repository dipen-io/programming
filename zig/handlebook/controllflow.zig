const std = @import("std");
const print = std.debug.print;

pub fn main() void {

    // classic
    if (true) print("This happen\n", .{}); 
    if (false) print("This never happen\n", .{}); 

    // conditional expression
    var x: u8 = if (true) 2 else 7;
    print("x: {}\n",.{x});
    x += 1;

    x = if (x % 2==0) 4 else 7;
    print("x: {}\n",.{x});


    // wraping option
    // if a variable can assume null values, the type must be explicit
    var yMyabe: ?u8 = null; // u8 | null
    if (yMyabe) |y|  {
        // becaue it is null for now
        print("This never happen {}\n", .{y});
    }

    yMyabe = 10;
    if (yMyabe) |y|  {
        // becaue it is null for now
        print("This optional has value:  {}\n", .{y});
    }


    //switch
    // const number = 1221;
    const number = 50;
    print("SWITCH..............\n", .{});

    //switch as statement
    switch (number) {
        // specific value
        1 => print("is that really random? {}\n", .{number}),

        // possible value
        2,3,4,5 => print("not my option {}.\n", .{number}),

        // rnage valaue
        10...30 => print("not my range {}", .{number}),

        // mix thing block are allowed too
        0, 31...51 => {
            print("this is a big number {}.\n", .{number});
        },
        else => print("and everyting else.. \n", .{}),
    }
}

