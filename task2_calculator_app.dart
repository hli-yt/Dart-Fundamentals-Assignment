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
