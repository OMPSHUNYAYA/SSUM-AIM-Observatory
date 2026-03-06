# ERC — Execution Replay Certificate
# Pure computation. Deterministic. Reproducible.

import hashlib


def erc(runA, runB, x):
    outA, traceA = runA(x)
    outB, traceB = runB(x)

    if outA != outB:
        return ("FAIL", "OUTPUT_MISMATCH", outA, outB, None)

    n = min(len(traceA), len(traceB))

    for i in range(n):
        if traceA[i] != traceB[i]:
            return ("FAIL", "TRACE_DIVERGENCE", i, traceA[i], traceB[i])

    if len(traceA) != len(traceB):
        return ("FAIL", "TRACE_LENGTH_MISMATCH", n, len(traceA), len(traceB))

    return ("PASS", "REPLAY_CERTIFIED", outA, len(traceA), None)


def trace_digest(trace):
    return hashlib.sha256(repr(trace).encode("utf-8")).hexdigest()


def print_certificate(result):
    status, reason, a, b, c = result

    if status == "PASS":
        print("Certificate: REPLAY CERTIFIED")
        print("Output:", a)
        print("Trace length:", b)

    elif reason == "TRACE_DIVERGENCE":
        print("Certificate: REPLAY FAILED")
        print("First divergence at step:", a)
        print("RunA step:", b)
        print("RunB step:", c)

    elif reason == "OUTPUT_MISMATCH":
        print("Certificate: OUTPUT MISMATCH")
        print("RunA output:", a)
        print("RunB output:", b)

    elif reason == "TRACE_LENGTH_MISMATCH":
        print("Certificate: TRACE LENGTH MISMATCH")
        print("Length RunA:", b)
        print("Length RunB:", c)
