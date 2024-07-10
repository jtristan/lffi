import Lake
open Lake DSL

package lffi where
  -- add package configuration options here

lean_lib «Lffi» where
  -- add library configuration options here

@[default_target]
lean_exe lffi where
  root := `Main
