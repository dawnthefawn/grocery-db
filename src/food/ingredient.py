import pint
import fractions
import math
from src.food.grocery import Grocery
f = fractions.Fraction


class Ingredient:
    def __init__(self, qty:str, measurement:pint.Unit,grocery:Grocery):
        if str(qty).isnumeric():
            self._quantity = f(int(qty),1)
        elif qty.count(".") > 0:
            self._quantity= f(fractions.Decimal(qty))
        elif qty.count("/") > 0:
            self._quantity = fractions.Fraction(qty)
        else:
            raise SyntaxError(f"{qty} is not a valid quantity")

        self._unit = measurement
        self._grocery = grocery

    @property
    def quantity(self) -> fractions.Fraction:
        return self._quantity

    @property
    def p_quantity(self) -> str:
        if self._quantity.numerator > self.quantity.denominator:
            w = math.floor(self._quantity.numerator/self._quantity.denominator)
            r = self._quantity.numerator % self._quantity.denominator
            return f"{w} {r}/{self._quantity.denominator}"

    @property
    def unit(self) -> pint.Unit:
        return self._unit

    @property
    def grocery(self):
        return self._grocery

    def __eq__(self, other) -> bool:
        return (self.quantity == other.quantity and self.grocery ==
                other.grocery and self.unit == other.unit)


