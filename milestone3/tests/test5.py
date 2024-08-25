def merge(nums : list[int] , start : int, mid : int, end : int, temp : list[int]) -> None:
    k : int = start
    i : int
    for i in range(start, end + 1):
        temp[i] = nums[i]

    left_index : int = start
    right_index : int = mid + 1
    current : int = start

    # Merge the temp arrays back into nums
    while left_index <= mid and right_index <= end:
        if temp[left_index] <= temp[right_index]:
            nums[current] = temp[left_index]
            left_index += 1
        else:
            nums[current] = temp[right_index]
            right_index += 1
        current += 1

    while left_index <= mid:
        nums[current] = temp[left_index]
        left_index += 1
        current += 1

def merge_sort(nums : list[int], start : int, end : int, temp : list[int]):
    if start < end:
        mid : int = (start + end)/2
        merge_sort(nums, start, mid, temp)
        merge_sort(nums, mid + 1, end, temp)
        merge(nums, start, mid, end, temp)

def print_list(arr : list[int], leng : int)-> None:
    i : int 
    for i in range(leng):
        print(arr[i])

def main():
    nums : list[int]= [38, 27, 43, 3, 9, 82, 10]
    leng : int = len(nums)
    print("Original list:\n")
    print_list(nums,leng)
    temp : list[int] = [0,0,0,0,0,0,0]
    merge_sort(nums, 0, leng - 1, temp)
    print("Sorted list:\n")
    print_list(nums,leng)

if __name__ == "__main__":
    main()
