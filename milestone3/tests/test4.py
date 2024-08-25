class Animal:
    def __init__(self, name : str, age: int):
        self.name : str= name
        self.age : int = age

    def make_sound(self):
        print("Generic animal sound\n")

    def describe(self):
        print("Name:")
        print(self.name)
        print("Age:")
        print(self.age)


class Dog(Animal):
    def __init__(self, name : str, age : int, breed : str):
        Animal.__init__(self, name, age)
        self.breed : str= breed

    def make_sound(self):
        print("Woof!\n")

    def describe(self):
        print("Name:")
        print(self.name)
        print("Age:")
        print(self.age)
        print("Breed:")
        print(self.breed)


class Cat(Animal):
    def __init__(self, name: str, age: int, color: str):
        Animal.__init__(self, name, age)
        self.color: str = color

    def make_sound(self):
        print("Meow!\n")

    def describe(self):
        print("Name:")
        print(self.name)
        print("Age:")
        print(self.age)
        print("Color:")
        print(self.color)


class Kitten(Cat):
    def __init__(self, name : str, age : int , color : str):
        Cat.__init__(self, name, age, color)

    def make_sound(self):
        print("Kitten sounds!\n")

    # The describe() method is inherited from the Cat class


class Puppy(Dog):
    def __init__(self, name : str, age : int, breed : str):
        Dog.__init__(self, name, age, breed)

    def make_sound(self):
        print("Puppy sounds!\n")

    # The describe() method is inherited from the Dog class
def main():
# Test cases
    dog1:Dog = Dog("Buddy", 3, "Labrador")
    cat1:Cat = Cat("Whiskers", 2, "Calico")
    puppy1:Puppy = Puppy("Max", 1, "Golden Retriever")
    kitten1:Kitten = Kitten("Fluffy", 1, "White")
    dog1.make_sound()
    dog1.describe()
    cat1.make_sound()
    cat1.describe()
    kitten1.make_sound()
    kitten1.describe()
    puppy1.make_sound()
    puppy1.describe()
    
if __name__ == "__main__":
    main()
