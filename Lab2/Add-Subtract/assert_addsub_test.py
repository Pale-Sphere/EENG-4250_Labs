# assert_addsub_test.py
#
# Generate IRSIM command file to exhaustively test
# an 8-bit ripple add/subtract unit.
#
# Inputs:  a[7:0], b[7:0], cin
# Outputs: s[7:0], cout
#
# Logic:
#   cin = 0 → s = a + b
#   cin = 1 → s = a - b   (implemented as a + ~b + 1)
#
# IRSIM will only print if outputs deviate from expected
# (via assert command).

stepsize = 50

def expected(a, b, cin):
    if cin == 0:
        total = a + b
    else:
        total = (a - b) & 0x1FF   # 9-bit result with wrap-around
    return total & 0xFF, (total >> 8) & 1


print("# IRSIM command file for 8-bit ripple add/sub unit exhaustive test")
print(f"stepsize {stepsize}")

# Define pins
a_pins = [f"a{i}" for i in range(8)]
b_pins = [f"b{i}" for i in range(8)]
inputs  = a_pins + b_pins + ["cin"]
outputs = [f"s{i}" for i in range(8)] + ["cout"]

# Declare signals
print("ana " + " ".join(inputs + outputs) + " Vdd! GND!")
print("h Vdd!")
print("l GND!")

# Define vectors
print("vector in " + " ".join(inputs))
print("vector out " + " ".join(outputs))
print("")

# Iterate all input combinations
for a in range(256):
    for b in range(256):
        for cin in range(2):
            s, cout = expected(a, b, cin)

            # Build binary string for inputs
            inbits  = "".join(str((a >> i) & 1) for i in reversed(range(8)))
            inbits += "".join(str((b >> i) & 1) for i in reversed(range(8)))
            inbits += str(cin)

            # Build expected output string
            outbits = "".join(str((s >> i) & 1) for i in reversed(range(8))) + str(cout)

            # IRSIM commands
            print(f"set in {inbits}")
            print("s")
            print(f"assert out {outbits}")
            print("")
