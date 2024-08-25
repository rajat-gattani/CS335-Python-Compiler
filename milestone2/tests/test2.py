class Animal:
    def __init__(self, species : str):
        self.species : str = species

class Mammal(Animal):
    def __init__(self, species : str, sound : str):
        Animal.__init__(self, species)
        self.sound : str = sound

    def speak(self):
        return "A " + self.species + " makes " + self.sound + " sound."


class Dog(Mammal):
    def __init__(self, breed : str, sound : str):
        Mammal.__init__(self, "dog", sound)
        self.breed : str = breed

    def speak(self):
        return "A " + self.breed + " " + self.species + " makes " + self.sound + "."


class Cat(Mammal):
    def __init__(self, breed : str, sound : str):
        Mammal.__init__(self, "cat", sound)
        self.breed : str = breed

    def speak(self):
        return "A " + self.breed + " " + self.species + " makes " + self.sound + "."


def main():
    dog : Dog = Dog("Golden Retriever","bark")
    cat : Cat = Cat("Siamese","meow")

    a : str = dog.speak()
    b : str = cat.speak()

    print(a)
    print(b)


if __name__ == "__main__":
    main()
