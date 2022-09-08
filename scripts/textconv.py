import sys

scrolltext=(sys.argv[1])
scrolltextlength=len(scrolltext)

print("0", end=',')

for i in range(scrolltextlength):
    currchar=scrolltext[i]
    match currchar:
        case "A":
            print("0,", end='')
        case "B":
            print("1,", end='')
        case "C":
            print("2,", end='')
        case "D":
            print("3,", end='')
        case "E":
            print("4,", end='')
        case "F":
            print("5,", end='')
        case "G":
            print("6,", end='')
        case "H":
            print("7,", end='')
        case "I":
            print("8,", end='')
        case "J":
            print("9,", end='')
        case "K":
            print("10,", end='')
        case "L":
            print("11,", end='')
        case "M":
            print("12,", end='')
        case "N":
            print("13,", end='')
        case "O":
            print("14,", end='')
        case "P":
            print("15,", end='')
        case "Q":
            print("16,", end='')
        case "R":
            print("17,", end='')
        case "S":
            print("18,", end='')
        case "T":
            print("19,", end='')
        case "U":
            print("20,", end='')
        case "V":
            print("21,", end='')
        case "W":
            print("22,", end='')
        case "X":
            print("23,", end='')
        case "Y":
            print("24,", end='')
        case "Z":
            print("25,", end='')
        case "-":
            print("26,", end='')
        case "!":
            print("27,", end='')
        case "?":
            print("28,", end='')
        case ".":
            print("29,", end='')
        case "Ô":
            print("30,", end='')
        case " ":
            print("31,", end='')
        case "'":
            print("32,", end='')
        case ",":
            print("33,", end='')
        case "0":
            print("34,", end='')
        case "1":
            print("35,", end='')
        case "2":
            print("36,", end='')
        case "3":
            print("37,", end='')
        case "4":
            print("38,", end='')
        case "5":
            print("39,", end='')
        case "6":
            print("40,", end='')
        case "7":
            print("41,", end='')
        case "8":
            print("42,", end='')
        case "9":
            print("43,", end='')

        case _:
            pass
print("44")