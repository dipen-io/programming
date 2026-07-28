extern "c" fn puts(s: [*:0]const u8) callconv(.C) c_int;

pub fn main() void {
    _ = puts("Hello from Zig!\n");
}
