import Mathlib.Data.Real.Basic

@[extern "my_add"]
opaque myAdd : UInt32 → UInt32 → UInt32

@[extern "my_add2"]
def myAdd2 (a : ℝ) (b : ℝ) : ℝ :=
  a + b

instance : ToString ℝ where
  toString := fun (_ : ℝ) => "computed"
