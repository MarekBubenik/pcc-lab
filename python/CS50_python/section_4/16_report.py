def main():
    spacecraft = {"name": "Voyager 1", "distance": 163}
    spacecraft["fuel"] = "grass"
    spacecraft.update({"orbit": "Sun"})         # .update({}) adds a key/value into a dictionary
    print(create_report(spacecraft))

def create_report(spacecraft):                  # {"string", "Unknown" } -> a string after , can used to print if the retrieved value does not exist 
    return f"""
    ========= REPORT ========

    Name: {spacecraft["name"]}
    Distance: {spacecraft["distance"]}
    Fuel: {spacecraft.get("ketchup", "Unknown")}
    Orbit: {spacecraft.get("orbit", "Unknown")}

    =========================
    """

main()