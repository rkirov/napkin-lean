# napkin-lean

A Lean 4 companion to Evan Chen's [*An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), inspired by [Terence Tao's *Analysis in Lean*](https://teorth.github.io/analysis/).

This project uses Lean 4 and [Mathlib](https://leanprover-community.github.io/mathlib4_docs/) to formalize definitions, theorems, and exercises from the Napkin. Key Mathlib definitions are restated using Lean's `recall` command to verify they match the textbook's presentation.

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

## Style

- **Mathlib-first**: we use Mathlib's existing definitions and use `recall` to verify they match the Napkin's presentation.
- **Textbook references**: comments reference Napkin definition/proposition numbers.
- **Exercises as `sorry`**: exercises from the textbook are stated as theorems with `sorry` proofs, inviting contributions.

## Contributing

Pick a chapter, formalize its definitions and theorems, and submit a PR. See existing chapters for the style.

## License

Apache 2.0
