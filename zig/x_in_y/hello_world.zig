const std = @import("std");
const print = std.debug.print;

const info = std.log.info;

pub fn main() !void {
    info("hello world" , .{});

    // strings
    const greeting = "hello"; // same 
    const greet : *const[5:0]u8 = "world";
    

    print("string: {s}\n" , .{ greeting });
    print("string: {s}\n" , .{ greet });

    // slice , a pointer and a size, an array without compile-time known size  
    const array = [_]u8 { 1,2,3,4,5 }; // array with compile time know size
    const slice = array[0..array.len]; // slice[10] gives a runtime error
     _ = slice;
     
     // pointer
     const x: i32  = 1;
     const pointer_to_x = &x;
     print("1= {}, {}\n", .{ x, pointer_to_x });

}

fn some_memory_allocation_example() !void{

    const page_allocator =  std.heap.page_allocator;

    const buf = try page_allocator.alloc(u8, 20);
    defer page_allocator.free(buf); 


}
