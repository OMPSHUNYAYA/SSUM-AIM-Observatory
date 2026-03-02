# CIC Observatory Demonstration
# Deterministic identity certification demo

from cic_core import cic_certify


# Reference implementation
def square_direct(x):
    return x * x


# Alternate implementation (correct)
def square_repeat_add(x):
    s = 0
    for _ in range(x):
        s += x
    return s


# Buggy implementation
def square_bug(x):
    if x == 47:
        return -1
    return x * x


def run_demo():

    print("SSUM-AIM Observatory — CIC Identity Certification")
    print("--------------------------------------------------")
    print()

    print("Test 1 — Identity Certification")
    result = cic_certify(square_direct, square_repeat_add, range(1000))

    print("Result:", result)

    if result[0]:
        print("Certificate: IDENTICAL over tested domain")
    else:
        print("Certificate: DIVERGENCE at input", result[1])

    print()
    print("Test 2 — Divergence Detection")

    result = cic_certify(square_direct, square_bug, range(100))

    print("Result:", result)

    if result[0]:
        print("Certificate: IDENTICAL over tested domain")
    else:
        print("Certificate: DIVERGENCE at input", result[1])
        print("square_direct(x) =", result[2])
        print("square_bug(x) =", result[3])

    print()
    print("CIC execution complete.")


if __name__ == "__main__":
    run_demo()