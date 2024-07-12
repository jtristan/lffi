import Lffi

open SLang

-- set_option trace.compiler.ir.init

def main : IO Unit := do
  IO.println s!"Simple UInt32 addition: {myAdd 2 3}"

  let a : ℝ := createReal 51
  IO.println s!"Printing a real created on the C side: {a}"
  let b : ℝ := createReal 50
  IO.println s!"Printing a real created on the C side: {b}"
  let c : ℝ := myAdd2 a b
  IO.println s!"Printing addition of reals created on the C side: {c}"

  let a : ℝ → ℝ := createRealFun 51
  IO.println s!"Printing a real created on the C side: {a}"
  let b : ℝ → ℝ := createRealFun 50
  IO.println s!"Printing a real created on the C side: {b}"
  let c : ℝ → ℝ := myAdd2Fun a b
  IO.println s!"Printing addition of reals created on the C side: {c}"


  --IO.println s!"Random: {UniformPowerOfTwoSample 4}"

-- Importance of createReal
-- Beware of coercions
-- can't just use uint32_t as is if code is not char or UInt32 otherwise least significatn bit problematic
