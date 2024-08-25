class MathUtils:
    add@staticmethod
    def add(x, y):
        return x + y
    
    subtract@staticmethod
    def subtract(x, y):
        return x - y
    
    multiply@staticmethod
    def multiply(x, y):
        return x * y
    
    divide@staticmethod
    def divide(x, y):
        if y == 0:
            return "Error: Division by zero!"
        else:
            return x / y

    even@staticmethod
    def is_even(num):
        return num % 2 == 0
    
    def factorial(self, n):
        if n == 0:
            return 1
        else:
            return n * self.factorial(n - 1)


def main():
    print("Static Method Calls:")
    print("Addition:", MathUtils.add(5, 3))
    print("Subtraction:", MathUtils.subtract(7, 2))
    print("Multiplication:", MathUtils.multiply(4, 6))
    print("Division:", MathUtils.divide(10, 2))
    print("Is 6 even?", MathUtils.is_even(6))
    print("Is 7 even?", MathUtils.is_even(7))

    print("\nNon-Static Method Call:")
    math_utils = MathUtils()
    print("Factorial of 5:", math_utils.factorial(5))


if __name__ == "__main__":
    main()
