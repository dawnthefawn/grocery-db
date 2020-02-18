import pytest
from src.food.recipe_step import RecipeStep

s = "Mix together ingredients and put in a dutch oven at body temperature"
rs1 = RecipeStep(s, 1)
rs2 = RecipeStep()

def test_direction_setter():
    rs2.direction = s
    assert rs2._direction == s

def test_order_setter():
    rs2.order = 1
    assert rs2._order == 1

def test_direction_getter():
    assert rs2.direction == s

def test_order_getter():
    assert rs2.order == 1

def test_equivalence():
    assert rs1 == rs2