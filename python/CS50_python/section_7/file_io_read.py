# with open("names.txt", "r") as file:
#     lines = file.readlines()            # read all lines at once, return as a list

# for line in lines:
#     print("hello,", line.rstrip())

with open("names.txt", "r") as file:
    for line in file:
        print("hello,", line.rstrip())

