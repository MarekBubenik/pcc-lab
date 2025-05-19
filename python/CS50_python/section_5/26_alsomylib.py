import sys

from pythonProjects.section_5.mylib25 import hello

if len(sys.argv) == 2:
    hello(sys.argv[1])
