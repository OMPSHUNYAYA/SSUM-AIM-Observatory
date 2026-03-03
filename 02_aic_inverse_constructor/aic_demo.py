from aic_core import construct_inverse

def f(x):
    return (3 * x) % 11

ok, y, x1, x2, inv = construct_inverse(f, range(11))

print("SSUM-AIM Observatory — AIC Inverse Constructor")
print("------------------------------------------------")
print()
print("Example 1 — Inverse Construction")
if ok:
    print("Certificate: INVERTIBLE")
    print("Inverse mapping:", inv)
else:
    print("Certificate: NOT INVERTIBLE")
    print("Collision at output", y, "from inputs", x1, "and", x2)

print()

def g(x):
    return (x * x) % 11

ok, y, x1, x2, inv = construct_inverse(g, range(11))

print("Example 2 — Collision Detection")
if ok:
    print("Certificate: INVERTIBLE")
else:
    print("Certificate: NOT INVERTIBLE")
    print("Collision at output", y, "from inputs", x1, "and", x2)

print()
print("AIC execution complete.")