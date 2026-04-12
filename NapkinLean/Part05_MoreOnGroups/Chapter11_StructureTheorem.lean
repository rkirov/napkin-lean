import Mathlib.GroupTheory.Abelianization.Defs
import Mathlib.LinearAlgebra.FreeModule.PID
import Mathlib.Tactic

/-! # Chapter 11: The structure theorem for finitely generated abelian groups

This file formalizes Chapter 11 of Evan Chen's
*An Infinitely Large Napkin*, covering the fundamental theorem
of finitely generated abelian groups and the structure theorem
for modules over PIDs.

## References
* [Evan Chen, *An Infinitely Large Napkin*](https://venhance.github.io/napkin/Napkin.pdf), Chapter 11
-/

/-! ## Section 11.1: Finitely generated abelian groups

Napkin Theorem 11.1.1 (Fundamental theorem): Every finitely generated
abelian group is isomorphic to ℤ ^ r ⊕ ℤ/n₁ℤ ⊕ ··· ⊕ ℤ/nₖℤ
for some r ≥ 0 and integers n₁ | n₂ | ··· | nₖ > 1.
-/
section FTFGAG

-- The structure theorem for modules over PIDs is the general form
-- In Mathlib, this is built from several components:
#check @Module.Free
#check @Module.Finite

end FTFGAG

/-! ## Section 11.3: Smith normal form

Napkin Theorem 11.6.1 (Smith normal form): Any matrix over a PID
can be brought to diagonal form with divisibility conditions
via row and column operations.
-/
section SmithNormalForm

-- Smith normal form in Mathlib is available but technical
-- We simply note its existence here

end SmithNormalForm

/-! ## Exercises -/
section Exercises

-- Note: these are all in Mathlib, so exact? will find them trivially.
-- The point is to prove them from first principles.

/-- Exercise 11A: Show that ℤ/3ℤ × ℤ/5ℤ ≅ ℤ/15ℤ. -/
-- This follows from the Chinese Remainder Theorem
theorem exercise_11A :
    Nonempty (ZMod 3 × ZMod 5 ≃+* ZMod 15) := by
  sorry

end Exercises
