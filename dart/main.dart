void main(List<String> args) async {
  // ==========================================
  // 1. VARIABLES & TYPE SYSTEM
  // ==========================================

  // 'var' - Dart infers type automatically (String)
  var name = "dinesh";

  // 'final' - Runtime constant (value set once, use for API responses)
  final age = 24;

  // 'const' - Compile-time constant (known before running)
  const isLogged = true;

  // Loop example
  for (var i = 0; i < 4; i++) {
    print(name);
  }

  // ==========================================
  // 2. STRING INTERPOLATION
  // ==========================================

  // Simple variable: just $
  print("My name is $name");

  // Expressions: use ${}
  print("My name is $name and my age is $age");
  print("Next year I'll be \${age + 1}"); // 25

  // ==========================================
  // 3. EXPLICIT TYPES
  // ==========================================

  int intNumber = 222;
  double doubleNumber = 222.3;
  print("Number: $intNumber, Double: $doubleNumber");

  // Combine const with explicit type
  const String myName = "dipu";
  print("My actual name is: $myName");

  // ==========================================
  // 4. NULL SAFETY (Dart 2.12+)
  // ==========================================

  // Non-nullable - MUST be initialized before use
  // int isNull; // ❌ Error: Non-nullable variable must be assigned

  // Nullable - can be null, marked with ?
  int? isNullSafe;
  print(isNullSafe); // null - no error

  // Null-aware operators
  String? maybeName;
  print(maybeName ?? "Unknown"); // "Unknown" (default if null)

  // Null assertion (!) - use only when sure it's not null
  maybeName = "Dinesh";
  print(maybeName!.toUpperCase()); // Safe now

  // ==========================================
  // 5. FUNCTIONS
  // ==========================================

  // Positional parameters
  final greeting = greet("dinesh", 33);
  print(greeting);

  // Named parameters - order doesn't matter!
  // ? = optional/nullable, required = must provide
  final anotherGreeting = anotherGreet(age: 33, name: "dinesh");
  print(anotherGreeting);

  // Can omit optional parameter
  final greetingNoName = anotherGreet(age: 25);
  print(greetingNoName); // name is null

  // Arrow syntax for single-line functions
  final sum = add(5, 3);
  print("Sum: $sum");

  // ==========================================
  // 6. COLLECTIONS
  // ==========================================

  // LIST - Ordered, allows duplicates, indexed
  var list = [22, 33];
  var mixedList = [22, 33, "string", true]; // Dynamic list (avoid in production)
  print(mixedList);

  // List operations
  list[0] = 34;           // Update: [34, 33]
  list.add(100);          // Append: [34, 33, 100]
  list.remove(34);      // Remove by value: [33, 100]
  list.removeLast();    // Remove last: [33]
  print("Final list: $list");

  // Typed list - preferred for type safety
  List<int> intOnlyList = [233, 22, 22];
  print(intOnlyList);

  // Collection for (spread operator)
  var moreNumbers = [1, 2, ...intOnlyList, 99]; // [1, 2, 233, 22, 22, 99]
  print(moreNumbers);

  // SET - Unordered, unique values only
  Set<String> names = {"dipen", "rohan"};
  names.add("dipen");   // Ignored - already exists
  names.add("yeah");    // Added
  names.remove("dipen"); // Removed
  print("Names: $names, Count: \${names.length}");

  // ==========================================
  // 7. LIST OPERATIONS (Higher-Order Functions)
  // ==========================================

  List<int> scores = [1, 4, 10, 20, 2, 3, 40];

  // for-in loop
  for (int score in scores) {
    print('Score: $score');
  }

  // where() - Filter
  var highScores = scores.where((s) => s > 10).toList();
  print("High scores: $highScores"); // [20, 40]

  // map() - Transform
  var doubled = scores.map((s) => s * 2).toList();
  print("Doubled: $doubled");

  // reduce() - Aggregate
  var total = scores.reduce((a, b) => a + b);
  print("Total: $total");

  // any() / every()
  print("Has score > 30? \${scores.any((s) => s > 30)}"); // true

  // ==========================================
  // 8. MAPS (Key-Value Pairs)
  // ==========================================

  // Empty map
  var emptyMap = <String, String>{};

  // Typed map
  Map<String, String> fruits = {
    "first": "apple",
    "second": "banana",
  };

  // Operations
  fruits["second"] = "mango";           // Update
  fruits["third"] = "orange";           // Add new

  print("Has 'second'? \${fruits.containsKey("second")}"); // true
  print("Has 'banana'? \${fruits.containsValue("banana")}"); // false (now mango)
  print("Removed: \${fruits.remove("first")}"); // Returns "apple"
  print("Fruits: $fruits");

  // Null-aware map access
  print(fruits["unknown"] ?? "Not found"); // "Not found"

  // ==========================================
  // 9. RECORDS (Dart 3.0+) - Multiple Returns
  // ==========================================

  var userRecord = getUserRecord();
  print("Name: \${userRecord.$1}, Age: \${userRecord.$2}");

  // Named records
  var namedRecord = (name: "Dinesh", age: 24, isActive: true);
  print("\${namedRecord.name} is \${namedRecord.age}");

  // ==========================================
  // 10. CLASSES & OOP
  // ==========================================

  // Basic class
  var noodles = MenuItem("noodles", 150);
  var pizza = MenuItem("pizza", 199);

  // Inheritance
  var vegPizza = Pizza(
    toppings: ["veg", "cheese"], 
    title: "veg calzone", 
    price: 299,
  );

  print("Item: \${noodles.title}, Price: ₹\${noodles.price}");
  print(noodles.format());
  print(pizza.format());
  print(vegPizza.format());
  print("Toppings: \${vegPizza.toppings}");

  // ==========================================
  // 11. GENERICS
  // ==========================================

  var foods = Collection<MenuItem>(
    'Menu Items',
    [noodles, pizza],
  );

  var randomFood = foods.randomItem();
  print("Random: \${randomFood.format()}");

  // Generic function
  var firstScore = firstElement<int>([10, 20, 30]);
  print("First: $firstScore");

  // ==========================================
  // 12. EXTENSION METHODS
  // ==========================================

  print("dinesh".capitalize()); // "Dinesh"
  print(123.formatCurrency());  // "₹123.00"

  // ==========================================
  // 13. ASYNCHRONOUS PROGRAMMING
  // ==========================================

  // Future with then() (callback style)
  fetchPost().then((post) {
    print("[Then] Name: \${post.name}, ID: \${post.userId}");
  });

  // async/await (preferred - cleaner)
  try {
    final post = await fetchPost();
    print("[Await] Name: \${post.name}, ID: \${post.userId}");
  } catch (e) {
    print("Error: $e");
  }

  // Multiple async operations
  final posts = await Future.wait([
    fetchPost(),
    fetchPost(),
  ]);
  print("Fetched \${posts.length} posts");

  // ==========================================
  // 14. STREAMS (Continuous data)
  // ==========================================

  await for (var count in countStream()) {
    print("Stream count: $count");
  }

  // ==========================================
  // 15. MIXINS (Code reuse)
  // ==========================================

  var logger = LoggerMixinExample();
  logger.log("Application started");
  logger.logError("Something went wrong");

  // ==========================================
  // 16. PATTERN MATCHING (Dart 3.0+)
  // ==========================================

  var result = calculate(10, 5, Operation.add);
  switch (result) {
    case Success(value: final val):
      print("Success: $val");
    case Failure(error: final err):
      print("Error: $err");
  }

  // ==========================================
  // 17. ENHANCED SWITCH (Dart 3.0+)
  // ==========================================

  var day = "Monday";
  var dayType = switch (day) {
    "Saturday" || "Sunday" => "Weekend",
    "Monday" || "Tuesday" || "Wednesday" || "Thursday" || "Friday" => "Weekday",
    _ => "Invalid",
  };
  print("$day is a $dayType");
}

