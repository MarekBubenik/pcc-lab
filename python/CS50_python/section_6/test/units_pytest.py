# pip3 install pytest / docs.pytest.org
# pytest units_pytest.py
import pytest

from pythonProjects.section_6.units_1 import square

def test_positive():
    assert square(2) == 4
    assert square(3) == 9

def test_negativite():
    assert square(-2) == 4
    assert square(-3) == 9

def test_zero():
    assert square(0) == 0  

def test_str():
    with pytest.raises(TypeError):      # with // TODO ???
        square("cat")

# FF means fail fail
# . dot means pass

# make sure function return a value if testing
# create a folder with test files (e,g, test)
# within this folder create a file name __init__.py
# which python treats as a package
# execute: "pytest test" # execute all test within that folder called test

# =================================================================================================== test session starts ===================================================================================================
# platform linux -- Python 3.11.2, pytest-8.3.5, pluggy-1.5.0
# rootdir: /home/mb/pythonProjects/section_6
# collected 3 items                                                                                                                                                                                                         

# units_pytest.py FF.                                                                                                                                                                                                 [100%]

# ======================================================================================================== FAILURES =========================================================================================================
# ______________________________________________________________________________________________________ test_positive ______________________________________________________________________________________________________

#     def test_positive():
#         assert square(2) == 4
# >       assert square(3) == 9
# E       assert 6 == 9
# E        +  where 6 = square(3)

# units_pytest.py:8: AssertionError
# _____________________________________________________________________________________________________ test_negativite _____________________________________________________________________________________________________

#     def test_negativite():
# >       assert square(-2) == 4
# E       assert -4 == 4
# E        +  where -4 = square(-2)

# units_pytest.py:11: AssertionError
# ================================================================================================= short test summary info =================================================================================================
# FAILED units_pytest.py::test_positive - assert 6 == 9
# FAILED units_pytest.py::test_negativite - assert -4 == 4
# =============================================================================================== 2 failed, 1 passed in 0.03s ===============================================================================================
