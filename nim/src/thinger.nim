import gdext
import gdext/classes/[gdNode2d]

type Thinger* = ptr object of Node2D
  #types defined here,for instance label_node:Label if class were different node type

method ready(self: Thinger) {.gdsync.} =
  #running code in the editor may produce unintented scene changes, even if nodes are hidden
  if Engine.isEditorHint: return

  #self.label_node.text if class were different node type
  print "Hey we did a thing"
  

type Stinger* = ptr object of Node2D
  #types defined here,for instance label_node:Label if class were different node type

method ready(self: Stinger) {.gdsync.} =
  #running code in the editor may produce unintented scene changes, even if nodes are hidden
  if Engine.isEditorHint: return

  #self.label_node.text if class were different node type
  print "We did a different thing, this time..."
