def main():
    height = int(input("Height: "))
    pyramid(height)

def pyramid(n):
    for i in range(n):
        # print(i, end=" ")
        # print("#" * (i + 1)
        print("#" * i)

if __name__ == "__main__":
    main()

# breakpoints (red dot on left)
# step over (let the function/code execute), step in(to) function...