class Student:
    def __init__(self, name : str , age : int , grade : str):
        self.name : str = name
        self.age : int = age
        self.grade : str = grade

    def display_info(self):
        print("Name")
        print("Age")
        print("Grade")

    def update_grade(self, new_grade:str):
        self.grade : str = new_grade

    def update_age(self, new_age:int):
        self.age : int = new_age

    def calculate_birth_year(self, current_year:int):
        birth_year : int = current_year - self.age
        return birth_year


def main():
    student1 : Student = Student("Alice", 17, "12th")
    student2 : Student = Student("Bob", 16, "11th")

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

    current_year : int = 2024
    print("\nCalculating Birth Year:")
    year1 : int = student1.calculate_birth_year(current_year)
    year2 : int = student2.calculate_birth_year(current_year)

    print(year1)
    print(year2)

if __name__ == "__main__":
    main()
