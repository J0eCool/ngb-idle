import gdext

# import your extension classes here
import my_class
import thinger
import walkies

# ==================================

proc register_classes {.execon: initialize_scene.} =
  # register your extension classes here
  register MyClass
  register Stinger
  register Thinger
  register Walkies


GDExtensionEntryPoint
