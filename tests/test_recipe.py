from src.recipe import Recipe
from src.ingredient import Ingredient
from src.recipe_step import RecipeStep
from src.grocery import Grocery
from pint import UnitRegistry
ureg = UnitRegistry()
R = Recipe()
R.add_step(RecipeStep("First Step"))

def test_add_step():
    R.add_step(RecipeStep("Second Step", 2))
    assert R.get_step(2).direction == "Second Step"

def test_insert_step():
    R.insert_step(RecipeStep("Real Second Step",2))
    assert R.get_step(3).direction == "Second Step"

def test_add_ingredient():
    R.add_ingredient(Ingredient(2, ureg.parse_units("cup"), Grocery("flour")))
    assert R.ingredients[0] == Ingredient(2, ureg.parse_units("cup"),
                                          Grocery("flour"))