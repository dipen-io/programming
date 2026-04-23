const std = @import("std");
const Io = std.Io;

const count_word = @import("count_word");
const count_words = @import("count_words.zig");

pub fn main(init: std.process.Init) !void {

    const io = init.io;
    // This is appropriate for anything that lives as long as the process.
    const arena: std.mem.Allocator = init.arena.allocator();

    // Accessing command line arguments:
    const args = try init.minimal.args.toSlice(arena);
    for (args[1..]) |arg| {
        std.log.info("arg: {s}", .{arg});
    }

    // accessing the filename
    const filename = args[1];
    const result = try count_words.analyze(filename, io);
    std.debug.print("Words: {d} \n", .{result.words});
    std.debug.print("Letters: {d} \n", .{result.letters});


    // In order to do I/O operations need an `Io` instance.

    // Stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_file_writer: Io.File.Writer = .init(.stdout(), io, &stdout_buffer);
    const stdout_writer = &stdout_file_writer.interface;

    try count_word.printAnotherMessage(stdout_writer);

    try stdout_writer.flush(); // Don't forget to flush!
}
