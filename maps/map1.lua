return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 120,
  height = 40,
  tilewidth = 21,
  tileheight = 21,
  nextlayerid = 3,
  nextobjectid = 55,
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
      columns = 30,
      image = "../assets/spritesheet.png",
      imagewidth = 692,
      imageheight = 692,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 21,
        height = 21
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
      id = 1,
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
      id = 2,
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
        },
        {
          id = 42,
          name = "savageBrute",
          type = "",
          shape = "rectangle",
          x = 309.5,
          y = 152,
          width = 49,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "savageBrute",
          type = "",
          shape = "rectangle",
          x = 349.5,
          y = 281,
          width = 49,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 50,
          name = "savageBrute",
          type = "",
          shape = "rectangle",
          x = 570.5,
          y = 282,
          width = 49,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "savageBrute",
          type = "",
          shape = "rectangle",
          x = 666.5,
          y = 278,
          width = 49,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "savageBrute",
          type = "",
          shape = "rectangle",
          x = 762.5,
          y = 277,
          width = 49,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 53,
          name = "savageBrute",
          type = "",
          shape = "rectangle",
          x = 462.5,
          y = 283,
          width = 49,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 54,
          name = "savageBrute",
          type = "",
          shape = "rectangle",
          x = 255.5,
          y = 281,
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
