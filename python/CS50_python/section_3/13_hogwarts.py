#students = ["Hermione","Harry", "Ron"]
# # print(students[0])
# for student in students:
#     print(student)

# for i in range(len(students)):      # len = length
#     print(i, students[i])

#houses = ["Gryffindor", "Gryffindor", "Gryffindor", "Slytherin"]

# .remove("Bowser")     - remove the value from list
# .insert(0, "Bowser")  - put value to first index (zero)
# .reverse()            - reverse the order of the list  
# .append("Yoshi")      - add the value at the end of the list

# import sys
# coordinate_tuple = (42.376, -71.115)                  - use tuple if you do not change the value at all
# coordinate_list = [42.376, -71.115]                   - use list if you change the value(s)
# print(f"{sys.getsizeof(coordinate_tuple)} bytes")     - difference is in amount of bytes stored in memory
# print(f"{sys.getsizeof(coordinate_list)} bytes")

students = {
    "Hermione": "Gryffindor",
    "Harry":"Gryffindor",
    "Ron":"Gryffindor",
    "Draco":"Slytherin"
}                                   # dictionary, associate it with something, indexes are literal, not numeric as opose to list

# print(students["Draco"])
# print(students["Harry"])
# print(students["Ron"])

for student in students:
    print(student, students[student], sep=", ")
