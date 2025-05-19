WORDS = {"PAIR": 4, "HAIR": 4, "CHAIR": 5, "GRAPHIC": 7}

def main():
    print("Welcome to Spelling Bee!")
    print("Your letters are: A I P C R H G")

    while len(WORDS) > 0:
        print(f"{len(WORDS)} words left!")
        guess = input("Guess a word: ")

        # Check if guess in dictionary, .clear() removes all keys in a dictionary
        if guess == "GRAPHIC":
            WORDS.clear()
            print("You've won!")

        # .pop() removes the key from the dictionary
        if guess in WORDS.keys():
            points = WORDS.pop(guess)
            print(f"Good job! You scored {points} points.")

    print("That's the game!")

def reiterate():
    print("Here is a list of words and their worth in points!")
    for word, points in WORDS.items():
        print(f"{word} is worth {points} points.")

#main()
reiterate()