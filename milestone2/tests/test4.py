class A:
    def method_A(self):
        print("Method from class A")

class B(A):
    def method_B(self):
        print("Method from class B")

class C(B):
    def method_C(self):
        print("Method from class C")

def main():
    num1 : int = 10
    num2 : float  = 5
    #List
#Implicit line joining
    numbers : list[int] = [1, 2, 3,
            4, 5, 6,
            7, 8, 9]

# Explicit line joining:
    result : float = 10 + \
            20 + \
            30
    
    print("Arithmetic Operations:")\
        # Arithmetic operations
#passed here
    print(num1 + num2)
    print(num1 - num2)
    print(num1 * num2)
    print(num1 / num2)
    print(num1 % num2)
    print(result)

    # Control flow statements
    print("Control Flow Statements:")
    if num1 > num2:
        print("num1 is greater than num2")
    elif num1 == num2:
        print("num1 is equal to num2")
    else:
        print("num1 is less than num2")

    # Accessing list elements
    print("\nList Elements:")
    i:int
    for i in range(9):
        a : int = numbers[i]
        if(a==4):
            break
        print(a)

    # Multiple inheritance
    obj_c : C = C()
    obj_c.method_A()
    obj_c.method_B()
    obj_c.method_C()

if __name__ == "__main__":
    main()
