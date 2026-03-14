import 'dart:async';

class Calculator {
  final String name;
  
  List<String> _history = [];
  
  Calculator(this.name);
  
  double add(double a, double b) => a + b;
  
  double subtract(double a, double b) {
    return a - b;
  }
  
  double multiply(double a, double b) {
    return a * b;
  }
  
  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return a / b;
  }
  
  Future<double> computeAsync(double a, double b, String op) async {
    double result;
    
    switch (op) {
      case 'add':
        result = add(a, b);
        break;
      case 'subtract':
        result = subtract(a, b);
        break;
      case 'multiply':
        result = multiply(a, b);
        break;
      case 'divide':
        result = divide(a, b);
        break;
      default:
        throw UnknownOperationException('Unknown operation: $op');
    }
    
    await Future.delayed(const Duration(milliseconds: 1500));
    return result;
  }
  
  Future<void> displayResult(double a, double b, String op) async {
    try {
      final result = await computeAsync(a, b, op);
      final message = '${op}($a, $b) = $result';
      print(message);
      
    _history.add(message);
    } catch (e) {
      print('Error: $e');
    }
  }
  
  void printHistory() {
    print('\n--- Calculation History ---');
    for (String record in _history) {
      print(record);
    }
  }
  
  Future<double> computeChained(List<double> values, String op) async {
    if (values.isEmpty) throw ArgumentError('Values list cannot be empty');
    
    double result = values.first;
    
    for (int i = 1; i < values.length; i++) {
      result = await computeAsync(result, values[i], op);
    }
    
    return result;
  }
}

class UnknownOperationException implements Exception {
  final String message;
  UnknownOperationException(this.message);
  
  @override
  String toString() => message;
}

Future<void> main() async {
  final calc = Calculator('MyCalculator');
  print('--- ${calc.name} ---');
  
  // Sequential calculations (required for the main task)
  await calc.displayResult(10, 4, 'add');
  await calc.displayResult(10, 4, 'subtract');
  await calc.displayResult(10, 4, 'multiply');
  await calc.displayResult(10, 4, 'divide');
  await calc.displayResult(15, 3, 'divide');
  await calc.displayResult(10, 0, 'divide'); // Test error
  
  print('All calculations complete.\n');
  
  calc.printHistory();
  
  print('\n--- Chained Operations ---');
  final chainedSum = await calc.computeChained([1, 2, 3, 4], 'add');
  print('Chained sum of [1,2,3,4] = $chainedSum');
  
  print('\n--- Parallel Calculations ---');
  final stopwatch = Stopwatch()..start();
  
  final futures = [
    calc.displayResult(20, 5, 'add'),
    calc.displayResult(20, 5, 'subtract'),
    calc.displayResult(20, 5, 'multiply'),
    calc.displayResult(20, 5, 'divide'),
  ];
  
  await Future.wait(futures);
  stopwatch.stop();
  
  print('Parallel calculations completed in ${stopwatch.elapsedMilliseconds}ms');
  print('(This is faster than sequential because all 1.5s delays run concurrently)');
}

/*
Q6. What is the difference between a synchronous function and an asynchronous function 
in Dart? In your Calculator class, why is divide() synchronous while computeAsync() is 
asynchronous?

A synchronous function executes all its operations immediately and blocks the program 
until it completes. The caller must wait for the result before continuing. An 
asynchronous function, marked with the 'async' keyword, returns a Future and allows 
the program to continue executing other code while waiting for long-running operations 
to complete.

In my Calculator class, divide() is synchronous because it performs a simple, 
instantaneous mathematical operation that doesn't need to wait for any external 
resources. It completes immediately and returns the result. computeAsync() is 
asynchronous because it simulates a network delay using Future.delayed() - this 
represents a real-world scenario where calculations might need to be fetched from a 
server, read from a database, or require other I/O operations that take time. Making 
it asynchronous prevents the app from freezing during these waiting periods.

Q7. Explain the purpose of the await keyword in Dart. What happens if you forget to use 
await when calling an async function that returns a Future? What does your program 
print instead of the result?

The await keyword tells Dart to pause execution of the current function until the 
Future completes and returns its actual value. It can only be used inside async 
functions and allows you to write asynchronous code that reads like synchronous code.

If you forget to use await when calling an async function, the program doesn't wait 
for the Future to complete. Instead of receiving the computed value (like 14.0), the 
variable would receive a Future object (like Instance of 'Future<double>'). If you 
tried to print this, you'd see something like "Future<double>" rather than the actual 
result, and the calculation would likely complete after your program had already 
moved on.

Q8. What is the purpose of the try-catch block in your displayResult() method? What 
would happen if you removed it and then called displayResult(10, 0, 'divide')?

The try-catch block in displayResult() serves as error handling mechanism that 
gracefully manages exceptions thrown during asynchronous computation. It catches any 
errors that occur in computeAsync() or the underlying arithmetic methods and prints 
a user-friendly error message instead of crashing the program.

If the try-catch block were removed when calling displayResult(10, 0, 'divide'), the 
ArgumentError thrown by divide() would propagate up the call stack. Since there's no 
error handler, this would cause the entire program to terminate with an uncaught 
exception, displaying a red error message in DartPad and stopping execution of any 
remaining code. This would provide a poor user experience and could crash the app 
in a real Flutter application.

Q9. Why is it good design to have divide() throw an ArgumentError rather than simply 
returning 0 or printing an error inside the divide() method itself? What principle of 
function design does this reflect?

Having divide() throw an ArgumentError rather than handling the error internally 
reflects the Single Responsibility Principle (SRP) from SOLID design principles. The 
divide() method should have one job: perform division and return a result. Error 
handling and user communication are separate responsibilities.

If divide() returned 0 or printed an error message, it would: 1) Hide the fact that 
an error occurred from the calling code, 2) Return an incorrect mathematical result 
(0 is not the same as "undefined"), 3) Violate separation of concerns by mixing 
calculation logic with user interface concerns. By throwing an exception, divide() 
properly signals that an exceptional condition occurred, and lets the calling code 
decide how to handle it - whether to show an error message, try alternative 
calculations, or log the error.

Q10. What does the async keyword on main() allow you to do? Could this assignment have 
been written without making main() async? Explain your answer.

The async keyword on main() allows us to use await inside the main function to wait 
for asynchronous operations like displayResult() and computeAsync() to complete. 
Without marking main() as async, we couldn't use await and would have to handle 
Futures differently.

This assignment technically could be written without making main() async, but it 
would require using .then() callbacks on the Futures instead of await. For example:
calc.displayResult(10, 4, 'add').then((_) => 
  calc.displayResult(10, 4, 'subtract')
);
However, this would lead to deeply nested "callback hell" code that's harder to read, 
maintain, and debug. The async/await syntax provides cleaner, more readable code 
that closely resembles synchronous code while maintaining all the benefits of 
asynchronous execution. Therefore, while possible to write without async main, using 
it is considered best practice in modern Dart development.
*/
