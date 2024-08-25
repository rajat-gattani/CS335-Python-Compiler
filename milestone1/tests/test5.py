class A:
    def method_A(self):
        print("Method from class A")

class B:
    def method_B(self):
        print("Method from class B")

class C(A, B):
    def method_C(self):
        print("Method from class C")

def main():
    num1 = 10
    num2 = 5
    #List
#Implicit line joining
    numbers = [1, 2, 3,
            4, 5, 6,    #comment can be here
            7, 8, 9]

# Explicit line joining:
    result = 10 + \
            20 + \
            30
    
    print("Arithmetic Operations:")\
        # Arithmetic operations
#passed here
    print("Addition:", num1 + num2)
    print("Subtraction:", num1 - num2)
    print("Multiplication:", num1 * num2)
    print("Division:", num1 / num2)
    print("Modulus:", num1 % num2)

    # Control flow statements
    print("\nControl Flow Statements:")
    if num1 > num2:
        print("num1 is greater than num2")
    elif num1 == num2:
        print("num1 is equal to num2")
    else:
        print("num1 is less than num2")

    # Accessing list elements
    print("\nList Elements:")
    for num in numbers:
        print(num)

    # Multiple inheritance
    obj_c = C()
    obj_c.method_A()
    obj_c.method_B()
    obj_c.method_C()

if __name__ == "__main__":
    main()
