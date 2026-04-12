import Mathlib.LinearAlgebra.Eigenspace.Basic
import Mathlib.LinearAlgebra.Eigenspace.Triangularizable
import Mathlib.Tactic

/-! # Chapter 13: Eigen-things

This file formalizes the eigenvalues chapter of Evan Chen's
*An Infinitely Large Napkin*, covering eigenvectors, eigenvalues,
eigenspaces, and diagonalizability.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 13
-/

/-! ## Section 13.3: Eigenvectors and eigenvalues

Napkin Definition 13.3.1: An **eigenvector** of T : V → V is a nonzero
vector v such that T v = λ v for some scalar λ (the **eigenvalue**).

Napkin Definition 13.3.3: The **eigenspace** of λ is the set of all
v with T v = λ v (including zero).
-/
section Eigenvalues

variable {k : Type*} [Field k] {V : Type*} [AddCommGroup V] [Module k V]

-- The eigenspace of T for eigenvalue μ
#check @Module.End.eigenspace k V

-- HasEigenvector and HasEigenvalue
#check @Module.End.HasEigenvalue k V
#check @Module.End.HasEigenvector k V

end Eigenvalues

/-! ## Section 13.10: Diagonalizability

Napkin Definition 13.10.1: A linear map T is **diagonalizable** if
there exists a basis of eigenvectors.
-/
section Diagonalizability

variable {k : Type*} [Field k] {V : Type*} [AddCommGroup V] [Module k V]

-- In Mathlib, this concept is captured by the eigenspace decomposition
-- and `Module.End.IsSemisimple`

end Diagonalizability

/-! ## Exercises -/
section Exercises

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

variable {k : Type*} [Field k] {V : Type*} [AddCommGroup V] [Module k V]

/-- Exercise 13A: Eigenvectors for distinct eigenvalues are linearly
independent. -/
theorem exercise_13A (T : V →ₗ[k] V) {μ₁ μ₂ : k} (hne : μ₁ ≠ μ₂)
    {v₁ v₂ : V} (hv₁ : T v₁ = μ₁ • v₁) (hv₂ : T v₂ = μ₂ • v₂)
    (h₁ : v₁ ≠ 0) (h₂ : v₂ ≠ 0) :
    LinearIndependent k ![v₁, v₂] := by
  sorry

end Exercises
