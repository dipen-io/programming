const std = @import("std");
const print = std.debug.print;

const Contact = struct {
    name: [] const u8,
    phone: [] const u8,
    email: [] const u8,
};

const argEnum = enum{
    one,
    two,
    three
};

const CSV_FILE = "contacts.csv";


pub fn main(init: std.process.Init) !void {

    // gives free allocator
    const arena = init.arena.allocator();

    // gives all args as a slice
    const args = try init.minimal.args.toSlice(arena);

    // because arg[0] gives program name and i don't want it
    // using for

    print("FOR:\n", .{});
    for (args[1..]) |arg| {
        print("executing command : {s}\n", .{arg});
        if (std.mem.eql(u8, arg, "one")) {
            one(arg);
        }
        else if (std.mem.eql(u8, arg, "two")) {
            two(arg);
        }
        else if (std.mem.eql(u8, arg, "three")) {
            three(arg);
        }
        else {
            print("Unknonw Command\n", .{});
        }
    }

    // using switch (you can't direclty use switch on string)
    const arg = args[1];
    const cmd = std.meta.stringToEnum(argEnum, arg) orelse {
        print("Unknonw command: {s}\n", .{arg});
        return;
    };
    print("SWITCH\n", .{});
    switch (cmd) {
        .one => one(arg),
        .two => two(arg), 
        .three => three(arg), 
    }
}

fn one(cmd: []const u8) void{
    print("{s}\n", .{cmd});
}

fn two(cmd: []const u8) void{
    print("{s}\n", .{cmd});
}

fn three(cmd: [] const u8) void{
    print("{s}\n", .{cmd});
}

