import Lake

open Lake DSL
open System IO FS

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.10.0-rc2"


package lffi where
  -- add package configuration options here

lean_lib «Lffi» where
  -- add library configuration options here

@[default_target]
lean_exe lffi where
  root := `Main

target ffi.o pkg : FilePath := do
  let oFile := pkg.buildDir / "ffi.o"
  let srcJob ← inputTextFile <| pkg.dir / "ffi.cpp"
  let weakArgs := #["-I", (← getLeanIncludeDir).toString]
  buildO oFile srcJob weakArgs #["-fPIC"] "c++" getLeanTrace

extern_lib libleanffi pkg := do
  let ffiO ← ffi.o.fetch
  let name := nameToStaticLib "leanffi"
  buildStaticLib (pkg.nativeLibDir / name) #[ffiO]
