int findMax(List<int> numbers) {
  if (numbers.isEmpty) {
    print('List is empty');
    return -1;   }
  
  // Initial max with the first element
  int max = numbers[0];
  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] > max) {
      max = numbers[i];
    }
  }
  return max;
}

int findMin(List<int> numbers) {
  if (numbers.isEmpty) {
    print('List is empty');
    return -1;
  }
  
  // Initial min with the first element
  int min = numbers[0];
  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] < min) {
      min = numbers[i];
    }
  }
  return min;
}

int calculateSum(List<int> numbers) {
  if (numbers.isEmpty) {
    print('Error: Cannot calculate sum of an empty list');
    return 0;
  }
  
  int sum = 0;
  
  // Using for-in loop to iterate through all elements
  for (int number in numbers) {
    sum += number;
  }
  return sum;
}

double calculateAverage(List<int> numbers) {
  if (numbers.isEmpty) {
    print('Error: Cannot calculate average of an empty list');
    return 0.0; 
  }
  
  int sum = calculateSum(numbers);
  
  double average = sum / numbers.length;
  return average;
}

int countNegatives(List<int> numbers) {
  int count = 0;
  for (int number in numbers) {
    if (number < 0) {
      count++;
    }
  }
  return count;
}

List<int> sortAscending(List<int> numbers) {
  List<int> sorted = List.from(numbers);
  
  for (int i = 0; i < sorted.length - 1; i++) {
    for (int j = 0; j < sorted.length - i - 1; j++) {
      if (sorted[j] > sorted[j + 1]) {
        int temp = sorted[j];
        sorted[j] = sorted[j + 1];
        sorted[j + 1] = temp;
      }
    }
  }
  return sorted;
}

int findMaxBuiltIn(List<int> numbers) {
  if (numbers.isEmpty) return -1;
  return numbers.reduce((curr, next) => curr > next ? curr : next);
}

int findMinBuiltIn(List<int> numbers) {
  if (numbers.isEmpty) return -1;
  return numbers.reduce((curr, next) => curr < next ? curr : next);
}

int calculateSumBuiltIn(List<int> numbers) {
  return numbers.fold(0, (sum, element) => sum + element);
}

double calculateAverageBuiltIn(List<int> numbers) {
  if (numbers.isEmpty) return 0.0;
  return numbers.reduce((a, b) => a + b) / numbers.length;
}

void main() {
  final numbers = <int>[34, -7, 89, 12, -45, 67, 3, 100, -2, 55];
  
  int maxValue = findMax(numbers);
  int minValue = findMin(numbers);
  int sum = calculateSum(numbers);
  double average = calculateAverage(numbers);
  
  int negativeCount = countNegatives(numbers);
  
  List<int> sortedNumbers = sortAscending(numbers);
  
  print('Number Analysis Results');
  print('Numbers: $numbers');
  print('Maximum value : $maxValue');
  print('Minimum value : $minValue');
  print('Sum : $sum');
  print('Average : $average');
  
 
  print('\n--- Bonus Features ---');
  print('Negative count: $negativeCount');
  print('Sorted ascending: $sortedNumbers');
  
}