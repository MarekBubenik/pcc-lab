# pillow.readthedocs.io         / library that allows to navigate image files as well and perform operations on image files
#                               / animated GIF
# USAGE: python3 pillow.py cat1.png cat2.png 

import sys

from PIL import Image

images = []

for arg in sys.argv[1:]:
    image = Image.open(arg)
    images.append(image)

images[0].save(
    "costumes.gif", save_all=True, append_images=[images[1]], duration=200, loop=0
)