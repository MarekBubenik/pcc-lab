from PIL import Image
from PIL import ImageFilter

def main():
    with Image.open("cat1.png") as img:
        # print(img.size)
        # print(img.format)
        img = img.rotate(180)
        img.filter(ImageFilter.BLUR)
        img.filter(ImageFilter.FIND_EDGES)
        img.save("out.png")

main()