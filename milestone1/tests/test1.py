def factorial(n):
    """Recursive function to calculate the factorial of a number."""
    if n == 0:
        return 1
    else:
        return n * factorial(n - 1)

def fibonacci(n):
    """Recursive function to calculate the nth Fibonacci number."""
    if n <= 1:
        return n
    else:
        return fibonacci(n - 1) + fibonacci(n - 2)

def is_palindrome(s):
    """Recursive function to check if a string is a palindrome."""
    if len(s) <= 1:
        return True
    elif s[0] != s[-1]:
        return False
    else:
        return is_palindrome(s[1:-1])

def main():
    while True:
        print("\nRecursive Functions Demo")
        print("1. Calculate factorial")
        print("2. Calculate nth Fibonacci number")
        print("3. Check if a string is a palindrome")
        print("4. Quit")
        
        choice = input("Enter your choice (1-5): ")
        
        if choice == '1':
            num = int(input("Enter a non-negative integer: "))
            if num < 0:
                print("Error: Please enter a non-negative integer.")
            else:
                result = factorial(num)
                print(f"The factorial of {num} is: {result}")
        elif choice == '2':
            num = int(input("Enter the value of n for Fibonacci sequence: "))
            if num < 0:
                print("Error: Please enter a non-negative integer.")
            else:
                result = fibonacci(num)
                print(f"The {num}th Fibonacci number is: {result}")
        elif choice == '3':
            string = input("Enter a string: ")
            if is_palindrome(string):
                print("The string is a palindrome.")
            else:
                print("The string is not a palindrome.")
        elif choice == '4':
            x=y
            print("Exiting program. Goodbye!")
            break
        else:
            print("Invalid choice. Please enter a valid option.")

if __name__ == "__main__":
    main()
