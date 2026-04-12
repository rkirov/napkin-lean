import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.LinearAlgebra.Basis.Basic
import Mathlib.Tactic

/-! # Chapter 12: Vector spaces

This file formalizes the vector spaces chapter of Evan Chen's
*An Infinitely Large Napkin*, covering modules, vector spaces,
bases, linear maps, and the rank-nullity theorem.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 12
-/

/-! ## Section 12.2: Modules and vector spaces

Napkin Definition 12.2.1: An **R-module** is an abelian group M with
a scalar multiplication R × M → M satisfying the usual axioms.

Napkin Definition 12.2.3: A **vector space** is an R-module where R
is a field.
-/
section ModulesAndVectorSpaces

-- Modules
#check (Module : ∀ (R : Type*) (M : Type*) [Semiring R] [AddCommMonoid M], Type _)

-- Every field gives a vector space
example (k : Type*) [Field k] (V : Type*) [AddCommGroup V] [Module k V] :
    Module k V := inferInstance

end ModulesAndVectorSpaces

/-! ## Section 12.4: Linear independence, spans, and bases

Napkin Definition 12.4.1: Vectors are **linearly independent** if no
nontrivial linear combination equals zero.

Napkin Definition 12.4.4: A **basis** is a linearly independent spanning set.
-/
section Bases

#check @LinearIndependent
#check @Module.Basis

variable {k : Type*} [Field k] {V : Type*} [AddCommGroup V] [Module k V]

-- Dimension is well-defined (Napkin Theorem 12.4.8)
#check @Module.finrank

end Bases

/-! ## Section 12.5: Linear maps

Napkin Definition 12.5.1: A **linear map** T : V → W is a map
preserving addition and scalar multiplication.

In Mathlib, this is `LinearMap` (notation: `V →ₗ[k] W`).
-/
section LinearMaps

variable {k : Type*} [Field k]
variable {V W : Type*} [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

#check (V →ₗ[k] W)

-- A linear map preserves addition and scaling
recall LinearMap.map_add {R : Type*} {R₂ : Type*} {M : Type*} {M₂ : Type*}
    [Semiring R] [Semiring R₂] [AddCommMonoid M] [AddCommMonoid M₂]
    [Module R M] [Module R₂ M₂] {σ₁₂ : R →+* R₂}
    (f : M →ₛₗ[σ₁₂] M₂) (x y : M) : f (x + y) = f x + f y

-- Kernel of a linear map
#check @LinearMap.ker

-- Image of a linear map
#check @LinearMap.range

end LinearMaps

/-! ## Section 12.7: Rank-nullity theorem

Napkin Theorem 12.7.5 (Rank-nullity): dim V = dim(ker T) + dim(im T).
-/
section RankNullity

variable {k : Type*} [Field k]
variable {V W : Type*} [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

-- Rank-nullity theorem
recall LinearMap.finrank_range_add_finrank_ker
    {K : Type*} {V : Type*}
    [DivisionRing K] [AddCommGroup V] [Module K V]
    {V₂ : Type*} [AddCommGroup V₂] [Module K V₂]
    [FiniteDimensional K V]
    (f : V →ₗ[K] V₂) :
    Module.finrank K (LinearMap.range f) + Module.finrank K (LinearMap.ker f) =
    Module.finrank K V

end RankNullity

/-! ## Exercises -/
section Exercises

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

variable {k : Type*} [Field k]
variable {V W : Type*} [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- Exercise 12A: A linear map between spaces of equal finite dimension
is injective iff it is surjective. -/
theorem exercise_12A [FiniteDimensional k V] [FiniteDimensional k W]
    (h : Module.finrank k V = Module.finrank k W)
    (f : V →ₗ[k] W) : Function.Injective f ↔ Function.Surjective f := by
  sorry

end Exercises
