import Mathlib.Data.Real.Basic

@[extern "my_add"]
opaque myAdd : UInt32 → UInt32 → UInt32

@[extern "my_add2"]
def myAdd2 (a : ℝ → ℝ) (b : ℝ → ℝ) : ℝ → ℝ :=
  a + b

instance : ToString (ℝ → ℝ) where
  toString := fun (_ : ℝ → ℝ) => "computed"
