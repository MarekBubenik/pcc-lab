# def - define a function
# : meaning everything under it is past of a function
# def hello(to="world"): # when not inputed, world will be printed
#     print("hello,", to)

# name = input("What's your name? ")    
# hello(name) # name is copied to to variable, same 

def main():
    name = input("What's your name? ")
    hello(name)

def hello(to="world"):
    print("hello,", to)

main()