// ==========================================
// FUNCTIONS
// ==========================================

/// Greet with positional parameters
String greet(String name, int age) {
  return "Hi, my name is $name and age is $age";
}

/// Greet with named parameters
/// - [name] is optional (nullable)
/// - [age] is required
String anotherGreet({String? name, required int age}) {
  return "Hi, my name is \${name ?? 'Anonymous'} and age is $age";
}

/// Arrow function for single expression
int add(int a, int b) => a + b;

// ==========================================
// RECORDS (Dart 3.0+)
// ==========================================

/// Returns a record with positional fields
(String name, int age) getUserRecord() {
  return ("Dinesh", 24);
}

// ==========================================
// CLASSES
// ==========================================

class MenuItem {
  final String title;
  final int price;

  /// Constructor with shorthand initialization
  MenuItem(this.title, this.price);

  /// Format item details
  String format() => "$title ---> ₹$price";

  @override
  String toString() => "MenuItem(title: $title, price: $price)";
}

/// Pizza extends MenuItem with additional toppings
class Pizza extends MenuItem {
  final List<String> toppings;

  /// super.title and super.price pass to parent constructor
  Pizza({
    required this.toppings,
    required super.title,
    required super.price,
  });

  @override
  String format() {
    return "\${super.format()} [\${toppings.join(', ')}]";
  }
}

