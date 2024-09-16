import sys

data = open(sys.argv[1]).read()
output = ""

labels = []

# Get Index Or Fallback
def giof(lst, item, fallback):
    try:
        i = lst[item];
        if i == "_":
            return fallback
        return i
    except IndexError:
        return fallback


# Boolean To Binary
def btb(bool):
    if bool == True:
        return "1"
    else:
        return "0"


def opcode_to_binary(opcode):
    match opcode:
        case "ADD":
            return "100000"
        case "SUB":
            return "100001"
        case "AND":
            return "100010"
        case "OR":
            return "100011"
        case "NOT":
            return "100100"
        case "XOR":
            return "100111"
        case "GT":
            return "010001"
        case "GTE":
            return "010010"
        case "LT":
            return "010011"
        case "LTE":
            return "010100"
        case "EQ":
            return "010101"
        case "NEQ":
            return "010110"
        case "MOV":
            return "000001"
        case "JNZ":
            return "000010"
        case "MGT":
            return "000011"
        case "MST":
            return "000100"
        case "HLT":
            return "000101"


def dest_to_binary(dest: str):
    for l in labels:
        if l[0] == dest:
            dest = str(l[1])
     
    if dest.isnumeric():
        return '{:08b}'.format(int(dest))
    else:
        match dest:
            case "REG_A" | "%REG_A":
                return "00000001"
            case "REG_B" | "%REG_B":
                return "00000010"
            case "REG_C" | "%REG_C":
                return "00000011"
            case "REG_D" | "%REG_D":
                return "00000100"
            case "IN" | "%IN":
                return "10000111"
            case "OUT" | "%OUT":
                return "10001000"
            case "FB":
                return "00000000"

i = 0
for line in data.split("\n"):
    if line[0] != ";":
        # print(i)
        line_split_spaces = line.split(" ")

        if line_split_spaces[0].upper() == "LABEL":
            labels.append((line_split_spaces[1], i))
            continue
        else:
            raw_opcode = giof(line_split_spaces, 0, "FB")
            raw_destination = giof(line_split_spaces, 1, "FB")
            raw_first_param = giof(line_split_spaces, 2, "FB")
            raw_second_param = giof(line_split_spaces, 3, "FB")

            fp_ref = raw_first_param[0] == "%"
            sp_ref = raw_second_param[0] == "%"

            opcode = (
                '"' + btb(fp_ref) + btb(sp_ref) + opcode_to_binary(raw_opcode) + '",'
            )
            destination = (
                '"' + dest_to_binary(raw_destination) + '",'
            )
            first_param = (
                '"' + dest_to_binary(raw_first_param) + '",'
            )
            second_param = (
                '"' + dest_to_binary(raw_second_param) + '",'
            )

            output += (
                opcode
                + " "
                + destination
                + " "
                + first_param
                + " "
                + second_param
                + " "
            )
        i += 1


while len(output.split(" ")) - 1 <= 252:
    output += '"00000000", "00000000", "00000000", "00000000", '

output = output[:-2]
# print(len(output.split(" ")))
print(output)