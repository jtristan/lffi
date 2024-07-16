/-
Copyright (c) 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Jean-Baptiste Tristan
-/
import Lffi

open SLang Std

def comp (n : ℕ+) : SLang ℕ := do
  let x ← UniformPowerOfTwoSample n
  return x + 1

def main : IO Unit := do

  let sampleSize : ℕ := 5
  let sampleNum : ℕ := 10000

  let mut arr2 : Array ℕ := Array.mkArray (sampleSize) 0
  for _ in [:sampleNum] do
    let r ← run <| probWhile (fun x => x % 2 == 0) (fun _ => UniformPowerOfTwoSample ⟨ sampleSize , by aesop ⟩) 0
    let v := arr2[r]!
    arr2 := arr2.set! r (v + 1)

  let mut res2 : Array Float := Array.mkArray (sampleSize) 0.0
  for i in [:sampleSize] do
    let total : Float := arr2[i]!.toFloat
    let freq : Float := total / sampleNum.toFloat
    res2 := res2.set! i freq

  IO.println s!"Repeated uniform sampling with filtering: {res2}"
