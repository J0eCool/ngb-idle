import gdext
import gdext/classes/[
  gdAnimationPlayer,
  gdInputEvent,
  gdNode2D,
]

type Walkies* = ptr object of Node2D
  spd* {.gdexport.}: float
  boundLo* {.gdexport.}: float
  boundHi* {.gdexport.}: float

  player: Node2D
  anim: AnimationPlayer
  dx: int

method ready(self: Walkies) {.gdsync.} =
  if Engine.isEditorHint: return
  self.player = self.getNode("Player") as Node2D
  self.anim = self.getNode("Player/AnimationPlayer") as AnimationPlayer

method process(self: Walkies, dt: float) {.gdsync.} =
  if Engine.isEditorHint: return
  case self.dx
  of -1: self.anim.play("walk_left")
  of +1: self.anim.play("walk_right")
  else: self.anim.play("RESET")

  var p = self.player.position
  p.x += dt * self.spd*self.dx
  p.x = clamp(p.x, self.boundLo, self.boundHi)
  self.player.position = p

method input(self: Walkies, event: GdRef[InputEvent]) {.gdsync.} =
  if event[].is_action_pressed("left"):
    self.dx = -1
  elif event[].is_action_pressed("right"):
    self.dx = +1

  if event[].isActionReleased("left") or event[].isActionReleased("right"):
    self.dx = 0
