const std = @import("std");

pub fn main() !void {
    // Type inference -- Zig figure out the type
    const x = 23; // i32 ( infered as comptime_int then i32)
    const y = 3.3; //  f64 (infered as comptime_float , then float 64)
    const name = "Zig"; // []const u8 (string slice)

    //Explicit type annotation
    const z: u8 = 43; // Explicity a  32-bit- float,
    std.debug.print("x={}, y={d:.2}, name={s}, z={d}", .{ x, y, name, z });

    //  Integer Types
    // signed (i8, i16, i32, i64, i128)
    const small: i8 = -128; // -128 , i128
    const medium: i32 = -2_147_483_648; // Use underscores for readability
    const large: i64 = 9_223_372_036_854_775_807;

    // Unsigned integers (u8, u16, u32, u64, u128)
    const byte: u8 = 255; // Range: 0 to 255
    const word: u16 = 65535;
    const dword: u32 = 4_294_967_295;

    // Special integer types
    const ptr_sized: usize = 1024; // Size of a pointer (32/64-bit depending on platform)
    const signed_ptr: isize = -1024; // Signed version of usize

    std.debug.print("Signed: {}, {}, {}\n", .{ small, medium, large });
    std.debug.print("Unsigned: {}, {}, {}\n", .{ byte, word, dword });
    std.debug.print("Pointer-sized: {}, {}\n", .{ ptr_sized, signed_ptr });
}
