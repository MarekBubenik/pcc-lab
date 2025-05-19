import csv

name = input("What's your name? ")
home = input("What's your home? ")

# with open("csv_students.csv", "a") as file:
#     writer = csv.writer(file)
#     writer.writerow([name, home])

with open("csv_students.csv", "a") as file:
    writer = csv.DictWriter(file, fieldnames=["name", "home"])
    writer.writerow({"name": name, "home": home})