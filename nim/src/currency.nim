# Currency module
# Currencies are game-level objects

import gdext
import gdext/classes/[
  gdControl,
  gdLabel,
]

type
  Currency* = object of Resource
    name* {.gdexport.}: string
    count* {.gdexport.}: int
    limit* {.gdexport.}: int
  CurrencyBank* = ptr object of Control
    title* {.gdexport.}: string
    currency* {.gdexport.}: Resource

method ready(self: CurrencyBank) {.gdsync.} =
  # note this runs in the editor too
  let lbl = instantiate Label
  self.addChild(lbl)

# method process(self: CurrencyBank, dt: float) {.gdsync.} =
#   let lbl = instantiate Label
#   lbl.text= "Hello: " & self.title
#   self.addChild(lbl)
