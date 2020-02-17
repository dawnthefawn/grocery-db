import pytest
from pint import UnitRegistry
from src.grocery import Grocery

ureg = UnitRegistry()
g = Grocery("flour", ureg.parse_units("cup"))

def test_name():
    assert g.name == "flour"

def test_default_unit():
    assert g.default_unit == ureg.parse_units("cup")

def test_identity():
    l = {
            "Baby Carrots"     : "baby-carrot" ,
            "Frogs Legs"       : "frogs-leg" ,
            "Bunch of Bananas" : "bunch-of-banana" ,
            "Coconuts"         : "coconut" ,
            "Ground Beef"      : "ground-beef"
            }
    for i in l:
        print(i, l.get(i),get_identity(i))
        assert get_identity(i)  == l.get(i)

def get_identity(i:str) -> str:
    return Grocery(i).identity

def test_identity_error():
    with pytest.raises(NameError):
        print(Grocery(None).identity )

def test_base_item():
    assert Grocery("Non-fat Greek Yogurt").base_item == "yogurt"

def test_type():
    assert Grocery("Non-fat Greek Yogurt").type == "non-fat-greek"