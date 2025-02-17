Started playing around with tilemaps. Or tilesets. Should learn the difference between them.
I know there used to be a way to get autotiling set up, but I can't find it in the UI so documentation here we come.

Anyway the intention here is to make a 2d platformer shell where we can jump around, maybe shoot a megaman style bullet or two.

Try making a platformer movement controller as just a node that sits on the player, and makes its parent move the way we want a thing to move.
The thing we want is to figure out composable action scripts. Maybe build some state-holding abstraction to be a switchboard? Probably too much too soon.

> Make the simple thing first, only build complex when simple breaks down.
