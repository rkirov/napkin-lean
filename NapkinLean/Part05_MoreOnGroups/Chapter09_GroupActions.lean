import Mathlib.GroupTheory.GroupAction.Basic
import Mathlib.GroupTheory.GroupAction.ConjAct
import Mathlib.GroupTheory.GroupAction.Quotient
import Mathlib.Tactic

/-! # Chapter 9: Group actions

This file formalizes Chapter 9 of Evan Chen's
*An Infinitely Large Napkin*, covering group actions,
stabilizers, orbits, Burnside's lemma, and conjugacy classes.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 9
-/

/-! ## Section 9.1: Definition of a group action

Napkin Definition 9.1.1: A **group action** of G on X is a map
G × X → X satisfying (g₁ * g₂) • x = g₁ • (g₂ • x) and 1 • x = x.

In Mathlib, this is `MulAction`.
-/
section GroupActionDefinition

recall MulAction (α : Type*) (β : Type*)
    [Monoid α] : Type _

variable {G : Type*} {X : Type*} [Group G] [MulAction G X]

-- The key axioms
#check @MulAction.one_smul
#check @mul_smul

end GroupActionDefinition

/-! ## Section 9.2: Stabilizers and orbits

Napkin Definition 9.2.1: The **stabilizer** of x ∈ X is the set
of g ∈ G which fix x, i.e. Stab(x) = {g ∈ G | g • x = x}.

Napkin Definition 9.2.3: The **orbit** of x ∈ X is the set
{g • x | g ∈ G}.
-/
section StabilizersAndOrbits

variable {G : Type*} {X : Type*} [Group G] [MulAction G X]

-- Stabilizer (Napkin Definition 9.2.1)
recall MulAction.stabilizer (G : Type*) {α : Type*}
    [Group G] [MulAction G α] (a : α) : Subgroup G

-- Orbit (Napkin Definition 9.2.3)
recall MulAction.orbit (γ : Type*) {α : Type*}
    [SMul γ α] (a : α) : Set α

-- Orbit-stabilizer theorem (Napkin Theorem 9.2.5):
-- |orbit(x)| * |stabilizer(x)| = |G|
-- In Mathlib: MulAction.card_orbit_mul_card_stabilizer_eq_card_group

end StabilizersAndOrbits

/-! ## Section 9.4: Conjugation

Napkin Definition 9.4.1: The **conjugacy class** of g ∈ G is the set
{h * g * h⁻¹ | h ∈ G}, i.e. the orbit of g under the conjugation action.

Napkin Definition 9.4.3: The **center** Z(G) is the set of elements
that commute with everything: Z(G) = {g ∈ G | ∀ h, g * h = h * g}.
-/
section Conjugation

variable {G : Type*} [Group G]

-- The center of a group
#check @Subgroup.center G

-- The class equation: |G| = |Z(G)| + sum of nontrivial conjugacy class sizes
-- In Mathlib this follows from the orbit-stabilizer theorem applied to ConjAct

end Conjugation

/-! ## Exercises -/
section Exercises

variable {G : Type*} [Group G]

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

/-- Exercise 9A: The center Z(G) is a normal subgroup of G. -/
theorem exercise_9A : (Subgroup.center G).Normal := by
  sorry

/-- Exercise 9B: If G/Z(G) is cyclic, then G is abelian. -/
theorem exercise_9B [Fintype G]
    (h : IsCyclic (G ⧸ Subgroup.center G)) :
    ∀ a b : G, a * b = b * a := by
  sorry

end Exercises
