import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.MetricSpace.Isometry
import Mathlib.Topology.MetricSpace.Lipschitz
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas
import Mathlib.Topology.Order
import Mathlib.Tactic

/-! # Chapter 2: Metric spaces

This file formalizes Chapter 2 of Evan Chen's
*An Infinitely Large Napkin*, which introduces metric spaces,
convergence, continuous maps, homeomorphisms, open and closed sets.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 2
-/

/-! ## Section 2.1: Definition and examples of metric spaces

Napkin Definition 2.1.1: A **metric space** is a pair $(M, d)$ where
$d : M \times M \to \mathbb{R}_{\geq 0}$ satisfies positivity,
symmetry, and the triangle inequality.

In Mathlib, this is `MetricSpace`, which extends `PseudoMetricSpace`
with the separation axiom (d(x,y) = 0 → x = y).
-/
section MetricSpaceDefinition

#check (MetricSpace : Type _ → Type _)

variable {X : Type*} [PseudoMetricSpace X]

-- The distance function
#check @dist X

-- Key axioms
recall dist_self {α : Type*} [PseudoMetricSpace α] (x : α) : dist x x = 0
recall dist_comm {α : Type*} [PseudoMetricSpace α] (x y : α) : dist x y = dist y x
recall dist_triangle {α : Type*} [PseudoMetricSpace α] (x y z : α) :
    dist x z ≤ dist x y + dist y z
recall dist_nonneg {α : Type*} [PseudoMetricSpace α] {x y : α} : 0 ≤ dist x y

-- Separation axiom (what distinguishes MetricSpace from PseudoMetricSpace)
#check @eq_of_dist_eq_zero

end MetricSpaceDefinition

/-! ### Examples of metric spaces (Napkin Example 2.1.4) -/
section MetricExamples

-- ℝ with the standard metric
example : MetricSpace ℝ := inferInstance

-- ℝ² with the Euclidean metric
noncomputable example : MetricSpace (EuclideanSpace ℝ (Fin 2)) := inferInstance

end MetricExamples

/-! ## Section 2.2: Convergence in metric spaces

Napkin Definition 2.2.1: A sequence $(x_n)$ in a metric space **converges**
to a limit $x$ if for every $\varepsilon > 0$ there exists $N$ such that
$d(x_n, x) < \varepsilon$ for all $n \geq N$.
-/
section Convergence

-- In Mathlib, convergence is expressed via filters
#check @Filter.Tendsto
#check @Metric.tendsto_atTop

-- Limits are unique in metric spaces (Napkin Proposition 2.2.4)
recall tendsto_nhds_unique {X : Type*} {Y : Type*} [TopologicalSpace X] [T2Space X]
    {f : Y → X} {l : Filter Y} {a b : X}
    [l.NeBot]
    (ha : Filter.Tendsto f l (nhds a))
    (hb : Filter.Tendsto f l (nhds b)) : a = b

end Convergence

/-! ## Section 2.3: Continuous maps

Napkin Definition 2.3.1: A function $f : M \to N$ between metric spaces
is **continuous at a point** $p$ if for every $\varepsilon > 0$ there
exists $\delta > 0$ such that $d(f(x), f(p)) < \varepsilon$ whenever
$d(x, p) < \delta$.
-/
section ContinuousMaps

variable {X Y : Type*} [PseudoMetricSpace X] [PseudoMetricSpace Y]

-- The ε-δ characterization (Napkin Definition 2.3.1)
recall Metric.continuousAt_iff {α : Type*} {β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] {f : α → β} {a : α} :
    ContinuousAt f a ↔ ∀ ε > 0, ∃ δ > 0, ∀ y, dist y a < δ → dist (f y) (f a) < ε

-- Continuous on the whole space (Napkin Definition 2.3.5)
recall Metric.continuous_iff {α : Type*} {β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] {f : α → β} :
    Continuous f ↔ ∀ x, ∀ ε > 0, ∃ δ > 0, ∀ y, dist y x < δ → dist (f y) (f x) < ε

