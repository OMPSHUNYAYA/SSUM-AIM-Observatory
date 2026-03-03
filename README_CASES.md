# SSUM-AIM Observatory — Public Release (Capsule Notes)

## Purpose

This `Public_Release` directory contains SSUM-AIM Observatory capsules.

Each capsule is a tiny deterministic kernel that produces a **structural certificate**.

The focus is not file size.  
The focus is that the kernel produces a deterministic certificate — not just an output.

---

## Core Authority

Each capsule proves structure by replay identity and manifest integrity.

Replay identity condition: `B_A = B_B`  
Manifest integrity condition: `SHA256(actual) = SHA256(recorded)`

These two conditions define certificate authority.

---

## Capsule Model

Each case folder typically contains:

**`*_core.py`**  
Core kernel (certificate logic)

**`*_demo.py`**  
Demonstration harness (finite domain examples)

**`OUT_PRIMARY.txt`**  
Authoritative output used for manifest binding

**`*_MANIFEST.sha256`**  
Authoritative hashes for specific bound artifacts  
(typically `*_core.py`, `*_demo.py`, `OUT_PRIMARY.txt`)

**`VERIFY_*.cmd`**  
Recomputes hashes and verifies `*_MANIFEST.sha256`

**`REPLAY_*.cmd`**  
Executes twice and certifies replay identity

---

## Replay Artifacts

Some capsules may include these files after `REPLAY_*.cmd`:

**`OUT_A.txt` and `OUT_B.txt`**  
Captured stdout from run A and run B.

**`ERR_A.txt` and `ERR_B.txt`**  
Captured stderr from run A and run B.

---

## Note on 0 KB ERR Files

If `ERR_A.txt` and `ERR_B.txt` are 0 KB, this is expected and meaningful.

It certifies that execution produced no stderr output.

A zero-byte file is still a structural state.

These files may be preserved intentionally as structural evidence of clean execution.

They are not required for manifest binding unless explicitly listed in the case manifest.

---

## Freeze Boundary

A capsule’s certificate is defined strictly by what its manifest binds.

Files outside the manifest do not alter the certificate authority.

Recommended practice:

- Keep per-case manifests minimal and stable.
- Place reusable explanations (such as empty stderr artifacts) in this root document.

Replay artifacts (`OUT_A.txt`, `OUT_B.txt`, `ERR_A.txt`, `ERR_B.txt`) are execution witnesses.

They are **not part of the frozen certificate** unless explicitly manifest-bound.

---

## Operational Rule

Do not modify any manifest-bound files after freeze unless you intend to re-freeze and regenerate the manifest.

No probability.  
No tolerance.  
No heuristics.  

**Pure deterministic certification.**

---

## Authorship

Created by the authors of the Shunyaya Framework.
