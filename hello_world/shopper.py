import pint
import re

shopping = dict()
lines = []
run = True
ureg = pint.UnitRegistry()


def parse_input(inplist: list) :
    if re.match("[0-9]*(\.[0-9]*)?" ,inplist [0]) :
        qty = float(inplist [0])
        try :
            measure = ureg.parse_units(inplist [1])
            item = " ".join(inplist [2 :len(inplist)])
            if item.lower() in shopping.keys() :
                shopping [item.lower()] += qty * measure
            else :
                shopping [item.lower()] = qty * measure
            print(shopping.get(item.lower()) ," " ,item.lower())
        except pint.errors.UndefinedUnitError as uue :
            print(f"{uue} try again")
    else :
        print("qty must be numeric: " ,inplist [0])

def print_list(s:dict):
    for item in s :
        print(f"{s.get(item.lower())} {item.lower()}")

def write_list(s:dict):
    with open("/Users/dawn/shopping","w") as f:
        for item in s:
            f.write(f"{s.get(item.lower())} {item.lower()}\n")



with open("/Users/dawn/shopping","r") as i:
    for iline in i:
        parse_input(iline.strip("\n").split(" "))
    i.close()

while run :
    inp = input("qty measure item")
    if inp == "done" :
        run = False
    elif inp == "list":
        print_list(shopping)
    else :
        parse_input(inp.split(" "))

print("final shopping list")
lines = print_list(shopping)

write_list(shopping)

