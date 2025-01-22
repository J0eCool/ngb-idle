# Currency module
# Currencies are game-level objects

import gdext
import gdext/classes/[
  gdControl,
]

type
  Currency* = object of Resource
    name* {.gdexport.}: string
    count* {.gdexport.}: int
    limit* {.gdexport.}: int
  CurrencyBank* = ptr object of Control
    title* {.gdexport.}: string
    # currencies* {.gdexport.}: Array
