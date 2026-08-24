const array = [1, 2, 4, 5];

function ArrayFn(x){
console.log("x", x*2);
}

// const mapped = array.map((x) => x * 2);
const mapped = array.map((x) => ArrayFn(x));

console.log(mapped);
