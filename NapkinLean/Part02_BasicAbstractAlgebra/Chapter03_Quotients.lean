import Mathlib.GroupTheory.QuotientGroup.Basic
import Mathlib.Algebra.Group.Subgroup.Pointwise
import Mathlib.Tactic

/-! # Chapter 3: Homomorphisms and quotient groups

This file formalizes Chapter 3 of Evan Chen's
*An Infinitely Large Napkin*, covering group homomorphisms,
normal subgroups, quotient groups, and the first isomorphism theorem.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 3
-/

/-! ## Section 3.1: Generators and cyclic groups

Napkin Definition 3.1.2: A group G is **cyclic** if it is generated
by a single element, i.e. G = ⟨g⟩ for some g.
-/
section Generators

#check @IsCyclic

end Generators

/-! ## Section 3.2: Homomorphisms

Napkin Definition 3.2.1: A **group homomorphism** φ : G → H is a
map satisfying φ(g₁ * g₂) = φ(g₁) * φ(g₂).

In Mathlib, this is `MonoidHom` (notation: `G →* H`).
-/
section Homomorphisms

variable {G H : Type*} [Group G] [Group H]

#check @MonoidHom

-- A homomorphism preserves the identity (Napkin Proposition 3.2.3)
recall MonoidHom.map_one {M : Type*} {N : Type*} [MulOne M] [MulOne N]
    (f : M →* N) : f 1 = 1

-- A homomorphism preserves inverses (Napkin Proposition 3.2.3)
recall MonoidHom.map_inv {α : Type*} {β : Type*} [Group α] [DivisionMonoid β]
    (f : α →* β) (a : α) : f a⁻¹ = (f a)⁻¹

-- The kernel of a homomorphism (Napkin Definition 3.2.5)
#check @MonoidHom.ker

-- The image of a homomorphism
#check @MonoidHom.range

end Homomorphisms

/-! ## Section 3.3: Normal subgroups and cosets

Napkin Definition 3.3.1: A **coset** of H in G is a set of the form
g * H = {g * h | h ∈ H}.

Napkin Definition 3.3.5: A subgroup H of G is **normal** if
g * H * g⁻¹ = H for all g ∈ G, i.e. conjugation preserves H.
-/
section NormalSubgroups

variable {G : Type*} [Group G]

-- Normal subgroups (Napkin Definition 3.3.5)
-- Subgroup.Normal H states that ∀ n ∈ H, ∀ g, g * n * g⁻¹ ∈ H
#check @Subgroup.Normal G

-- The kernel of a homomorphism is always normal (Napkin Example 3.3.7)
recall MonoidHom.normal_ker {G : Type*} [Group G] {M : Type*} [MulOneClass M]
    (f : G →* M) : f.ker.Normal

end NormalSubgroups

/-! ## Section 3.4: Quotient groups

Napkin Definition 3.4.1: If N is a normal subgroup of G, the
**quotient group** G ⧸ N is the group of cosets of N in G.
-/
section QuotientGroups

variable {G : Type*} [Group G] (N : Subgroup G) [N.Normal]

-- The quotient group G ⧸ N
#check (G ⧸ N : Type _)

-- The quotient is a group
example : Group (G ⧸ N) := inferInstance

-- The canonical surjection G → G ⧸ N
#check @QuotientGroup.mk' G _ N

end QuotientGroups

/-! ## Section 3.5: The first isomorphism theorem

Napkin Theorem 3.5.1 (First isomorphism theorem): If φ : G →* H
is a group homomorphism, then G ⧸ ker φ ≃* range φ.
-/
section FirstIsomorphismTheorem

variable {G H : Type*} [Group G] [Group H]

-- First isomorphism theorem (Napkin Theorem 3.5.1)
#check @QuotientGroup.quotientKerEquivRange G _ H

end FirstIsomorphismTheorem

/-! ## Exercises -/
section Exercises

variable {G H : Type*} [Group G] [Group H]

/-- Exercise 3A: Show that the image of a group homomorphism is a subgroup. -/
-- This is already `MonoidHom.range` in Mathlib, so we verify it:
example (f : G →* H) : Subgroup H := f.range

/-- Exercise 3B: Show that every subgroup of index 2 is normal. -/
theorem exercise_3B (H : Subgroup G) (h : H.index = 2) : H.Normal := by
  sorry

end Exercises
