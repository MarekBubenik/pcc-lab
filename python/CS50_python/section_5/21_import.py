import random

# coin = random.choice(["heads", "tails"])

# print(coin)

# from random import choice
# from random import randint

cards = ["jack", "queen", "king"]
coin = random.choice(["heads", "tails"])
number = random.randint(1, 10)
random.shuffle(cards)

for card in cards:
    print(card)

print(coin)
print(number)

