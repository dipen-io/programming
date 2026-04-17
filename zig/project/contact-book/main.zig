const std = @import("std");

const Contact = struct {
    name: [] const u8,
    phone: [] const u8,
    email: [] const u8,
};

const CSV_FILE = "contacts.csv";


pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;
    const io = init.io;

    const args = try init.minimal.args.toSlice(init.arena.allocator());
    if (args.len < 2) {
        printUsage();
        return;
    }

    const command = args[1];

    if (std.mem.eql(u8, command, "list")) {
        try listContacts(gpa);
    }  else if (std.mem.eql(u8, command, "add")) {
        if (args.len < 3) {
            std.debug.print("Usage: add <name> <phone> <emai> \n", .{});
            return;
        }
        try addContact(gpa,  io, args[2], args[3], args[4]);
    } else if (std.mem.eql(u8, command, "search")) {
        if (args < 3) {
            std.debug.print("Usage: search :<name> \n", .{});
            return;
        }
        try searchContact(gpa, args[2]);
    } else if (std.mem.eql(u8, command, "delete")) {
        if (args.len < 3) {
            std.debug.print("Usage: delete <name>\n", .{});
            return;
        }
        try deleteContact(gpa, args[2]);
    } else {
        printUsage();
    }
}

fn printUsage() void{}
fn listContacts(allocator : std.mem.Allocator) !void{
    std.debug.print("Listing contacts using allocator: {*}\n",.{allocator});
}

fn addContact(
    allocator: std.mem.Allocator,
    io: std.Io,
    name : []const u8,
    phone : []const u8,
    email: []const u8)
    !void{

        // 1. create the struct (stack allocated)
        const new_entry = Contact {
            .name = name,
            .phone = phone,
            .email = email
        };

        // 2. Open the file in append mode
        const file = try io.openFile(CSV_FILE, .{ .mode = .read_write, .action = .open_or_create });
        defer file.close(io);

    }

fn searchContact() void{}
fn deleteContact() void{}
