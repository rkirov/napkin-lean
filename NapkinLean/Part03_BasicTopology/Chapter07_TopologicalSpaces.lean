import Mathlib.Topology.Basic
import Mathlib.Topology.Connected.Basic
import Mathlib.Topology.Connected.PathConnected
import Mathlib.Topology.Separation.Basic
import Mathlib.Tactic

/-! # Chapter 7: Topological spaces

This file formalizes Chapter 7 of Evan Chen's
*An Infinitely Large Napkin*, covering general topological spaces,
Hausdorff spaces, subspaces, connected and path-connected spaces,
and bases.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 7
-/

/-! ## Section 7.1: Forgetting the metric

Napkin Definition 7.1.1: A **topological space** is a pair (X, T) where
T is a collection of subsets of X (called open sets) satisfying:
- ∅ and X are open
- finite intersections of open sets are open
- arbitrary unions of open sets are open

In Mathlib, this is `TopologicalSpace`.
-/
section TopologicalSpaceDefinition

#check (TopologicalSpace : Type _ → Type _)

-- The axioms
#check @isOpen_empty
#check @isOpen_univ
#check @IsOpen.inter
#check @isOpen_iUnion

end TopologicalSpaceDefinition

/-! ## Section 7.2: Re-definitions

Continuous maps, homeomorphisms, closed sets, and closure
in the general topological setting.
-/
section Redefinitions

variable {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]

-- Continuous maps (Napkin Definition 7.2.1)
-- f is continuous iff preimages of open sets are open
recall continuous_def {X : Type*} {Y : Type*}
    [TopologicalSpace X] [TopologicalSpace Y] {f : X → Y} :
    Continuous f ↔ ∀ s, IsOpen s → IsOpen (f ⁻¹' s)

-- Closure (Napkin Definition 7.2.5)
#check @closure X

recall isClosed_closure {X : Type*} [TopologicalSpace X] {s : Set X} :
    IsClosed (closure s)

recall subset_closure {X : Type*} [TopologicalSpace X] {s : Set X} :
    s ⊆ closure s

end Redefinitions

/-! ## Section 7.3: Hausdorff spaces

Napkin Definition 7.3.1: A topological space X is **Hausdorff** (or T2) if
for any two distinct points x ≠ y, there exist disjoint open sets
U ∋ x and V ∋ y.
-/
section Hausdorff

#check (T2Space : ∀ (X : Type*) [TopologicalSpace X], Prop)

-- In a Hausdorff space, limits are unique
recall tendsto_nhds_unique {X : Type*} {Y : Type*} [TopologicalSpace X] [T2Space X]
    {f : Y → X} {l : Filter Y} {a b : X}
    [l.NeBot]
    (ha : Filter.Tendsto f l (nhds a))
    (hb : Filter.Tendsto f l (nhds b)) : a = b

-- Metric spaces are Hausdorff
example {X : Type*} [MetricSpace X] : T2Space X := inferInstance

end Hausdorff

/-! ## Section 7.4: Subspaces

Napkin Definition 7.4.1: If S ⊆ X, the **subspace topology** on S
consists of sets U ∩ S for open U ⊆ X.

In Mathlib, this is automatic via `instTopologicalSpaceSubtype`.
-/
section Subspaces

variable {X : Type*} [TopologicalSpace X] (S : Set X)

-- The subspace topology is automatic
example : TopologicalSpace S := inferInstance

end Subspaces

/-! ## Section 7.5: Connected spaces

Napkin Definition 7.5.3: A topological space X is **connected** if it
has no nontrivial clopen (both open and closed) subsets.

Napkin Definition 7.5.1: A set is **clopen** if it is both open and closed.
-/
section Connected

#check @IsClopen
#check @IsConnected

variable {X : Type*} [TopologicalSpace X]

-- Image of a connected set under a continuous map is connected
recall IsConnected.image {α : Type*} {β : Type*}
    [TopologicalSpace α] [TopologicalSpace β]
    {s : Set α} (H : IsConnected s)
    (f : α → β) (hf : ContinuousOn f s) : IsConnected (f '' s)

end Connected

/-! ## Section 7.6: Path-connected spaces

Napkin Definition 7.6.1: A **path** in X is a continuous map γ : [0,1] → X.

Napkin Definition 7.6.3: X is **path-connected** if any two points
can be joined by a path.
-/
section PathConnected

#check @Path
#check @IsPathConnected

-- Path-connected implies connected
recall IsPathConnected.isConnected {X : Type*} [TopologicalSpace X]
    {s : Set X} (hs : IsPathConnected s) : IsConnected s

end PathConnected

/-! ## Section 7.8: Bases

Napkin Definition 7.8.1: A **basis** for a topology on X is a
collection B of open sets such that every open set is a union
of elements of B.
-/
section Bases

recall TopologicalSpace.IsTopologicalBasis {α : Type*}
    [TopologicalSpace α] (s : Set (Set α)) : Prop

end Bases

/-! ## Exercises -/
section Exercises

variable {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

/-- Exercise 7A: Show that in a Hausdorff space, singleton sets are closed. -/
theorem exercise_7A [T2Space X] (x : X) : IsClosed ({x} : Set X) := by
  sorry

/-- Exercise 7B: Show that path-connected implies connected. -/
theorem exercise_7B {s : Set X} (h : IsPathConnected s) :
    IsConnected s := by
  sorry

/-- Exercise 7C: Show that if f : X → {0, 1} is continuous and X is connected,
then f is constant. -/
theorem exercise_7C [ConnectedSpace X] (f : X → Fin 2)
    (hf : Continuous f) : ∀ x y : X, f x = f y := by
  sorry

end Exercises
