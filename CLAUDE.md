# Maintainable Code Commandments for Coding Agents

Your job: make the code work *and* leave the codebase easier to understand, safer to modify, and cheaper to maintain.

**Priority order:** Correctness → Safety → Readability → Maintainability → Simplicity → Practical performance → Conciseness. Never trade a higher goal for a lower one — never make code clever, obscure, unsafe, or hard to debug for the sake of speed or brevity. Keep comments rare and ≤2 lines; comment only where the code isn't self-explanatory.

## The 10 Commandments

1. **Write for humans first.** Clear names, explicit data flow, direct control flow, boring structure. Avoid cleverness unless it clearly helps correctness/performance and is easily explained.

2. **Small functions and files.** Keep every authored/modified function under 60 lines with one responsibility; split by meaningful behavior, not mechanically. Avoid monolithic files.

3. **≥2 meaningful assertions per non-trivial function.** Validate real assumptions: input shape/type/range/validity, non-null/non-empty, state invariants, impossible states, lifecycle/ownership, pre/postconditions, external responses, dimensions (array/tensor/graph/geometry), ordering/bounds/uniqueness/consistency. No decorative asserts — each should catch a plausible bug. If two don't fit naturally, the function may be too trivial (inline it) or validation belongs at the boundary.

4. **Be assert-dense on risky logic.** Use more than 2 around: external input; file/network/DB/API boundaries; parsing/serialization; numerics and optimization; concurrency; security-sensitive code; state mutation; cache reads/writes; graph/tree traversal; indexing/slicing; unit/coordinate conversions; model inference I/O; anywhere silent corruption is costly. Asserts catch programmer bugs — for expected bad input, use real validation and return useful errors.

5. **Never hide failure.** No `try/except: pass`, empty catches, catch-alls without a recovery plan, ignored error returns, log-and-swallow, continuing in a known-invalid state, or defaulting to fake/empty data after failure (unless explicitly safe). Failure stays visible.

6. **Use try/catch only for a reason:** add context and rethrow; convert to a meaningful domain error; clean up and rethrow; handle a genuinely expected failure; retry a transient failure with limits; recover into a known-safe state; or degrade explicitly and correctly. Preserve the original cause. Don't use it to mask bad code or missing validation.

7. **Make dependencies and data flow explicit.** A reader should see where data comes from, changes, and goes. Avoid hidden global state, implicit mutation, surprising side effects, and shared mutable state. Prefer explicit inputs/outputs and clear ownership.

8. **Keep control flow flat and obvious.** Early returns and guard clauses over deep nesting, complex booleans, needless indirection, unbounded recursion, or hidden paths. The happy path should be easy to follow.

9. **Prefer simple design over premature abstraction.** Don't add frameworks, config layers, generic helpers, inheritance, caching, concurrency, or metaprogramming without demonstrated need. Duplication beats the wrong abstraction. When justified, keep abstractions small, well-named, and easy to delete.

10. **Write efficient code.** Pick appropriate algorithms and data structures up front; avoid repeated work, needless allocations/copies, N² when better is straightforward, blocking in hot paths, and excess I/O. Optimize through design, not tricks — never at the cost of correctness/readability, and don't micro-optimize cold code.

## Before Making Changes

Inspect the surrounding code first: existing style, relevant abstractions, intended data flow, validation patterns, test coverage, likely failure modes, and performance-sensitive paths. Make the smallest correct change that improves the codebase.

## Before Finishing

Audit each authored/modified function: under 60 lines with one responsibility? ≥2 useful (non-decorative) assertions? External input validated at the boundary? Every try/catch justified, errors preserved or safely handled? Control flow easy to follow, dependencies explicit, algorithm reasonable, no needless abstraction? Is it easier to maintain than before? If any answer is no, revise before returning.

## Response Requirements

When done, summarize: (1) what changed, (2) invariants/assertions added, (3) how errors are handled, (4) why it's maintainable, (5) performance-relevant decisions, (6) any justified rule exceptions.

Don't claim tests passed unless you ran them. Don't claim a file changed unless you changed it. Don't hide uncertainty.

