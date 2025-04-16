using Godot;
using System;

public partial class ShipController : CharacterBody2D
{
    [Export] float speeds;

    public override void _Ready()
    {
        GD.Print("Dawwwg");
        base._Ready();
    }
}
