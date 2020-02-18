from pint import Unit
import inflection

class Grocery:
    def __init__(self,item:str, unit: Unit=None):
        if item is not None:
            il = item.split(" ")
            self._base_item = il[len(il)-1].lower()
            self._base_item_type = "-".join(il[0:len(il)-1]).lower()
        self._name = item
        self._default_unit = unit

    @property
    def name(self) ->str:
        return self._name

    @property
    def identity(self):
        if self.name is None:
            raise NameError("name must be defined to get an identity")
        return inflection.parameterize(inflection.singularize(self.name.lower()))

    @property
    def base_item(self):
        return self._base_item

    @property
    def type(self):
        return self._base_item_type

    @property
    def default_unit(self):
        return self._default_unit

    def __eq__(self,other) -> bool:
        return (self.base_item == other.base_item and self.type == other.type)