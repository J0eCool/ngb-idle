import gdext
import gdext/classes/[
  gdAnimationPlayer,
  gdCharacterBody2d,
  gdInputEvent,
  gdNode2D,
  gdSceneTree,
]

type Walkies* = ptr object of Node2D
  spd* {.gdexport.}: float = 500
  boundLo* {.gdexport.}: float = 128
  boundHi* {.gdexport.}: float = 1024
  scene* {.gdexport.}: gdref PackedScene

  player: CharacterBody2D
  anim: AnimationPlayer
  dx: int = 0
  adoorable: bool = false # if you can enter door


method ready(self: Walkies) {.gdsync.} =
  if Engine.isEditorHint: return
  self.player = self.getNode("Player") as CharacterBody2D
  self.anim = self.getNode("Player/AnimationPlayer") as AnimationPlayer

  let area = self.getNode("Area2D")
  discard area.connect("body_entered", self.callable("_on_body_entered"))
  discard area.connect("body_exited", self.callable("_on_body_exited"))

method process(self: Walkies, dt: float) {.gdsync.} =
  if Engine.isEditorHint: return
  case self.dx
  of -1: self.anim.play("walk_left")
  of +1: self.anim.play("walk_right")
  else: self.anim.play("RESET")

  discard self.player.moveAndCollide(vector2(dt * self.spd*self.dx, 0))

method input(self: Walkies, event: GdRef[InputEvent]) {.gdsync.} =
  if event[].is_action_pressed("left"):
    self.dx = -1
  elif event[].is_action_pressed("right"):
    self.dx = +1

  if event[].isActionReleased("left") or event[].isActionReleased("right"):
    self.dx = 0

  if self.adoorable and event[].is_action_pressed("enter"):
    discard self.get_tree().changeSceneToPacked(self.scene)


proc on_body_entered(self: Walkies) {.gdsync, name: "_on_body_entered".} =
  self.adoorable = true
proc on_body_exited(self: Walkies) {.gdsync, name: "_on_body_exited".} =
  self.adoorable = false
