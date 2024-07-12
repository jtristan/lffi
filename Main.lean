import Lffi

open SLang

-- set_option trace.compiler.ir.init

def comp (n : ℕ+) : SLang ℕ := do
  let x ← UniformPowerOfTwoSample n
  return x + 1

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

  let x : ℕ := Pap1 (fun (x : ℕ) => fun (y : ℕ) => x + y) 3 4
  IO.println s!"Printing partial application test: {x}"

  let x : ℕ := Pap2 (fun (x : ℕ) => fun (y : ℕ) => x + y) 3 4
  IO.println s!"Printing partial application test: {x}"

  let r1 : SLang ℕ := UniformPowerOfTwoSample 5
  IO.println s!"Random: {r1}"

  let r2 : SLang ℕ := probPure (5 : ℕ)
  IO.println s!"Random: {r2}"

  --let r3 : SLang ℕ := probBind (UniformPowerOfTwoSample 6) probPure
  --IO.println s!"Random: {r3}"

  --let rx : SLang ℕ := comp 5
  --IO.println s!"Random: {rx}"

-- Importance of createReal
-- Beware of coercions
-- can't just use uint32_t as is if code is not char or UInt32 otherwise least significatn bit problematic
