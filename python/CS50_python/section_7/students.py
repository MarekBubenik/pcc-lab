# with open("students.csv") as file:
#     for line in file:
#         row, house = line.rstrip().split(",")
#         print(f"{row} is in {house}")
import csv
students = []

with open("new_students.csv") as file:
    # reader = csv.reader(file)                       # function reader, purpose is to read a CSV and figure out, where are the commas, where are the quotes ...
    # for row in reader:                              # reader returns a list, instead of a line
    #     students.append({"name": row[0], "home": row[1]})

    reader = csv.DictReader(file)                       # DictReader iterate over a file, top to bottom, loading each line of text, not as a list of columns but as a dictionary of columns
    for row in reader:                                  # return dictionary, one at a time, 
        students.append({"name": row["name"], "home": row["home"]})

    # for line in file:
        # name, home = line.rstrip().split(",")      # stripping white space, splitting it on a comma
        # student = {}                                # store all the info, empty dictionary
        # student["name"] = name
        # student["house"] = house
        # student = {"name": name, "home": home}
        # students.append(student)

# def get_name(student):
#     return student["name"]

# for student in sorted(students, key=get_name):      # python allow to pass functions as arguments into other functions, sort by students name
#     print(f"{student['name']} is in {student['house']}")
#

for student in sorted(students, key=lambda student: student["name"]):   # same as / lambda -> function that has no name, anonymus
    print(f"{student['name']} is from {student['home']}")               # lambda func takes a parametr student, then it returns a string from a dictionary

