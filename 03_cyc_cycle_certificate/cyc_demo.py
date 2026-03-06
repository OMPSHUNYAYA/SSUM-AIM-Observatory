from cyc_core import cycle_certificate

def f(x):
    return (x * x + 1) % 97

def g(x):
    return (3 * x + 1) % 11

def lcg(x):
    return (5 * x + 1) % 16

def print_cert(cert):
    keys = ["label", "x0", "limit", "mu", "lambda", "entry", "verified", "verify_reason"]
    for k in keys:
        if k in cert:
            print(f"{k}: {cert[k]}")
    if "cycle" in cert:
        print(f"cycle: {cert['cycle']}")
    print()

def main():
    c1 = cycle_certificate(f, 2, 1_000_000, "f(x)=(x*x+1)%97")
    c2 = cycle_certificate(g, 0, 1_000_000, "g(x)=(3*x+1)%11")
    c3 = cycle_certificate(lcg, 0, 1_000_000, "lcg(x)=(5*x+1)%16")

    print("CYC — Cycle Structure Certificate")
    print()

    print("Example 1")
    print_cert(c1)

    print("Example 2")
    print_cert(c2)

    print("Example 3")
    print_cert(c3)

    print("CYC execution complete.")

if __name__ == "__main__":
    main()