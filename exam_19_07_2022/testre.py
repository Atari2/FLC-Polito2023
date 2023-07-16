import re

word = r'(-3[02]|-[12][02468]|-?[2468]|0|\d{1,2}[02468]|1[01]\d[02468]|12[0-3][02468]|124[0246])'

regex = rf'B_({word}[*$+]{word}){2}([*$+]{word})*'
print(regex)
matcher = re.compile(regex)

test = "B_-12*1132*1244+-4"

print(matcher.match(test))