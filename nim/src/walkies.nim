import gdext
import gdext/classes/[
  gdAnimationPlayer,
  gdInputEvent,
  gdNode2D,
]

type Walkies* = ptr object of Node2D
  anim: AnimationPlayer
  #types defined here,for instance label_node:Label if class were different node type

method ready(self: Walkies) {.gdsync.} =
  #running code in the editor may produce unintented scene changes, even if nodes are hidden
  if Engine.isEditorHint: return
  self.anim = self.getNode("Player/AnimationPlayer") as AnimationPlayer

method input(self: Walkies, event: GdRef[InputEvent]) {.gdsync.} =
  if event[].is_action_pressed("left"):
    print("anim.play('walk_left')")
    self.anim.play("walk_left")
  elif event[].is_action_pressed("right"):
    print("anim.play('walk_right')")
    self.anim.play("walk_right")

  if event[].isActionReleased("left") or event[].isActionReleased("right"):
    print("anim.play('RESET')")
    self.anim.play("RESET")
