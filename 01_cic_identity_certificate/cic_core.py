# CIC — Computation Identity Certificate Core
# Deterministic. No randomness. No dependencies.

def cic_certify(f, g, domain):
    """
    Deterministically certifies identity of two functions over a finite domain.

    Returns:
        (True, None, None, None) if identical
        (False, x, fx, gx) if divergence found at first input x
    """

    for x in domain:
        fx = f(x)
        gx = g(x)

        if fx != gx:
            return False, x, fx, gx

    return True, None, None, None