import pytest
from src.ingredient import Ingredient
from fractions import Fraction
from pint import UnitRegistry
from src.grocery import Grocery
ureg  = UnitRegistry()

def i()->Ingredient:
    return Ingredient("7/4", ureg.parse_units("cup"),Grocery("flour"))

def n()->Ingredient:
    return Ingredient("2", ureg.parse_units("cup"), Grocery("flour"))

def d() -> Ingredient:
    return Ingredient("2.5", ureg.parse_units("cup"), Grocery("flour"))

def test_quantity_frac():
    assert i().quantity == Fraction(7,4)

def test_quantity_whole():
    assert float(n().quantity) == 2.0

def test_quantity_decimal():
    assert d().quantity == Fraction(5,2)

def test_p_quantity():
    assert i().p_quantity == "1 3/4"

def test_unit():
    assert i().unit == ureg.parse_units("cup")

def test_item():
    assert i().grocery.name == "flour"

def test_invalid():
    with pytest.raises(SyntaxError):
        f=Ingredient("twelve", ureg.parse_units("cup"),Grocery("flour"))


