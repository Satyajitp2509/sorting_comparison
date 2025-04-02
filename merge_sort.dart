/// Merge Sort - Stable implementation with O(n) space complexity
void mergeSort(List<int> arr) {
  if (arr.length <= 1) return;
  
  // Create temporary buffer once to avoid repeated allocations
  final buffer = List<int>.filled(arr.length, 0);
  _mergeSortHelper(arr, 0, arr.length - 1, buffer);
}

/// Recursive helper function
void _mergeSortHelper(List<int> arr, int low, int high, List<int> buffer) {
  if (low >= high) return;
  
  final mid = low + (high - low) ~/ 2;
  
  // Recursively sort both halves
  _mergeSortHelper(arr, low, mid, buffer);
  _mergeSortHelper(arr, mid + 1, high, buffer);
  
  // Merge the sorted halves
  _merge(arr, low, mid, high, buffer);
}

/// Merges two sorted subarrays
void _merge(List<int> arr, int low, int mid, int high, List<int> buffer) {
  // Copy both halves to the buffer
  for (int i = low; i <= high; i++) {
    buffer[i] = arr[i];
  }
  
  int i = low, j = mid + 1, k = low;
  
  // Merge by comparing elements from both halves
  while (i <= mid && j <= high) {
    if (buffer[i] <= buffer[j]) {
      arr[k++] = buffer[i++];
    } else {
      arr[k++] = buffer[j++];
    }
  }
  
  // Copy remaining elements from left half
  while (i <= mid) {
    arr[k++] = buffer[i++];
  }
}
