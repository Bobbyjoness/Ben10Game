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
  nextobjectid = 33,
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
      data = "eJzt1MsJgDAQQMFgwD4Ey7QvwUosx3jz4AdCRGLmwVxDYNkNQZIktdSSzCfWLz8lNVqfdA/GjHenl6ju7uZozmq5q1ucc38llW/f0XhgNyVJKlPk1wYAAAAAAAAAAAAAgEps5H6Hkg=="
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
          id = 27,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 85,
          y = 253,
          width = 34,
          height = 53,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 85,
          y = 253,
          width = 34,
          height = 53,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 703,
          y = 208,
          width = 34,
          height = 53,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 455,
          y = 230,
          width = 34,
          height = 53,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 455,
          y = -13,
          width = 34,
          height = 53,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 609,
          y = 209,
          width = 34,
          height = 53,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
