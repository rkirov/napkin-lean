import Mathlib.RingTheory.UniqueFactorizationDomain.Defs
import Mathlib.RingTheory.EuclideanDomain
import Mathlib.RingTheory.Ideal.Maximal
import Mathlib.RingTheory.Ideal.Prime
import Mathlib.RingTheory.Localization.FractionRing
import Mathlib.Tactic

/-! # Chapter 5: Flavors of rings

This file formalizes Chapter 5 of Evan Chen's
*An Infinitely Large Napkin*, covering integral domains,
prime and maximal ideals, fields of fractions, UFDs,
and Euclidean domains.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 5
-/

/-! ## Section 5.1: Integral domains

Napkin Definition 5.1.1: An **integral domain** is a nonzero commutative
ring with no zero divisors: if $ab = 0$ then $a = 0$ or $b = 0$.

In Mathlib, this is the combination of `CommRing`, `IsDomain`, and `Nontrivial`.
-/
section IntegralDomains

-- IsDomain is a class extending IsCancelMulZero and Nontrivial
#check (IsDomain : ∀ (α : Type*) [inst : Semiring α], Prop)

variable {R : Type*} [CommRing R] [IsDomain R]

-- The key property: no zero divisors (Napkin Definition 5.1.1)
recall NoZeroDivisors.eq_zero_or_eq_zero_of_mul_eq_zero
    {M₀ : Type*} {_inst : Mul M₀} {_inst2 : Zero M₀}
    [self : NoZeroDivisors M₀] {a b : M₀} : a * b = 0 → a = 0 ∨ b = 0

-- Examples
example : IsDomain ℤ := inferInstance

end IntegralDomains

/-! ## Section 5.2: Prime ideals

Napkin Definition 5.2.1: An ideal $\mathfrak{p}$ of a commutative ring $R$
is **prime** if $\mathfrak{p} \neq R$ and whenever $ab \in \mathfrak{p}$,
either $a \in \mathfrak{p}$ or $b \in \mathfrak{p}$.

Napkin Theorem 5.2.4: $R/\mathfrak{p}$ is an integral domain if and only
if $\mathfrak{p}$ is prime.
-/
section PrimeIdeals

variable {R : Type*} [CommRing R]

#check @Ideal.IsPrime R

-- R/p is an integral domain iff p is prime (Napkin Theorem 5.2.4)
#check @Ideal.Quotient.isDomain R

end PrimeIdeals

/-! ## Section 5.3: Maximal ideals

Napkin Definition 5.3.1: An ideal $\mathfrak{m}$ is **maximal** if
$\mathfrak{m} \neq R$ and there is no ideal strictly between
$\mathfrak{m}$ and $R$.

Napkin Theorem 5.3.3: $R/\mathfrak{m}$ is a field if and only if
$\mathfrak{m}$ is maximal.

Napkin Corollary 5.3.5: Every maximal ideal is prime.
-/
section MaximalIdeals

variable {R : Type*} [CommRing R]

#check @Ideal.IsMaximal R

-- R/m is a field iff m is maximal (Napkin Theorem 5.3.3)
-- Forward direction:
#check @Ideal.Quotient.field R

-- Every maximal ideal is prime (Napkin Corollary 5.3.5)
#check @Ideal.IsMaximal.isPrime

end MaximalIdeals

/-! ## Section 5.4: Field of fractions

Napkin Definition 5.4.1: The **field of fractions** $\operatorname{Frac}(R)$
of an integral domain $R$ is the smallest field containing $R$, constructed
as equivalence classes of formal fractions $a/b$ with $b \neq 0$.
-/
section FractionField

variable (R : Type*) [CommRing R] [IsDomain R]

-- The fraction field of R
#check FractionRing R

-- It is indeed a field
noncomputable example : Field (FractionRing R) := inferInstance

-- The canonical injection R → Frac(R)
#check @algebraMap R (FractionRing R)

end FractionField

/-! ## Section 5.5: Unique factorization domains

Napkin Definition 5.5.1: A **unique factorization domain** (UFD) is an
integral domain in which every nonzero non-unit element can be written
as a product of irreducible elements, uniquely up to order and units.

In Mathlib, this is `UniqueFactorizationMonoid`.
-/
section UFDs

#check (UniqueFactorizationMonoid :
    ∀ (α : Type*) [inst : CommMonoidWithZero α], Prop)

-- ℤ is a UFD
example : UniqueFactorizationMonoid ℤ := inferInstance

-- Every PID is a UFD (Napkin Theorem 5.5.7)
-- This is an instance in Mathlib: `IsPrincipalIdealRing` → `UniqueFactorizationMonoid`

end UFDs

/-! ## Section 5.6: Euclidean domains

Napkin Definition 5.6.1: A **Euclidean domain** is an integral domain $R$
with a norm function $f : R \setminus \{0\} \to \mathbb{N}$ such that
for all $a, b \in R$ with $b \neq 0$, there exist $q, r$ with
$a = bq + r$ and either $r = 0$ or $f(r) < f(b)$.

In Mathlib, this is `EuclideanDomain`.
-/
section EuclideanDomains

#check (EuclideanDomain : Type _ → Type _)

-- ℤ is a Euclidean domain
example : EuclideanDomain ℤ := inferInstance

-- Every Euclidean domain is a PID (Napkin Theorem 5.6.3)
-- This follows from the instances: EuclideanDomain → IsPrincipalIdealRing

end EuclideanDomains

/-! ## Summary of ring hierarchy

The Napkin presents the following chain:
$$\text{Euclidean domain} \implies \text{PID} \implies \text{UFD}
  \implies \text{integral domain} \implies \text{commutative ring}$$

All of these implications are instances in Mathlib.
-/

/-! ## Exercises -/
section Exercises

variable {R : Type*} [CommRing R]

/-- Exercise 5A: Show that in an integral domain, if $ab = ac$ and $a \ne 0$
then $b = c$. -/
theorem exercise_5A [IsDomain R] {a b c : R} (ha : a ≠ 0) (h : a * b = a * c) :
    b = c := by
  sorry

/-- Exercise 5B: Show that every field is an integral domain. -/
-- This is an instance in Mathlib: Field → IsDomain
example {K : Type*} [Field K] : IsDomain K := inferInstance

end Exercises
