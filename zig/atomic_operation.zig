const std = @import("std");

// atomics are used in mutlti-threaded programming
// to allow different threads to read and write to the same memory location 
// without causing data-race(where data get corrupted because two thread touch it at the same time)

pub fn main() !void {

    // create an atomic variable
    // it hold u32 bit unsigned integer start with value 0;
    var val = std.atomic.Value(u32).init(0);

    // atomic operation require an ordering parameter (.acquire or .release)
    // this tell cpu and compiler how strictly to synchronize memory between different cores
    
    _=val.load(.acquire); // reads the current value
                        //.acquire ensures that any write perform by other threads (using .release)
                        //are visible to this thread now
                        
    val.store(1, .release); // sets the value 1
                                      // .release ensures that all previous work done by this thread 
                                      // is published an visible to any thread that later acquire this 
                                      // value

    _=val.swap(2, .seq_cst); // replace the current value with 2 
                                            // and return the old value that was there
                                            // .seq_cst (Sequentially Consistent)

    // compare and exchange
    // if the current value is old, change it to new 
    // if it is not old don't do anything
    // val.cmpxchgStrong(old, new, .seq_cst, .monotonic);
    const result = val.cmpxchgStrong(2, 3, .seq_cst, .monotonic);

    if (result) |actual_value| {
        // If 'result' HAS a value, the exchange FAILED.
        // actual_value is the number that was actually there.
        std.debug.print("FAILED: The value was actually {d}\n", .{actual_value});
    } else {
        // If 'result' is NULL, the exchange SUCCEEDED.
        std.debug.print("SUCCESS: Value was changed to 3\n", .{});
    }
}
