/-
Copyright (c) 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Jean-Baptiste Tristan
-/
import Mathlib.Probability.Distributions.Uniform

open Classical Nat ENNReal PMF

/--
The monad of ``SLang`` values
-/
abbrev SLang.{u} (α : Type u) : Type u := α → ℝ≥0∞

namespace PMF

def toSLang (p : PMF α) : SLang α := p.1

end PMF

namespace SLang

def probZero : SLang T := λ _ : T => 0

@[extern "prob_UniformP2"]
def UniformPowerOfTwoSample (n : ℕ+) : SLang ℕ :=
  toSLang (PMF.uniformOfFintype (Fin (2 ^ (log 2 n))))

@[extern "prob_Pure"]
def probPure (a : T) : SLang T := fun a' => if a' = a then 1 else 0

@[extern "prob_Bind"]
def probBind (p : SLang T) (f : T → SLang U) : SLang U :=
  fun b => ∑' a, p a * f a b

instance : Monad SLang where
  pure := probPure
  bind := probBind

def probWhileFunctional (cond : T → Bool) (body : T → SLang T) (wh : T → SLang T) : T → SLang T :=
  λ a : T =>
  if cond a
    then do
      let v ← body a
      wh v
    else return a

def probWhileCut (cond : T → Bool) (body : T → SLang T) (n : Nat) (a : T) : SLang T :=
  match n with
  | Nat.zero => probZero
  | succ n => probWhileFunctional cond body (probWhileCut cond body n) a

@[extern "prob_While"]
def probWhile (cond : T → Bool) (body : T → SLang T) (init : T) : SLang T :=
   fun x => ⨆ (i : ℕ), (probWhileCut cond body i init x)

@[extern "my_run"]
opaque run (c : SLang T) : IO T

end SLang
