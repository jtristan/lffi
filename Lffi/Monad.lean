/-
Copyright (c) 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Jean-Baptiste Tristan
-/
import Mathlib.Probability.ProbabilityMassFunction.Basic
import Mathlib.Probability.ProbabilityMassFunction.Monad
import Mathlib.Probability.Distributions.Uniform

/-!
# SLang

This file describes the SLang language.

## Implementation notes

Each ``SLang`` value is a distribution over a type (normalization of these distributions
is proven separately). There are no restrictions on the type; the underlying probability
space should be interpreted as discrete.
-/

open Classical Nat ENNReal PMF

/--
The monad of ``SLang`` values
-/
abbrev SLang.{u} (α : Type u) : Type u := α → ℝ≥0∞

-- defining as a structure containing a closure

namespace PMF

def toSLang (p : PMF α) : SLang α := p.1

end PMF

namespace SLang

@[extern "prob_UniformP2"]
def UniformPowerOfTwoSample (n : ℕ+) : SLang ℕ :=
  toSLang (PMF.uniformOfFintype (Fin (2 ^ (log 2 n))))

@[extern "toString_SLang"]
opaque toStringSLang (n : SLang ℕ) : String

instance : ToString (SLang ℕ) where
  toString := toStringSLang

@[extern "prob_Pure"]
def probPure (a : T) : SLang T := fun a' => if a' = a then 1 else 0

@[extern "prob_Bind"]
def probBind (p : SLang T) (f : T → SLang U) : SLang U :=
  fun b => ∑' a, p a * f a b

instance : Monad SLang where
  pure := probPure
  bind := probBind

end SLang
