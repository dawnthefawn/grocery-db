from src.food.recipe_step import RecipeStep
from src.food.ingredient import Ingredient


class Recipe :
    def __init__(self) :
        self._ingredients = list()
        self._directions = list()

    def add_step(self ,step: RecipeStep) :
        step.order = len(self._directions) + 1
        self._directions.append(step)

    def insert_step(self ,step: RecipeStep) :
        self._directions.insert(step.order-1, step)
        for i in range(step.order + 1, len(self._directions)):
            self._directions[i].order = i

    def add_ingredient(self ,ing: Ingredient) :
        self._ingredients.append(ing)

    @property
    def directions(self):
        D = ""
        for s in self._directions:
           D += f"{s.order}: {s}"
        return D

    def get_step(self, num:int) -> dict:
        return self._directions[num-1]

    @property
    def ingredients(self) -> list:
        return self._ingredients

