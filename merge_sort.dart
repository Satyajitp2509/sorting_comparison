// merge_sort_demo.dart
import 'dart:math';

void main() {
  // Generate a random list of numbers
  final random = Random();
  final numbers = List.generate(20, (_) => random.nextInt(100));
  
  print('Original list: $numbers');
  
  // Create a copy to sort
  final sortedNumbers = List.of(numbers);
  mergeSort(sortedNumbers);
  
  print('Sorted list:   $sortedNumbers');
  
  // Verify the sorting is correct
  final correctlySorted = _isSorted(sortedNumbers);
  print('Correctly sorted? $correctlySorted');
  
  // Benchmark performance
  final largeList = List.generate(10000, (_) => random.nextInt(100000));
  print('\nBenchmarking with 10,000 elements...');
  
  final stopwatch = Stopwatch()..start();
  mergeSort(List.of(largeList));
  stopwatch.stop();
  
  print('Merge Sort completed in ${stopwatch.elapsedMilliseconds}ms');
}

/// Merge Sort implementation (ascending order)
void mergeSort(List<int> list) {
  if (list.length <= 1) return;
  
  // Temporary buffer for merging
  final buffer = List<int>.filled(list.length, 0);
  _mergeSortHelper(list, 0, list.length - 1, buffer);
}

/// Recursive helper function
void _mergeSortHelper(List<int> list, int low, int high, List<int> buffer) {
  if (low >= high) return;
  
  final mid = low + (high - low) ~/ 2;
  
  // Recursively sort both halves
  _mergeSortHelper(list, low, mid, buffer);
  _mergeSortHelper(list, mid + 1, high, buffer);
  
  // Merge the sorted halves
  _merge(list, low, mid, high, buffer);
}

/// Merges two sorted subarrays
void _merge(List<int> list, int low, int mid, int high, List<int> buffer) {
  // Copy both halves to the buffer
  for (int i = low; i <= high; i++) {
    buffer[i] = list[i];
  }
  
  int leftIndex = low;
  int rightIndex = mid + 1;
  int current = low;
  
  // Merge by comparing elements
  while (leftIndex <= mid && rightIndex <= high) {
    if (buffer[leftIndex] <= buffer[rightIndex]) {
      list[current++] = buffer[leftIndex++];
    } else {
      list[current++] = buffer[rightIndex++];
    }
  }
  
  // Copy remaining left elements
  while (leftIndex <= mid) {
    list[current++] = buffer[leftIndex++];
  }
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
