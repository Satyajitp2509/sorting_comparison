// quick_sort_demo.dart
import 'dart:math';

void main() {
  // Generate a random list of numbers
  final random = Random();
  final numbers = List.generate(20, (_) => random.nextInt(100));
  
  print('Original list: $numbers');
  
  // Create a copy to sort
  final sortedNumbers = List.of(numbers);
  quickSort(sortedNumbers);
  
  print('Sorted list:   $sortedNumbers');
  
  // Verify the sorting is correct
  final correctlySorted = _isSorted(sortedNumbers);
  print('Correctly sorted? $correctlySorted');
  
  // Benchmark performance
  final largeList = List.generate(10000, (_) => random.nextInt(100000));
  print('\nBenchmarking with 10,000 elements...');
  
  final stopwatch = Stopwatch()..start();
  quickSort(List.of(largeList));
  stopwatch.stop();
  
  print('Quick Sort completed in ${stopwatch.elapsedMilliseconds}ms');
}

/// Quick Sort implementation (ascending order)
void quickSort(List<int> list, [int low = 0, int? high]) {
  high ??= list.length - 1;
  if (low < high) {
    final pivotIndex = _partition(list, low, high);
    quickSort(list, low, pivotIndex - 1);
    quickSort(list, pivotIndex + 1, high);
  }
}

/// Partitioning with median-of-three optimization
int _partition(List<int> list, int low, int high) {
  // Median-of-three pivot selection
  final mid = low + (high - low) ~/ 2;
  _medianOfThree(list, low, mid, high);
  final pivotValue = list[mid];
  
  // Move pivot to end temporarily
  _swap(list, mid, high);
  
  int storeIndex = low;
  
  for (int i = low; i < high; i++) {
    if (list[i] < pivotValue) {
      _swap(list, storeIndex, i);
      storeIndex++;
    }
  }
  
  // Move pivot to final position
  _swap(list, storeIndex, high);
  return storeIndex;
}

/// Optimizes pivot selection to avoid worst-case O(n²)
void _medianOfThree(List<int> list, int a, int b, int c) {
  if (list[a] > list[b]) _swap(list, a, b);
  if (list[a] > list[c]) _swap(list, a, c);
  if (list[b] > list[c]) _swap(list, b, c);
}

/// Swaps elements in the list
void _swap(List<int> list, int i, int j) {
  final temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}

/// Helper function to check if list is sorted
bool _isSorted(List<int> list) {
  for (int i = 0; i < list.length - 1; i++) {
    if (list[i] > list[i + 1]) {
      return false;
    }
  }
  return true;
}
