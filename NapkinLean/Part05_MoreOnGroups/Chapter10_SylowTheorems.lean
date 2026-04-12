import Mathlib.GroupTheory.Sylow
import Mathlib.GroupTheory.Subgroup.Simple
import Mathlib.Tactic

/-! # Chapter 10: The Sylow theorems

This file formalizes Chapter 10 of Evan Chen's
*An Infinitely Large Napkin*, covering the Sylow theorems,
simple groups, and classifying small groups.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 10
-/

/-! ## Section 10.1: Sylow theorems

Napkin Theorem 10.1.1 (Sylow theorems): Let G be a group of order
p ^ n * m where p does not divide m. Then:
- (Existence) G has a subgroup of order p ^ n (a Sylow p-subgroup)
- (Conjugacy) All Sylow p-subgroups are conjugate
- (Counting) The number nₚ of Sylow p-subgroups satisfies
  nₚ ≡ 1 (mod p) and nₚ divides m

In Mathlib, Sylow p-subgroups are bundled as `Sylow p G`.
-/
section SylowTheorems

variable (p : ℕ) [Fact (Nat.Prime p)] (G : Type*) [Group G]

-- The type of Sylow p-subgroups
recall Sylow (p : ℕ) (G : Type*) [Group G] : Type _

-- Sylow p-subgroups exist (for finite groups)
#check @Sylow.nonempty p G

-- All Sylow p-subgroups are conjugate
-- In Mathlib this is captured by the fact that Sylow p G
-- has a single orbit under conjugation

-- A Sylow subgroup is a subgroup
#check @Sylow.toSubgroup p G

end SylowTheorems

/-! ## Section 10.2: Simple groups

Napkin Definition 10.2.1: A group G is **simple** if it has no
normal subgroups other than {1} and G itself.
-/
section SimpleGroups

#check (IsSimpleGroup : ∀ (G : Type*) [Group G], Prop)

end SimpleGroups

/-! ## Exercises -/
section Exercises

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

variable {G : Type*} [Group G] [Fintype G]

/-- Exercise 10A (Cauchy's theorem): If p is prime and p divides |G|,
then G has an element of order p. -/
theorem exercise_10A (p : ℕ) [Fact (Nat.Prime p)]
    (hdvd : p ∣ Fintype.card G) :
    ∃ g : G, orderOf g = p := by
  sorry

/-- Exercise 10B: A group of order 15 is cyclic. -/
theorem exercise_10B (h : Fintype.card G = 15) : IsCyclic G := by
  sorry

end Exercises
