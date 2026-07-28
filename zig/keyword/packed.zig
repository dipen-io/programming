const Flags = packed struct {
    a: u1,
    b: u1,
    c: u1,
    d: u5,
};

pub fn main() void{
    const f = Flags {
        .a = 1,
        .b =  0,
        .c = 1,
        .d = 17
    };
    _ = f;
}

// used for struct & union
// when tide memory layout is needed
// fields are store as compact as possible
// There is no normal padding between fields
// great for bit field and low -level data layout
