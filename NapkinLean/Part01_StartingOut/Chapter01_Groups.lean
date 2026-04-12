import Mathlib.GroupTheory.OrderOfElement
import Mathlib.GroupTheory.Index
import Mathlib.Tactic

/-! # Chapter 1: Groups

This file formalizes Chapter 1 of Evan Chen's
*An Infinitely Large Napkin*, which introduces groups,
subgroups, isomorphisms, orders, and Lagrange's theorem.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 1
-/

/-! ## Section 1.1: Definition and examples of groups

Napkin Definition 1.1.1: A **group** is a pair (G, ⋆) where ⋆
is an associative binary operation on G with an identity element and inverses.

In Mathlib, this is `Group` (multiplicative) or `AddGroup` (additive),
which extends `DivInvMonoid` with the axiom `a⁻¹ * a = 1`.
-/

section GroupDefinition

-- Mathlib's Group class (Napkin Definition 1.1.1)
#check (Group : Type _ → Type _)

-- The key axioms
recall Group.inv_mul_cancel {G : Type*} [Group G] (a : G) : a⁻¹ * a = 1
recall mul_assoc {G : Type*} [Semigroup G] (a b c : G) : a * b * c = a * (b * c)
recall one_mul {M : Type*} [MulOneClass M] (a : M) : 1 * a = a
recall mul_one {M : Type*} [MulOneClass M] (a : M) : a * 1 = a

end GroupDefinition

/-! ### Examples of groups (Napkin Example 1.1.2) -/
section GroupExamples

-- (a) The trivial group
example : Group Unit := inferInstance

-- (b) The integers under addition
example : AddGroup ℤ := inferInstance

-- (c) The rationals under addition
example : AddGroup ℚ := inferInstance

-- (d) ℤ/nℤ under addition
example (n : ℕ) : AddGroup (ZMod n) := inferInstance

-- (e) The nonzero rationals under multiplication
-- In Mathlib: ℚˣ (the units of ℚ, i.e. invertible elements)
example : Group ℚˣ := inferInstance

end GroupExamples

/-! ### Napkin Proposition 1.1.3: Properties of groups

The identity is unique, inverses are unique, and (a⁻¹)⁻¹ = a.
-/
section GroupProperties

variable {G : Type*} [Group G]

-- Identity is unique (if a * b = b then a = 1)
recall mul_eq_right {M : Type*} [Monoid M] [IsRightCancelMul M] {a b : M} :
    a * b = b ↔ a = 1

-- Inverses are unique (a * b = 1 ↔ a = b⁻¹)
recall mul_eq_one_iff_eq_inv {G : Type*} [Group G] {a b : G} :
    a * b = 1 ↔ a = b⁻¹

-- Double inverse
recall inv_inv {G : Type*} [InvolutiveInv G] (a : G) : a⁻¹⁻¹ = a

-- Shoes and socks: (a * b)⁻¹ = b⁻¹ * a⁻¹
recall mul_inv_rev {G : Type*} [DivisionMonoid G] (a b : G) :
    (a * b)⁻¹ = b⁻¹ * a⁻¹

end GroupProperties

/-! ## Section 1.2: Isomorphisms

Napkin Definition 1.2.1: An **isomorphism** of groups is a bijective
function φ : G → H such that φ(g₁ ⋆ g₂) = φ(g₁) ⋆ φ(g₂).

In Mathlib, this is `MulEquiv` (notation: `G ≃* H`).
-/
section Isomorphisms

#check @MulEquiv

variable {G H : Type*} [Group G] [Group H]

-- An isomorphism preserves the group operation
recall MulEquiv.map_mul {M : Type*} {N : Type*} [Mul M] [Mul N]
    (f : M ≃* N) (x y : M) : f (x * y) = f x * f y

-- An isomorphism preserves the identity
recall MulEquiv.map_one {M : Type*} {N : Type*} [MulOneClass M] [MulOneClass N]
    (h : M ≃* N) : h 1 = 1

-- An isomorphism preserves inverses
recall MulEquiv.map_inv {G : Type*} {H : Type*} [Group G] [DivisionMonoid H]
    (h : G ≃* H) (x : G) : h x⁻¹ = (h x)⁻¹

end Isomorphisms

/-! ## Section 1.3: Orders of groups and elements

Napkin Definition 1.3.1: The **order** of a group G, denoted |G|,
is the number of elements of G.

Napkin Definition 1.3.3: The **order** of an element g ∈ G
is the smallest positive integer n such that g ^ n = 1.
-/
section Orders

-- Order of a finite group
#check @Fintype.card

-- Order of an element
#check @orderOf

-- g ^ orderOf g = 1
recall pow_orderOf_eq_one {G : Type*} [Monoid G] (x : G) :
    x ^ orderOf x = 1

end Orders

/-! ## Section 1.4: Subgroups

Napkin Definition 1.4.1: A **subgroup** H of a group G is a subset
H ⊆ G which is itself a group under the same operation.

In Mathlib, `Subgroup G` is a structure bundling a carrier set that is
closed under multiplication, inverses, and contains the identity.
-/
section Subgroups

variable {G : Type*} [Group G]

#check (Subgroup G : Type _)

-- A subgroup is closed under multiplication, inversion, and contains 1
recall Subgroup.mul_mem {G : Type*} [Group G] (H : Subgroup G)
    {x y : G} : x ∈ H → y ∈ H → x * y ∈ H
recall Subgroup.inv_mem {G : Type*} [Group G] (H : Subgroup G)
    {x : G} : x ∈ H → x⁻¹ ∈ H
recall Subgroup.one_mem {G : Type*} [Group G] (H : Subgroup G) : 1 ∈ H

end Subgroups

/-! ## Section 1.5: Lagrange's theorem

Napkin Theorem 1.5.3 (Lagrange): If H is a subgroup of a finite
group G, then |H| divides |G|.
-/
section Lagrange

-- Lagrange's theorem
recall Subgroup.card_subgroup_dvd_card {α : Type*} [Group α]
    (s : Subgroup α) : Nat.card ↥s ∣ Nat.card α

end Lagrange

/-! ## Exercises -/
section Exercises

variable {G : Type*} [Group G]

/-- Exercise 1A: Show that if g ^ 2 = 1 for every g in G, then G is abelian. -/
theorem exercise_1A (h : ∀ g : G, g * g = 1) : ∀ a b : G, a * b = b * a := by
  sorry

/-- Exercise 1B: Let G be a group of even order.
Show that there exists g in G with g ≠ 1 and g ^ 2 = 1. -/
theorem exercise_1B [Fintype G] (h : Even (Fintype.card G)) :
    ∃ g : G, g ≠ 1 ∧ g * g = 1 := by
  sorry

/-- Exercise 1C: Show that every group of prime order is cyclic. -/
theorem exercise_1C [Fintype G] (hp : Nat.Prime (Fintype.card G)) :
    IsCyclic G := by
  sorry

end Exercises
