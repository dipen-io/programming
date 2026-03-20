void main(List<String> args)  async {
    var name = "dinesh"; // declare variable using var 
    // other ways of declaring variabler

    // final and const
    final age = 24; // run time constant (use this when we don't know its value it may be coming from backend)
    const isLogged = true; // compile time constant (use it if we kmow the exact value)
    for (var i = 0; i< 4; i++) {
    print(name);
}

    // string interpolation work 
    print("my name is ${name}");
    print("my name is $name and my age is $age");

    //explivite type
    int int_number = 222;
    double double_number = 222.3;
    print("number: $int_number and double is: $double_number");

    // we can do 
    const String myNmae = "dipu";
    print("my actual name is:  $myNmae");

    /*
null-safety
int is_null;
print(is_null) // we can't use here before assigning
TO byPass this we can do 
int? is_null_safe
print(is_null_safe) // now no error here 
*/
    // Function
    final greeting = greet("dinesh", 33);
    print(greeting);

    // named arguments
    // ? -> optional , nullable
    // required -> mot nullable
    // position of passing arugment not matter here 
    final anotherGreet =  ano_greet(age: 33, name: "dinesh");
    // final anotherGreet =  ano_greet(age: 33); // valid too
    print(anotherGreet);

    //LIST
    var list = [22, 33];
    var diff_type_list = [22, 33, "string", bool]; //valid
    print(diff_type_list); //valid

    list[0] = 34;
    print(list[0]); // 34

    // add new valie
   list.add(100); // [22, 33, 100]; 
    list.remove(22); // [33, 100];
    list.removeLast(); // remove last element

    List<int> only_int = [233, 22, 22,];
    print(only_int);

    Set<String> names = {"dipen", "Rohan"}; // can't contain dublicate
    print(names);   
    names.add("dipen"); // no error but it is not added 
    names.add("yeah"); //added
    names.remove(":dipen"); // it removed
    print(names.length); //print length


    //LIST ITERATION
    List<int> scores = [1, 4, 10, 20, 2,3,40];
    for (int score in scores) {
        print('the score is : $score');
    }
    //filtering
    for (int score in scores.where((s)=> s > 10)) {
        print('where : $score');
    }


    //MAP (key: value)
       var planate ={}; // emplty Map 
    // Map<typeofkey, typeofvalue> planate
    Map<String, String> fruits ={
        "first": "apple",
        "second": "banana",
    };
    //update 
    planate["second"] = "mango";
    
    print(planate.containsKey("second")); // return true
    print(planate.containsValue("banana")); // return true
    // remove 
    print(planate.remove("first")); // 

    //print true or false
    print(fruits); 
    // print(fruits[key]); // get value

    //CLASS
    var noodles = MenuItems("noodles", 150);
    var pizza = MenuItems("pizza", 199);

    var Pizzaa = Pizza(["veg", "chicken"], "veg calkano", 299);

    print("Item:  ${noodles.title} and price: ${noodles.price}");
    //works well
    // print(noodles.title);
    // print(noodles.price);
    print("Item:  ${pizza.title} and price: ${pizza.price}");

    print(noodles.format());
    print(pizza.format());


    var foods = Collection<MenuItems>(
        'menu Item',
        [noodles, pizza]
    );

    var random = foods.randomItem();
    print(random.format());


    //then 
    fetchPost().then((s){
        print(s.name);
        print(s.userId);
    });
    //async/await
    final post = await fetchPost();
    print(post.name);
}

class MenuItems {
    String title;
    int price;

    //Constructor
    MenuItems(this.title, this.price);

    //Method
    String format() {
        return "$title ---> $price";
    }    

}
//we can extends class to
class Pizza extends MenuItems {
    List<String> topping;

    //super wll direclty initial value in parent class
    Pizza(this.topping, super.title, super.price);
}  

//here T is dynamic type
class Collection<T> {
    String name;
    List<T> data;

    Collection(this.name, this.data);

   T randomItem() {
        data.shuffle(); // make the data random
        return data[0];
    }
}

//Future
Future<Post> fetchPost() {
    const delay = Duration(seconds: 3);

    return Future.delayed(delay, (){
        return Post("dinesh boro", 1288);
    });
}

class Post {
    String name;
    int userId;

    Post(this.name, this.userId);
}

String greet(String name, int age){
    return "Hi, my name is $name and age is $age";
}

String ano_greet({String? name, required int age}){
    return "Hi, my name is $name and age is $age";
}
