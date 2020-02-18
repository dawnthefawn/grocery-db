class RecipeStep :
    def __init__(self ,direction: str = "",num: int=0) :
        self._direction = direction
        self._order = num

    @property
    def direction(self) -> str:
        return self._direction

    @direction.setter
    def direction(self,text:str):
        self._direction = text

    @property
    def order(self) -> int:
        return self._order

    @order.setter
    def order(self, num:int):
        self._order = num

    def __eq__(self, other):
        return (self.order == other.order and self.direction == other.direction)