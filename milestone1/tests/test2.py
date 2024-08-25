class Animal:
    def __init__(self, species):
        self.species = species

    def speak(self):
        pass  # To be implemented by subclasses


class Mammal(Animal):
    def __init__(self, species, sound):
        Animal.__init__(self, species)
        self.sound = sound

    def speak(self):
        return "A " + self.species + " makes " + self.sound + " sound."


class Dog(Mammal):
    def __init__(self, breed, sound="bark"):
        Mammal.__init__(self, "dog", sound)
        self.breed = breed

    def speak(self):
        return "A " + self.breed + " " + self.species + " makes " + self.sound + "."


class Cat(Mammal):
    def __init__(self, breed, sound="meow"):
        Mammal.__init__(self, "cat", sound)
        self.breed = breed

    def speak(self):
        return "A " + self.breed + " " + self.species + " makes " + self.sound + "."


def main():
    dog = Dog("Golden Retriever")
    cat = Cat("Siamese")

    print(dog.speak())
    print(cat.speak())


if __name__ == "__main__":
    main()
