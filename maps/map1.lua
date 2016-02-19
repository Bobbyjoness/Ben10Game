return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.14.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 40,
  tilewidth = 21,
  tileheight = 21,
  nextobjectid = 3,
  properties = {
    ["friction"] = ".009999"
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
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "collidableWorld",
      x = 0,
      y = 0,
      width = 40,
      height = 40,
      visible = true,
      opacity = 1,
      properties = {
        ["collidable"] = "true"
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJztw0EJAAAIBLADk9i/pCV8CG6wBACATXV8q6qq6oMDlch8OQ=="
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
        }
      }
    }
  }
}
