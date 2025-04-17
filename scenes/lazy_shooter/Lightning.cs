using Godot;
using System;

public partial class Lightning : Sprite2D
{
    [Export] int Width = 128;
    [Export] int Height = 128;

    [Export] private int _xVariance = 25;
    [Export] private int _yVariance = 15;
    [Export] private int _gravity = 75;
    [Export] private int _centerVariance = 10;

    public override void _Ready()
    {
        GenerateSprite();
    }

    public override void _Process(double delta)
    {
        if (Input.IsActionJustPressed("shoot"))
        {
            GenerateSprite();
        }
    }

    public void GenerateSprite()
    {
        bool mips = false;
        var image = Image.CreateEmpty(Width, Height, mips, Image.Format.Rgba8);
        var c = Random.Shared.Next(-_centerVariance, _centerVariance);
        var p = new Vector2I(c + Width / 2, 0);
        while (p.X >= 0 && p.X < Width && p.Y >= 0 && p.Y < Height)
        {
            image.SetPixelv(p, Colors.White);

            var g = p.X - Width / 2;
            if (Roll(_xVariance + g)) p.X--;
            if (Roll(_xVariance - g)) p.X++;
            if (Roll(_gravity + _yVariance)) p.Y++;
            if (p.Y > 0 && Roll(_yVariance)) p.Y--;
        }

        Texture = ImageTexture.CreateFromImage(image);
    }

    private bool Roll(int percent)
    {
        return Random.Shared.Next(0, 100) < percent;
    }
}