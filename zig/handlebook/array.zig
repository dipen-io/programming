// Array And Struct
const expt = @import("std");


pub fn main() void {

    // basic array usage
    var numbers =[5]u8 { 1,2,3,4,5 };
    expt.log.info("numbers : {any}", .{ numbers });

    numbers[0] = 20;
    expt.log.info("numbers[0] : {}", .{numbers[0]});

    // array size interface
    const numbers2 = [_]u8 {10, 11, 12};
    expt.log.info("numbers2 : {any}", .{ numbers2 });

    // array concatenation
    expt.debug.print("====CONCATENATION====\n", .{});
    const numbers3 = numbers ++ numbers2;
    expt.log.info("numbers3 (number + numbers2) {any}", .{numbers3});
    expt.log.info("type of numbers3:  {}", .{@TypeOf(numbers3)});
    expt.log.info("size of the number3: {}", .{@sizeOf(@TypeOf(numbers3))});

    expt.debug.print("====MULTIPLICATION====\n", .{});
    const numbers4 = [_]u16{2} ** 10;
    expt.log.info("numbers4 {any}", .{numbers4});
    expt.log.info("type of numbers4 {}", .{@TypeOf(numbers4)});
    expt.log.info("size of numbers4 {}", .{@sizeOf(@TypeOf(numbers4))});
    expt.log.info("length of numbers4 {}", .{numbers4.len});

    expt.debug.print("====SLICE====\n", .{});
    const slice1 = numbers3[2..7];
    expt.log.info("slice1 {any}",.{slice1});
    expt.log.info("type of slice1 {}", .{@sizeOf(@TypeOf(slice1))});
    expt.log.info("length of slice1 {}", .{slice1.len});

    const slice2 = numbers3[6..];
    expt.log.info("slice2 {any}", .{slice2});
    expt.log.info("type of slice2 {}", .{@TypeOf(slice2)});
    expt.log.info("size of slice2 {}", .{@sizeOf(@TypeOf(slice2))});
    expt.log.info("length of slice2 {}", .{slice2.len});



}
