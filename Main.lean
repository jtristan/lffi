import Lffi

open SLang Std

def comp (n : ℕ+) : SLang ℕ := do
  let x ← UniformPowerOfTwoSample n
  return x + 1

def main : IO Unit := do

  let sampleSize : ℕ := 5
  let sampleNum : ℕ := 10000

  let mut arr : Array ℕ := Array.mkArray (2^sampleSize) 0
  for _ in [:sampleNum] do
    let r ← run <| UniformPowerOfTwoSample ⟨ sampleSize , by simp ⟩
    let v := arr[r]!
    arr := arr.set! r (v + 1)

  let mut res : Array Float := Array.mkArray (2^sampleSize) 0.0
  for i in [:2^sampleSize] do
    let total : Float := arr[i]!.toFloat
    let freq : Float := total / sampleNum.toFloat
    res := res.set! i freq

  IO.println s!"Repeated uniform sampling: {res}"

  let rx : SLang ℕ := comp 5
  IO.println s!"Sampling SLang term: {← run rx}"

  let sampleSize : ℕ := 5
  let sampleNum : ℕ := 10000
  let mut arr2 : Array ℕ := Array.mkArray (2^sampleSize) 0
  for _ in [:sampleNum] do
    let r ← run <| probWhile (fun x => x % 2 == 0) (fun _ => UniformPowerOfTwoSample ⟨ sampleSize , by simp ⟩) 0
    let v := arr2[r]!
    arr2 := arr2.set! r (v + 1)

  let mut res2 : Array Float := Array.mkArray (2^sampleSize) 0.0
  for i in [:2^sampleSize] do
    let total : Float := arr2[i]!.toFloat
    let freq : Float := total / sampleNum.toFloat
    res2 := res2.set! i freq

  IO.println s!"Repeated uniform sampling with filtering: {res2}"
