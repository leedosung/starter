return {
  {
    "muhfaris/devtools.nvim",
    keys = {"<Leader>jp", "<Leader>jd", "<Leader>mip" },
    opts = function()
      local actions = require "devtools.actions"
      return {
        mappings = {
          v = {
            ["<Leader>jp"] = {
              func = actions.call "json.parse",
              desc = "Parse json string from selection visual text",
            },
          },
          n = {
            ["<Leader>mip"] = {
              func = actions.call "net.my_ip",
              desc = "Get my public IP address",
            },
            ["<Leader>jd"] = {
              func = actions.call "jwt.decode_token",
              desc = "JWT decode",
            },
          },
        },
      }
    end,
  }
}
