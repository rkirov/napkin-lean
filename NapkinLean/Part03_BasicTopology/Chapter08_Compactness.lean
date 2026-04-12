import Mathlib.Topology.Compactness.Compact
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.MetricSpace.Bounded
import Mathlib.Topology.Order
import Mathlib.Tactic

/-! # Chapter 8: Compactness

This file formalizes Chapter 8 of Evan Chen's
*An Infinitely Large Napkin*, covering sequential compactness,
open cover compactness, and applications including the extreme
value theorem and uniform continuity.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 8
-/

/-! ## Section 8.1: Sequential compactness

Napkin Definition 8.1.3: A metric space is **sequentially compact** if
every sequence has a convergent subsequence.

In Mathlib, sequential compactness is `IsSeqCompact`.
-/
section SequentialCompactness

#check @IsSeqCompact

variable {X : Type*} [TopologicalSpace X]

-- Closed subsets of compact sets are compact (Napkin Proposition 8.1.5)
recall IsClosed.isCompact {X : Type*} [TopologicalSpace X]
    {s : Set X} [CompactSpace X] (h : IsClosed s) : IsCompact s

end SequentialCompactness

/-! ## Section 8.2: Criteria for compactness

Napkin Theorem 8.2.3 (Bolzano-Weierstrass): A subset of ℝⁿ is
compact iff it is closed and bounded.
-/
section Criteria

-- [0, 1] is compact
example : IsCompact (Set.Icc (0 : ℝ) 1) := isCompact_Icc

end Criteria

/-! ## Section 8.3: Open cover compactness

Napkin Definition 8.3.3: A space X is **compact** if every open cover
has a finite subcover. (In the Napkin, compact also requires Hausdorff;
in Mathlib, `CompactSpace` does not require Hausdorff.)
-/
section OpenCoverCompactness

#check (CompactSpace : ∀ (X : Type*) [TopologicalSpace X], Prop)
#check @IsCompact

-- The open cover characterization
recall isCompact_iff_finite_subcover {X : Type*} [TopologicalSpace X]
    {s : Set X} : IsCompact s ↔
    ∀ {ι : Type _} (U : ι → Set X), (∀ i, IsOpen (U i)) → s ⊆ ⋃ i, U i →
    ∃ t : Finset ι, s ⊆ ⋃ i ∈ t, U i

end OpenCoverCompactness

/-! ## Section 8.4: Applications of compactness -/
section Applications

variable {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]

-- Images of compact sets are compact (Napkin Theorem 8.4.3)
recall IsCompact.image {X : Type*} {Y : Type*}
    [TopologicalSpace X] [TopologicalSpace Y] {s : Set X} {f : X → Y}
    (hs : IsCompact s) (hf : Continuous f) : IsCompact (f '' s)

-- Extreme value theorem (Napkin Corollary 8.4.4):
-- A continuous function on a compact set attains its maximum
recall IsCompact.exists_isMaxOn {α : Type*} {β : Type*}
    [LinearOrder α] [TopologicalSpace α] [TopologicalSpace β]
    [ClosedIciTopology α]
    {s : Set β} (hs : IsCompact s) (ne_s : s.Nonempty)
    {f : β → α} (hf : ContinuousOn f s) :
    ∃ x ∈ s, IsMaxOn f s x

-- Compact metric spaces have uniform continuity (Napkin Proposition 8.4.8)
-- In Mathlib: CompactSpace.uniformContinuous_of_continuous
#check @CompactSpace.uniformContinuous_of_continuous

end Applications

/-! ## Section 8.5: Heine-Borel for metric spaces

Napkin Theorem 8.5.1: For metric spaces, the following are equivalent:
(1) sequentially compact
(2) complete and totally bounded
(3) every open cover has a finite subcover
-/
section HeineBorel

-- The equivalence is captured by various Mathlib results
#check @isCompact_iff_totallyBounded_isComplete

end HeineBorel

/-! ## Exercises -/
section Exercises

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

/-- Exercise 8A: Show that [0,1] and (0,1) are not homeomorphic. -/
-- Hint: one is compact and the other is not
theorem exercise_8A : ¬ Nonempty (Set.Icc (0:ℝ) 1 ≃ₜ Set.Ioo (0:ℝ) 1) := by
  sorry

/-- Exercise 8B: Show that a continuous function on a compact space
is bounded. -/
theorem exercise_8B {X : Type*} [TopologicalSpace X] [CompactSpace X]
    (f : X → ℝ) (hf : Continuous f) :
    ∃ M, ∀ x, |f x| ≤ M := by
  sorry

/-- Exercise 8C (Cantor's intersection theorem): In a compact space,
a decreasing sequence of nonempty closed sets has nonempty intersection. -/
theorem exercise_8C {X : Type*} [TopologicalSpace X] [CompactSpace X]
    {F : ℕ → Set X} (hclosed : ∀ n, IsClosed (F n))
    (hne : ∀ n, (F n).Nonempty) (hdec : ∀ n, F (n + 1) ⊆ F n) :
    (⋂ n, F n).Nonempty := by
  sorry

end Exercises
