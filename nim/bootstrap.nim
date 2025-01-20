import gdext

# import your extension classes here
import inventory
import my_class
import walkies

# ==================================

proc register_classes {.execon: initialize_scene.} =
  # register your extension classes here
  register Inventory
  register MyClass
  register Walkies


GDExtensionEntryPoint
