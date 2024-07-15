import Lffi

open SLang

-- set_option  trace.compiler.cse false -- trace.compiler.ir.init true

def comp (n : ℕ+) : SLang ℕ := do
  let x ← UniformPowerOfTwoSample n
  return x + 1

def main : IO Unit := do

  let r1 : SLang ℕ := UniformPowerOfTwoSample 5
  let x ← run r1
  IO.println s!"Random: {x}"

  let r1 : SLang ℕ := UniformPowerOfTwoSample 5
  let x ← run r1
  IO.println s!"Random: {x}"

  let r2 : SLang ℕ := probPure (5 : ℕ)
  IO.println s!"Random: {← run r2}"

  let r3 : SLang ℕ := probBind (UniformPowerOfTwoSample 5) probPure
  IO.println s!"Random: {← run r3}"

  let rx : SLang ℕ := comp 5
  IO.println s!"Random: {← run rx}"

  -- let w1 : SLang ℕ := probWhile (fun _ => false) (fun x => probPure x) 6
  -- IO.println s!"While: {w1}"

  -- let w2 : SLang ℕ := probWhile (fun x => x != 3) (fun _ => UniformPowerOfTwoSample 2) 6
  -- IO.println s!"While: {w2}"

  -- IO.println s!"{(stangeAdd (createReal 51) (createReal 4))}"
