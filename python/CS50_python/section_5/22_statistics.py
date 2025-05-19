#import statistics
import sys          # python3 hello.py argv # command-line arguments
                    # docs.python.org/3/library/sys.html

#print(statistics.mean([100, 90]))
# try:
#     print("hello, my name is", sys.argv[1])     # the [0] is the name of the program
# except IndexError:
#     print("Too few arguments")

# # Check for errors
# if len(sys.argv) < 2:
#     sys.exit("Too few arguments")
# elif len(sys.argv) > 2:
#     sys.exit("Too many arguments")

# # Print name
# print("hello, my name is", sys.argv[1]) 

# Check for errors
if len(sys.argv) < 2:
    sys.exit("Too few arguments")

for arg in sys.argv[1:]:                             # slices, subset of a list / [] includes start and end of the list, no number after : means to the end
    print("hello, my name is", arg)                