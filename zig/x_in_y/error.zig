// error enumeration
const Error = error {
    WatchingAnyNetflixShow,
    BeOnTwiter,
};

// normal enumeration with enum 
const successStory = enum {
    DoingSport,
    ReadBook,
};


// either the value of "mylife" is an error or a normal value
var mylife: Error!successStory = Error.BeOnTwiter;
// mylife is an error
