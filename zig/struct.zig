const std = @import("std");
const print = std.debug.print;

const Person = struct {
    name: []const u8,
    age: u8,
};

// field can have default values too
const User = struct {
    name: []const u8 = "Guest",
    age: u8 = 0,
};

// nested struct
const Address = struct {
    city: []const u8,
    country: []const u8,
};

const Employee = struct {
    name: []const u8,
    address: Address,
};


// method
const Point = struct {
    x: i32,
    y: i32,

    fn move(self: *Point, dx: i32, dy: i32) void {
        self.x += dx;
        self.y = dy;
    }
};


pub fn main(init: std.process.Init) !void {
    _= init;
    const p = Person{
        .name = "dinesh",
        .age = 22,
    };

    print("my name is {s} and age is {}\n", .{p.name, p.age});

    const u = User{}; 
    print("my name is {s} and age is {}\n", .{u.name, u.age});

    const e = Employee{
        .name = "Ammm",
        .address = .{
            .city = "Mumbai",
            .country = "India"
        }
    };

    print("name: {s}, address: {s}, {s}\n", .{e.name, e.address.country, e.address.city});

    var pt = Point{ .x = 10, .y = 20 };
    print("Before: {} {}",.{pt.x, pt.y});
    pt.move(4, 3);
    print("After: {} {}",.{pt.x, pt.y});

}
