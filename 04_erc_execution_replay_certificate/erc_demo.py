# ERC — Execution Replay Certificate demo
# Deterministic examples for SSUM-AIM Observatory.

from erc_core import erc, print_certificate, trace_digest


def factorial_mul(n):
    trace = []
    r = 1
    for k in range(2, n + 1):
        trace.append(("mul", r, k))
        r *= k
    return r, trace


def factorial_add(n):
    trace = []
    r = 1
    for k in range(2, n + 1):
        acc = 0
        for _ in range(k):
            trace.append(("add", acc, r))
            acc += r
        r = acc
    return r, trace


def factorial_mul_clone(n):
    trace = []
    r = 1
    for k in range(2, n + 1):
        trace.append(("mul", r, k))
        r *= k
    return r, trace


def factorial_bug(n):
    trace = []
    r = 1
    for k in range(2, n + 1):
        trace.append(("mul", r, k))
        if k == 5:
            r *= (k - 1)
        else:
            r *= k
    return r, trace


def print_trace_summary(name, fn, x):
    out, trace = fn(x)
    print(f"{name}: output={out} trace_len={len(trace)} trace_sha256={trace_digest(trace)[:16]}...")


def main():
    x = 7

    print("Example 1 — Same output, different execution path")
    print_trace_summary("RunA factorial_mul", factorial_mul, x)
    print_trace_summary("RunB factorial_add", factorial_add, x)
    result = erc(factorial_mul, factorial_add, x)
    print(result)
    print_certificate(result)
    print()

    print("Example 2 — Same output, same execution path")
    print_trace_summary("RunA factorial_mul", factorial_mul, x)
    print_trace_summary("RunB factorial_mul_clone", factorial_mul_clone, x)
    result = erc(factorial_mul, factorial_mul_clone, x)
    print(result)
    print_certificate(result)
    print()

    print("Example 3 — Different output")
    print_trace_summary("RunA factorial_mul", factorial_mul, x)
    print_trace_summary("RunB factorial_bug", factorial_bug, x)
    result = erc(factorial_mul, factorial_bug, x)
    print(result)
    print_certificate(result)
    print()

    print("ERC execution complete.")


if __name__ == "__main__":
    main()
