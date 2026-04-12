# napkin-lean

A Lean 4 companion to Evan Chen's [*An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), inspired by [Terence Tao's *Analysis in Lean*](https://teorth.github.io/analysis/).

This project uses Lean 4 and [Mathlib](https://leanprover-community.github.io/mathlib4_docs/) to formalize definitions, theorems, and exercises from the Napkin. Key Mathlib definitions are restated using Lean's `recall` command to verify they match the textbook's presentation.

**Note:** This project was AI-generated with Claude and hasn't been play-tested yet. Expect rough edges.

## Building

```bash
lake exe cache get   # download Mathlib cache
lake build           # build the project
```

## Progress

| Part | Chapter | Status |
|------|---------|--------|
| I. Starting Out | Ch 1: Groups | Definitions + exercises |
| I. Starting Out | Ch 2: Metric Spaces | Definitions + exercises |
| II. Basic Abstract Algebra | Ch 3: Homomorphisms and Quotients | Definitions + exercises |
| II. Basic Abstract Algebra | Ch 4: Rings and Ideals | Definitions + exercises |
| II. Basic Abstract Algebra | Ch 5: Flavors of Rings | Definitions + exercises |
| III. Basic Topology | Ch 6: Properties of Metric Spaces | Definitions + exercises |
| III. Basic Topology | Ch 7: Topological Spaces | Definitions + exercises |
| III. Basic Topology | Ch 8: Compactness | Definitions + exercises |
| IV. Linear Algebra | Ch 12: Vector Spaces | Definitions + exercises |
| IV. Linear Algebra | Ch 13: Eigen-things | Definitions + exercises |
| IV. Linear Algebra | Ch 14: Determinant | Definitions + exercises |
| V. More on Groups | Ch 9: Group Actions | Definitions + exercises |
| V. More on Groups | Ch 10: The Sylow Theorems | Definitions + exercises |
| V. More on Groups | Ch 11: The Structure Theorem | Definitions + exercises |

## Style

- **Mathlib-first**: we use Mathlib's existing definitions and restate them to verify they match the Napkin's presentation.
- **`recall` over `#check`**: use `recall` to restate Mathlib theorems and definitions — it verifies the type signature matches at compile time. Use `#check` only for `class`/`structure` declarations where `recall` doesn't apply syntactically.
- **Textbook references**: comments reference Napkin definition/proposition numbers.
- **Exercises as `sorry`**: exercises from the textbook are stated as theorems with `sorry` proofs, inviting contributions.

## Contributing

Pick a chapter, formalize its definitions and theorems, and submit a PR. See existing chapters for the style.

## License

Apache 2.0
