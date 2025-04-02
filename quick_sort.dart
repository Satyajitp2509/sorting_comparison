/// Quick Sort - Optimized implementation with median-of-three pivot selection
void quickSort(List<int> arr, [int low = 0, int? high]) {
  high ??= arr.length - 1;
  if (low < high) {
    // Partition the array and get the pivot index
    final pivotIndex = _partition(arr, low, high);
    
    // Recursively sort elements before and after partition
    quickSort(arr, low, pivotIndex - 1);
    quickSort(arr, pivotIndex + 1, high);
  }
}

/// Helper function to partition the array
int _partition(List<int> arr, int low, int high) {
  // Median-of-three pivot selection
  final mid = low + (high - low) ~/ 2;
  _medianOfThree(arr, low, mid, high);
  final pivot = arr[mid];
  
  // Move pivot to end temporarily
  _swap(arr, mid, high);
  
  int i = low - 1;
  
  for (int j = low; j < high; j++) {
    if (arr[j] < pivot) {
      i++;
      _swap(arr, i, j);
    }
  }
  
  // Move pivot to its correct position
  _swap(arr, i + 1, high);
  return i + 1;
}

/// Optimizes pivot selection to avoid worst-case O(n²) scenarios
void _medianOfThree(List<int> arr, int low, int mid, int high) {
  if (arr[low] > arr[mid]) _swap(arr, low, mid);
  if (arr[low] > arr[high]) _swap(arr, low, high);
  if (arr[mid] > arr[high]) _swap(arr, mid, high);
}

/// Helper function to swap elements
void _swap(List<int> arr, int i, int j) {
  final temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}
