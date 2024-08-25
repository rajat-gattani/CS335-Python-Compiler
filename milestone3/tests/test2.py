#Final2 HeapSort
def heapify(arr: list[int], n: int, i: int) -> None:
    largest: int = i  # Initialize largest as root
    l: int = 2 * i + 1  # left = 2*i + 1
    r: int = 2 * i + 2  # right = 2*i + 2

    # Check if left child of root exists and is greater than root
    if l < n and arr[l] > arr[largest]:
        largest = l

    # Check if right child of root exists and is greater than the largest so far
    if r < n and arr[r] > arr[largest]:
        largest = r

    # Change root, if needed
    if largest != i:
        temp: int
        temp = arr[i]
        arr[i] = arr[largest]
        arr[largest] = temp # Swap
        # Heapify the root
        heapify(arr, n, largest)

def heap_sort(arr: list[int]) -> None:
    n: int = len(arr)

    # Build a maxheap
    i:int
    for i in range(0, n // 2):
        j : int = n//2 - 1 - i
        heapify(arr, n, j)

    # Extract elements one by one
    for i in range(0,n-1):
        j = n-1-i
        temp: int
        temp = arr[0]
        arr[0] = arr[j]
        arr[j] = temp # Swap
        heapify(arr, j, 0)

def printArray(l : list[int]):
    i : int
    for i in range(len(l)):
        print(l[i])
        
# Example usage:
def main():
    arr: list[int] = [12, -11, 13, -5, 6, 7]
    heap_sort(arr)
    printArray(arr)

if __name__ == "__main__":
    main()
