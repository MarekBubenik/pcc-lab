# Ask user for their name
name = input("What's your name? ").strip().title()

# Remove whitespace from str
#name = name.strip()
# Capitalize user's name
#name = name.capitalize()
#name = name.title()

# Remove white space from str and capitalize user's name
#name = name.strip().title()

# Split user's name into first name and last name
first, last = name.split(" ")

# Say hello to user
print("hello, " + name)
print("hello,", name)

print("Hello,", last)

#print("Hello ,", end="")
#print(name)

#print(*objects, sep='', end='\n', file=sys.stdout, flush=False)

#print('Hello, "friend"')
#print("Hello, \"friend\"")
#print(f"Hello, {name}")