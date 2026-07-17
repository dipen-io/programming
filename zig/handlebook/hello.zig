const std = @import("std");

pub fn main(init: std.process.Init) !void {
    std.log.info("Hello World", .{});
    // std.debug.print("hello world", .{});
    
    // stdout(standart output) belong to io subsytem
    // need io context (init.io) to perform io operation
    // stream outptu so we dont need buffer and a wirter 
    // try -> might return an error
    try std.Io.File.stdout().writeStreamingAll(init.io, "hello world\n");
}
