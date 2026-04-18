### STATE ONE
   * Variable & types :- const,var,integers(u8,i32,usize), floats,boolean;
   * Function :- basic syntax,return types, void
   * Control flow :- if,while,for,switch(including labled switch)
   * Struct & enums :- defining, instantiating, methods
   * Arrays & slice :- fixed arrays [N]T, slices[]T, differences matters a lot
   * Strings :- just bytes slices([]const u8), no special string types

### STATE TWO
    * Error handling :- error union types (!T), try, catch, switch on erros
    * Optionals :- ?T,orelse,if (val)  |v| unwrap syntax
    * Manual memory :- allocators (std.heap.GeneralPurposeAllocator), alloc/free, no GC
    * Pointers :- *T,[*]T, *const T, pointer arithmetic
    * comptime :- compile-time execution, generic functions, type parameters
# projects
    1. calculator/expression parser :- practise comptime, errors,enums
    2. linked list/ stack / queue :- forced manual memory, allocators
    3. String utilities library :- slices, UTF-8, good first library contribution
    4. CLI arg parser :- Optionals, errors, loops

### STATE THREE 
    * Juicy Main(std.process.Init) :- "Juicy main"
    * std.Io interface :- Io.Threaded(default,stable) and Io.Evented(green threads/io_uring)
    * File I/O :- Io.Dir,Io.File, reading/writing files
    * build.zig :- build system DSL, zig build, depedency via build.zig.zon
# projects
    * HTTP client from scratch :- TCP sockets, parsing, allocators
    * Arena allocator implementation :- proves you truly understand memory
    * Cross-platform CLI tool :- build system, build.zig packging
    * C library wrapper :- @cImport, ABI, interop (huge for jobs)
    * Binary file format parser(PNG, ELF, WAV)

### STATE FOUR 
    * Packed structs/unions :- bit-level layout control
    * Union types :- tagged unions for sum types
    * Inline assembly :- asm volatile 
    * C interop :- @cImport, linking, C libraries
    * Incremental compilation :- pass - fincremental -- watch to zig
# projects
    * 
