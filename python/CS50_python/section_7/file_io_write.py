# open function, to open file programmatically so we can write to it or from it
# docs.python.org/3/library/functions.html#open


name = input("What's your name? ")

with open("names.txt", "a") as file:             # argument "w" to tell the function to open the file in a way that is going to allow me to change the content, "a" appends
    file.write(f"{name}\n")                      # if it does not exist, it is going open it for me
#file.close()                               # open returns a file handle - a special value that allows us to access that file subsequently
                                           # file.write() writes to a file
                                           # file.close() closes the file (saves the file)
                                           # with - in this context, i want you to open and automatically close some file