// ==========================================
// GENERICS
// ==========================================

/// Generic collection class
class Collection<T> {
  final String name;
  final List<T> data;

  Collection(this.name, this.data);

  /// Returns random item from collection
  T randomItem() {
    if (data.isEmpty) throw StateError("Collection is empty");
    data.shuffle();
    return data.first;
  }

  int get length => data.length;
}

/// Generic function to get first element
T firstElement<T>(List<T> list) => list.first;

// ==========================================
// EXTENSION METHODS
// ==========================================

/// String extensions
extension StringExtensions on String {
  /// Capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Truncate with ellipsis
  String truncate(int maxLength) {
    return length > maxLength ? "\${substring(0, maxLength)}..." : this;
  }
}

/// Number extensions
extension NumberExtensions on num {
  /// Format as currency
  String formatCurrency() {
    return "₹\${toStringAsFixed(2)}";
  }
}

// ==========================================
// ASYNC / FUTURE
// ==========================================

/// Simulates fetching a post from API
Future<Post> fetchPost() async {
  const delay = Duration(seconds: 1);

  await Future.delayed(delay);

  // Simulate occasional error (10% chance)
  if (DateTime.now().millisecond % 10 == 0) {
    throw Exception("Network error");
  }

  return Post(name: "dinesh boro", userId: 1288);
}

/// Post model
class Post {
  final String name;
  final int userId;

  Post({required this.name, required this.userId});

  @override
  String toString() => "Post(name: $name, userId: $userId)";
}

// ==========================================
// STREAMS
// ==========================================

/// Generates a stream of integers
Stream<int> countStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i; // Emit value
  }
}

// ==========================================
// MIXINS
// ==========================================

/// Logger mixin for debugging
mixin Logger {
  void log(String message) {
    final timestamp = DateTime.now().toIso8601String();
    print("[\$timestamp] LOG: $message");
  }

  void logError(String error) {
    print("[ERROR] \${error.toUpperCase()}");
  }
}

class LoggerMixinExample with Logger {}

// ==========================================
// SEALED CLASSES & PATTERN MATCHING (Dart 3)
// ==========================================

/// Sealed class for operation results
sealed class Result<T> {}

class Success<T> extends Result<T> {
  final T value;
  Success(this.value);
}

class Failure<T> extends Result<T> {
  final String error;
  Failure(this.error);
}

enum Operation { add, subtract, multiply, divide }

/// Calculator with pattern matching
Result<double> calculate(double a, double b, Operation op) {
  try {
    final result = switch (op) {
      Operation.add => a + b,
      Operation.subtract => a - b,
      Operation.multiply => a * b,
      Operation.divide => b == 0 ? throw Exception("Division by zero") : a / b,
    };
    return Success(result);
  } catch (e) {
    return Failure(e.toString());
  }
}
