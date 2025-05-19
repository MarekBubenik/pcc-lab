# APIs      # web requests library
# pypi.org/project/requests
# JSON      # standard text-based format for representing structured data
# docs.python.org/3/library/json.html

import json
import requests
import sys

if len(sys.argv) != 2:
    sys.exit()

response = requests.get("https://itunes.apple.com/search?entity=song&limit=5&term=" + sys.argv[1])
#print(json.dumps(response.json(), indent=2))              # json.dumps          #   blablabla.json
o = response.json()
for result in o["results"]:
    print(result["trackName"])