-- Composition of continuous maps is continuous (Napkin Proposition 2.3.7)
recall Continuous.comp {X : Type*} {Y : Type*} {Z : Type*}
    [TopologicalSpace X] [TopologicalSpace Y] [TopologicalSpace Z]
    {f : X → Y} {g : Y → Z}
    (hg : Continuous g) (hf : Continuous f) : Continuous (g ∘ f)

end ContinuousMaps

/-! ## Section 2.4: Homeomorphisms

Napkin Definition 2.4.1: A **homeomorphism** is a continuous bijection
whose inverse is also continuous.

In Mathlib, this is `Homeomorph` (notation: `X ≃ₜ Y`).
-/
section Homeomorphisms

variable {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]

#check (X ≃ₜ Y : Type _)

-- A homeomorphism is continuous
#check @Homeomorph.continuous X Y

end Homeomorphisms

/-! ## Section 2.6: Open sets

Napkin Definition 2.6.1: An **open ball** $B(p, r)$ is the set of
points within distance $r$ of $p$.

Napkin Definition 2.6.3: A set $U$ is **open** if for every $p \in U$,
there exists $r > 0$ such that $B(p, r) \subseteq U$.
-/
section OpenSets

variable {X : Type*} [PseudoMetricSpace X]

-- Open ball (Napkin Definition 2.6.1)
#check @Metric.ball X

recall Metric.mem_ball {α : Type*} [PseudoMetricSpace α] {x y : α} {ε : ℝ} :
    y ∈ Metric.ball x ε ↔ dist y x < ε

-- A set is open iff every point has an open ball contained in it (Napkin Definition 2.6.3)
recall Metric.isOpen_iff {α : Type*} [PseudoMetricSpace α] {s : Set α} :
    IsOpen s ↔ ∀ x ∈ s, ∃ ε > 0, Metric.ball x ε ⊆ s

-- Open balls are open (Napkin Example 2.6.6)
recall Metric.isOpen_ball {α : Type*} [PseudoMetricSpace α] {x : α} {ε : ℝ} :
    IsOpen (Metric.ball x ε)

-- Finite intersections of open sets are open (Napkin Theorem 2.6.10)
recall IsOpen.inter {X : Type*} [TopologicalSpace X]
    {s t : Set X} (hs : IsOpen s) (ht : IsOpen t) : IsOpen (s ∩ t)

-- Arbitrary unions of open sets are open (Napkin Theorem 2.6.10)
recall isOpen_iUnion {X : Type*} {ι : Sort*} [TopologicalSpace X]
    {f : ι → Set X} (h : ∀ i, IsOpen (f i)) : IsOpen (⋃ i, f i)

end OpenSets

/-! ## Section 2.7: Closed sets

Napkin Definition 2.7.1: A set $S$ is **closed** if its complement is open.
-/
section ClosedSets

variable {X : Type*} [PseudoMetricSpace X]

-- Closed sets are complements of open sets (Napkin Definition 2.7.1)
recall isOpen_compl_iff {X : Type*} {s : Set X} [TopologicalSpace X] :
    IsOpen sᶜ ↔ IsClosed s

-- Closed balls are closed
-- In Mathlib: `Metric.isClosed_closedBall` requires an import from Pseudo.Lemmas
-- We verify via `example` since the exact recall name varies across Mathlib versions
example {α : Type*} [PseudoMetricSpace α] (x : α) (ε : ℝ) :
    IsClosed (Metric.closedBall x ε) := Metric.isClosed_closedBall

end ClosedSets

/-! ## Exercises -/
section Exercises

variable {X Y : Type*} [MetricSpace X] [MetricSpace Y]

/-- Exercise 2A: Show that every convergent sequence in a metric space is bounded. -/
theorem exercise_2A {f : ℕ → X} {a : X}
    (hf : Filter.Tendsto f Filter.atTop (nhds a)) :
    ∃ R, ∀ n, dist (f n) a ≤ R := by
  sorry

/-- Exercise 2B: Show that a map $f : M \to N$ is continuous if and only if
the preimage of every open set is open. -/
theorem exercise_2B (f : X → Y) :
    Continuous f ↔ ∀ U, IsOpen U → IsOpen (f ⁻¹' U) := by
  sorry

end Exercises
