import gdext
import gdext/classes/[
  gdInputEvent,
  gdLabel,
]

type MyClass* = ptr object of Label
  #types defined here,for instance label_node:Label if class were different node type

method ready(self: MyClass) {.gdsync.} =
  #running code in the editor may produce unintented scene changes, even if nodes are hidden
  if Engine.isEditorHint: return

  #self.label_node.text if class were different node type
  self.text = "Listen up, buttercup"

method input(self: MyClass, event: GdRef[InputEvent]) {.gdsync.} =
  if event[].is_action_pressed("up"):
    self.text = "uppies"
  elif event[].is_action_pressed("down"):
    self.text = "downer..."
