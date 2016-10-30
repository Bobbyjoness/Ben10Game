return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.17.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 120,
  height = 40,
  tilewidth = 21,
  tileheight = 21,
  nextobjectid = 42,
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
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
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
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "PlayerSpawn",
          type = "",
          shape = "rectangle",
          x = 711,
          y = 39,
          width = 27,
          height = 27,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "Martian",
          type = "",
          shape = "rectangle",
          x = 438.5,
          y = 91,
          width = 49,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "bigDude",
          type = "",
          shape = "rectangle",
          x = 2462.83,
          y = 276.667,
          width = 49,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
