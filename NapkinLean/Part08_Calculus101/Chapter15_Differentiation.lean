import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Calculus.LocalExtr.Basic
import Mathlib.Tactic

/-! # Chapter 15: Differentiation

This file formalizes the differentiation chapter of Evan Chen's
*An Infinitely Large Napkin*, covering derivatives, the chain rule,
local extrema, Rolle's theorem, and the mean value theorem.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 15
-/

/-! ## Section 15.1: Definition of the derivative

Napkin Definition 15.1.1: A function f : ℝ → ℝ is **differentiable**
at p if the limit of (f(p + h) - f(p)) / h as h → 0 exists.
The limit is called the **derivative** f'(p).

In Mathlib, differentiability is `HasDerivAt` and the derivative
is accessed via `deriv`.
-/
section DerivativeDefinition

-- The derivative of f at x
#check @deriv

-- f has derivative f' at x
#check @HasDerivAt

-- Differentiable implies continuous
recall HasDerivAt.continuousAt {𝕜 : Type*} [NontriviallyNormedField 𝕜]
    {F : Type*} [NormedAddCommGroup F] [NormedSpace 𝕜 F]
    {f : 𝕜 → F} {f' : F} {x : 𝕜}
    (h : HasDerivAt f f' x) : ContinuousAt f x

end DerivativeDefinition

/-! ## Section 15.2: Computation rules

The sum, product, and chain rules.
-/
section ComputationRules

-- Sum rule
#check @HasDerivAt.add

-- Product rule
#check @HasDerivAt.mul

-- Chain rule
#check @HasDerivAt.comp

end ComputationRules

/-! ## Section 15.3: Local extrema

Napkin Theorem 15.3.3 (Fermat): If f is differentiable at p and p
is a local extremum, then f'(p) = 0.
-/
section LocalExtrema

-- Fermat's theorem for local extrema
#check @IsLocalMin.hasDerivAt_eq_zero
#check @IsLocalMax.hasDerivAt_eq_zero

end LocalExtrema

/-! ## Section 15.4: Rolle's theorem and the Mean Value Theorem

Napkin Theorem 15.4.1 (Rolle): If f is continuous on [a, b],
differentiable on (a, b), and f(a) = f(b), then there exists c in (a, b)
with f'(c) = 0.

Napkin Theorem 15.4.3 (MVT): If f is continuous on [a, b] and
differentiable on (a, b), then there exists c in (a, b) with
f'(c) = (f(b) - f(a)) / (b - a).
-/
section RolleAndMVT

-- Rolle's theorem
recall exists_hasDerivAt_eq_zero {f f' : ℝ → ℝ} {a b : ℝ}
    (hab : a < b) (hfc : ContinuousOn f (Set.Icc a b)) (hfI : f a = f b)
    (hff' : ∀ x ∈ Set.Ioo a b, HasDerivAt f (f' x) x) :
    ∃ c ∈ Set.Ioo a b, f' c = 0

-- Mean value theorem (ratio form)
recall exists_ratio_hasDerivAt_eq_ratio_slope
    (f f' : ℝ → ℝ) {a b : ℝ} (hab : a < b)
    (hfc : ContinuousOn f (Set.Icc a b))
    (hff' : ∀ x ∈ Set.Ioo a b, HasDerivAt f (f' x) x)
    (g g' : ℝ → ℝ) (hgc : ContinuousOn g (Set.Icc a b))
    (hgg' : ∀ x ∈ Set.Ioo a b, HasDerivAt g (g' x) x) :
    ∃ c ∈ Set.Ioo a b, (g b - g a) * f' c = (f b - f a) * g' c

end RolleAndMVT

/-! ## Exercises -/
section Exercises

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

/-- Exercise 15A: Differentiability implies continuity. -/
theorem exercise_15A {f : ℝ → ℝ} {x : ℝ} (hf : DifferentiableAt ℝ f x) :
    ContinuousAt f x := by
  sorry

/-- Exercise 15B: If f'(x) ≥ 0 for all x in [a, b], then f is
nondecreasing on [a, b]. -/
theorem exercise_15B {f : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b)
    (hf : ContinuousOn f (Set.Icc a b))
    (hf' : ∀ x ∈ Set.Ioo a b, 0 ≤ deriv f x) :
    MonotoneOn f (Set.Icc a b) := by
  sorry

end Exercises
