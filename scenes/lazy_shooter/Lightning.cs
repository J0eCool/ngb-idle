using Godot;
using System;

public partial class Lightning : Sprite2D
{
    [Export] int Width = 128;
    [Export] int Height = 128;

    public override void _Ready()
    {
        GenerateSprite();
    }

    public override void _Process(double delta)
    {
        if (Input.IsActionJustPressed("shoot")) {
            GD.Print("DOG");
            GenerateSprite();
        }
    }

    void GenerateSprite()
    {
        const int bpp = 4; // assuming the default format is 32bit
        var data = new byte[bpp*Width*Height];

        for (int y = 0; y < Height; ++y) {
            for (int x = 0; x < Width; ++x) {
                int i = bpp*(x + y*Width);
                data[i+0] = (byte)(GD.Randi()%0xff);;
                data[i+1] = (byte)(GD.Randi()%0xff);;
                data[i+2] = (byte)(GD.Randi()%0xff);;
                data[i+3] = 0xff;
            }
        }
        
        
        var image = Image.CreateFromData(Width, Height, false,
            Image.Format.Rgba8, data);
        Texture = ImageTexture.CreateFromImage(image);
    }
}
