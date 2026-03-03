def construct_inverse(f, domain):
    inv = {}
    for x in domain:
        y = f(x)
        if y in inv:
            return False, y, inv[y], x, None
        inv[y] = x
    return True, None, None, None, inv