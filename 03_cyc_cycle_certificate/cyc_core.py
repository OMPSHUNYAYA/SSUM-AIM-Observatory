from typing import Callable, Dict, List, Optional, Tuple, Any

def cycle_structure_dict(f: Callable[[Any], Any], x0: Any, limit: int = 1_000_000) -> Tuple[Optional[int], Optional[int], Optional[List[Any]]]:
    seen: Dict[Any, int] = {}
    seq: List[Any] = []
    x = x0
    for i in range(limit):
        if x in seen:
            mu = seen[x]
            lam = i - seen[x]
            return mu, lam, seq[mu:]
        seen[x] = i
        seq.append(x)
        x = f(x)
    return None, None, None

def iterate(f: Callable[[Any], Any], x: Any, k: int) -> Any:
    y = x
    for _ in range(k):
        y = f(y)
    return y

def verify_cycle_certificate(f: Callable[[Any], Any], x0: Any, mu: int, lam: int, cycle: List[Any]) -> Tuple[bool, str]:
    if mu < 0 or lam <= 0:
        return False, "INVALID_MU_LAMBDA"
    if len(cycle) != lam:
        return False, "CYCLE_LENGTH_MISMATCH"

    entry = cycle[0]

    a = iterate(f, x0, mu)
    if a != entry:
        return False, "ENTRY_MISMATCH"

    b = iterate(f, x0, mu + lam)
    if b != entry:
        return False, "PERIOD_MISMATCH"

    x = entry
    for i in range(lam):
        if x != cycle[i]:
            return False, "CYCLE_VALUE_MISMATCH"
        x = f(x)
    if x != entry:
        return False, "CYCLE_NOT_CLOSED"

    return True, "OK"

def cycle_certificate(f: Callable[[Any], Any], x0: Any, limit: int, f_label: str) -> Dict[str, Any]:
    mu, lam, cycle = cycle_structure_dict(f, x0, limit=limit)
    if mu is None or lam is None or cycle is None:
        return {
            "label": f_label,
            "x0": x0,
            "limit": limit,
            "status": "NO_CYCLE_FOUND"
        }

    ok, reason = verify_cycle_certificate(f, x0, mu, lam, cycle)

    return {
        "label": f_label,
        "x0": x0,
        "limit": limit,
        "mu": mu,
        "lambda": lam,
        "cycle": cycle,
        "entry": cycle[0] if len(cycle) > 0 else None,
        "verified": bool(ok),
        "verify_reason": reason
    }