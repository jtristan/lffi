import Lffi

def main : IO Unit :=
  IO.println s!"Hello, {myAdd 2 3} {myAdd2 2 3}!"
