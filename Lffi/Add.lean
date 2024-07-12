import Mathlib.Data.Real.Basic


/-
  Simpe example of interop where both sides agree on what
  values are represented
-/

@[extern "my_add"]
def myAdd (a : UInt32) (b : UInt32) : UInt32 :=
  a + b

/-
  Example where on the Lean side we work with Reals while on the
  C side we work with natural numbers
-/

@[extern "create_real"]
opaque createReal (x : ℕ) : ℝ

@[export nat_to_string]
def natToString (n : ℕ) : String :=
  n.repr

@[extern "my_print"]
opaque myPrint (r : ℝ) : String

instance : ToString ℝ where
  toString := myPrint

@[extern "my_add2"]
def myAdd2 (a b : ℝ) : ℝ :=
  a + b



/-
  Example where on the Lean side we work with Reals while on the
  C side we work with natural numbers
-/

variable {α : Type}

@[extern "create_real_fun"]
opaque createRealFun (x : ℕ) : α → ℝ

@[extern "my_print_fun"]
opaque myPrintFun (r : α → ℝ) : String

instance : ToString (α → ℝ) where
  toString := myPrintFun

@[extern "my_add2_fun"]
def myAdd2Fun (a : α → ℝ) (b : α → ℝ) : α → ℝ :=
  fun (x : α) => a x + b x
