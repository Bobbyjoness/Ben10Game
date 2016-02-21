return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.14.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 120,
  height = 40,
  tilewidth = 21,
  tileheight = 21,
  nextobjectid = 8,
  properties = {
    ["GRAVITY"] = "9.8",
    ["airComp"] = "Oxygen",
    ["friction"] = "1.4"
  },
  tilesets = {
    {
      name = "world",
      firstgid = 1,
      tilewidth = 21,
      tileheight = 21,
      spacing = 2,
      margin = 2,
      image = "../assets/spritesheet.png",
      imagewidth = 692,
      imageheight = 692,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 900,
      tiles = {
        {
          id = 2,
          properties = {
            ["hat"] = "1"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "collidableWorld",
      x = 0,
      y = 0,
      width = 120,
      height = 40,
      visible = true,
      opacity = 1,
      properties = {
        ["collidable"] = "true"
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJztzsEJACAMALFCwT0E959Rn91ALTnI/yIkSZIkSZIk6b3GkcW6uyNJUpuS1iYAAAAAAAAAAAAAwCc2qPN06w=="
    },
    {
      type = "objectgroup",
      name = "Spawn",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "PlayerSpawn",
          type = "",
          shape = "rectangle",
          x = 45,
          y = 269,
          width = 27,
          height = 27,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 134,
          y = 271,
          width = 20,
          height = 27,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 434,
          y = 283,
          width = 20,
          height = 27,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 693,
          y = 284,
          width = 20,
          height = 27,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 850,
          y = 281,
          width = 20,
          height = 27,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
