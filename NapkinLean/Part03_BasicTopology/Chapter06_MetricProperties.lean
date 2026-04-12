import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.MetricSpace.Bounded
import Mathlib.Topology.UniformSpace.Cauchy
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas
import Mathlib.Tactic

/-! # Chapter 6: Properties of metric spaces

This file formalizes Chapter 6 of Evan Chen's
*An Infinitely Large Napkin*, covering boundedness,
total boundedness, completeness, and subspaces.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 6
-/

/-! ## Section 6.1: Boundedness

Napkin Definition 6.1.1: A metric space M is **bounded** if there exists
a constant D such that dist p q ≤ D for all p, q ∈ M.

In Mathlib, boundedness is handled via `Bornology.IsBounded`.
-/
section Boundedness

#check (Bornology.IsBounded : Set _ → Prop)

variable {X : Type*} [PseudoMetricSpace X]

-- A set is bounded iff it fits in some ball (centered at a given point)
recall Metric.isBounded_iff_subset_closedBall {α : Type*}
    {s : Set α} [PseudoMetricSpace α] (c : α) :
    Bornology.IsBounded s ↔ ∃ r, s ⊆ Metric.closedBall c r

end Boundedness

/-! ## Section 6.2: Total boundedness

Napkin Definition 6.2.3: A metric space is **totally bounded** if for
any ε > 0, we can cover M with finitely many ε-balls.
-/
section TotalBoundedness

recall TotallyBounded {α : Type*} [UniformSpace α] (s : Set α) : Prop

-- Totally bounded implies bounded
recall TotallyBounded.isBounded {α : Type*} [PseudoMetricSpace α]
    {s : Set α} (h : TotallyBounded s) : Bornology.IsBounded s

end TotalBoundedness

/-! ## Section 6.3: Completeness

Napkin Definition 6.3.1: A sequence (xₙ) is **Cauchy** if for any
ε > 0, we have dist xₘ xₙ < ε for all sufficiently large m and n.

Napkin Definition 6.3.4: A metric space M is **complete** if every
Cauchy sequence converges.
-/
section Completeness

-- Cauchy sequences
recall CauchySeq {α : Type*} {β : Type*}
    [UniformSpace α] [Preorder β] (u : β → α) : Prop

-- Complete spaces
recall CompleteSpace (α : Type*) [UniformSpace α] : Prop

-- ℝ is complete
example : CompleteSpace ℝ := inferInstance

-- Every convergent sequence is Cauchy
#check @Filter.Tendsto.cauchySeq

end Completeness

/-! ## Section 6.5: Subspaces

Napkin Definition 6.5.1: Every subset S ⊆ M inherits a metric space
structure from M, called the **subspace**.

Napkin Exercise 6.5.3: A subset S of a complete space M is complete
iff S is closed in M.
-/
section Subspaces

-- Closed subsets of complete spaces are complete
recall IsClosed.isComplete {α : Type*} [UniformSpace α] [CompleteSpace α]
    {s : Set α} (h : IsClosed s) : IsComplete s

end Subspaces

/-! ## Exercises -/
section Exercises

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

variable {X : Type*} [MetricSpace X]

/-- Exercise 6A: Show that totally bounded implies bounded. -/
theorem exercise_6A {s : Set X} (h : TotallyBounded s) :
    Bornology.IsBounded s := by
  sorry

/-- Exercise 6B (Banach fixed point): If M is a nonempty complete metric space
and T : M → M is a contraction (dist (T x) (T y) ≤ k * dist x y for some
k < 1), then T has a unique fixed point. -/
theorem exercise_6B [Nonempty X] [CompleteSpace X]
    {T : X → X} {k : ℝ} (hk : k ∈ Set.Ico (0 : ℝ) 1)
    (hT : ∀ x y, dist (T x) (T y) ≤ k * dist x y) :
    ∃! x, T x = x := by
  sorry

end Exercises
