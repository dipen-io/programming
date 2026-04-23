const std = @import("std");

pub const Result = struct {
    words: usize,
    letters: usize,
};

// !usize means this function can return an error or a usize (word count)
pub fn analyze(filename: []const u8, io: std.Io) !Result {

    // Open the file from the current working directory
    // try will return the error to the caller if opening fails
    const file = try std.Io.Dir.cwd().openFile(io, filename, .{});
    // defer ensures file is closed when function exits, even on error
    defer file.close(io);

    // Stack allocated buffer to hold file contents (2KB max)
    // undefined means memory is not zeroed, just raw allocated
    var read_buf: [1024 * 2]u8 = undefined;

    // Read file contents into read_buf starting at offset 0 (beginning of file)
    // returns how many bytes were actually read
    const byte_read = try file.readPositionalAll(io, &read_buf, 0);

    // Slice the buffer to only the bytes actually read
    // avoids counting garbage/undefined memory beyond the file content
    const content = read_buf[0..byte_read];

    // Word counter
    var count: usize = 0;

    // tokenizeAny splits content by spaces, tabs, newlines and carriage returns
    // each token = one word
    var tokens = std.mem.tokenizeAny(u8, content, " \t\n\r");

    // iterate through every token and increment count
    while (tokens.next() != null) count += 1;

    // count letters
    var letters: usize = 0;
    for (content) |char| {
        if (std.ascii.isAlphabetic(char)) letters += 1;
    }

    // return the final word count to the caller
    return Result {.words = count, .letters = letters };
}
