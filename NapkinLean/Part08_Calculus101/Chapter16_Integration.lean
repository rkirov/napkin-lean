import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.Calculus.FDeriv.Basic
import Mathlib.Tactic

/-! # Chapter 16: Integration

This file formalizes the integration chapter of Evan Chen's
*An Infinitely Large Napkin*, covering the Riemann integral
and the fundamental theorem of calculus.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 16
-/

/-! ## Section 16.3: The Riemann integral

Napkin Theorem 16.3.3: For a continuous function f : [a, b] → ℝ,
the Riemann integral ∫ₐᵇ f(x) dx exists and equals the limit
of Riemann sums as the mesh approaches zero.

In Mathlib, integration is done via `intervalIntegral` (notation: ∫ x in a..b, f x).
-/
section RiemannIntegral

-- The interval integral
#check @intervalIntegral

-- Continuous functions are integrable
recall ContinuousOn.intervalIntegrable {E : Type*} [NormedAddCommGroup E]
    {μ : MeasureTheory.Measure ℝ} [MeasureTheory.IsLocallyFiniteMeasure μ]
    {u : ℝ → E} {a b : ℝ}
    (hu : ContinuousOn u (Set.uIcc a b)) : IntervalIntegrable u μ a b

end RiemannIntegral

/-! ## The Fundamental Theorem of Calculus

Napkin: If f is continuous on [a, b] and F(x) = ∫ₐˣ f(t) dt,
then F'(x) = f(x).

Also: if f' is continuous on [a, b], then ∫ₐᵇ f'(x) dx = f(b) - f(a).
-/
section FTC

-- FTC Part 1: derivative of the integral
#check @intervalIntegral.integral_hasDerivAt_right

-- FTC Part 2: integral of the derivative
recall intervalIntegral.integral_eq_sub_of_hasDerivAt
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {a b : ℝ} [CompleteSpace E]
    {f f' : ℝ → E}
    (hderiv : ∀ x ∈ Set.uIcc a b, HasDerivAt f (f' x) x)
    (hint : IntervalIntegrable f' MeasureTheory.volume a b) :
    ∫ y in a..b, f' y = f b - f a

end FTC

/-! ## Exercises -/
section Exercises

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

-- Exercise 16A (FTC): If f has a continuous derivative on [a, b],
-- then ∫ₐᵇ f'(x) dx = f(b) - f(a).
-- This is `intervalIntegral.integral_eq_sub_of_hasDerivAt` in Mathlib.

end Exercises
