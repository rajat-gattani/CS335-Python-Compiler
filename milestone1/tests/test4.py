class Student:
    def __init__(self, name, age, grade):
        self.name = name
        self.age = age
        self.grade = grade

    def display_info(self):
        print("Name: {self.name}")
        print("Age: {self.age}")
        print("Grade: {self.grade}")

    def update_grade(self, new_grade):
        self.grade = new_grade

    def update_age(self, new_age):
        self.age = new_age

    def calculate_birth_year(self, current_year):
        birth_year = current_year - self.age
        return birth_year


def main():
    student1 = Student("Alice", 17, "12th")
    student2 = Student("Bob", 16, "11th")

    print("Initial Student Information:")
    print("\nStudent 1:")
    student1.display_info()

    print("\nStudent 2:")
    student2.display_info()

    print("\nUpdating Student Information:")
    student1.update_grade("11th")
    student2.update_age(17)

    print("\nUpdated Student Information:")
    print("\nStudent 1:")
    student1.display_info()

    print("\nStudent 2:")
    student2.display_info()

    current_year = 2024
    print("\nCalculating Birth Year:")
    print("\nStudent 1's birth year:", student1.calculate_birth_year(current_year))
    print("Student 2's birth year:", student2.calculate_birth_year(current_year))


if __name__ == "__main__":
    main()
