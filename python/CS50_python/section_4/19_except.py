def main():
    x = get_int("What's x? ")
    print(f"x is {x}")

def get_int(prompt):
    while True:
        try:
            x = int(input(prompt))    #return int(input("What's x? "))
            #return x
        except ValueError:
            print("x is not an integer")
            #pass                           # pass the exception but dont wanna do anything with it
        else:
            #break
            return x
    #return x
                                        
main()