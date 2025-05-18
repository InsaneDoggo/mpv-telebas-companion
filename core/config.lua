-- Note: smart patterns like [Aa] do not works for unicode symbols out of the box in Lua 5.1
-- Also it's hard to get corresponding utf8 lib compatible with current environment so
-- for now just use Extra tokens to cover all combinations

_G.Tokens = {
  subtitle = {
    title = {
      --  Good
      ["Полные"] = 100,
      ["полные"] = 100,
      ["Full"] = 100,
      ["full"] = 100,
      ["sdh"] = -100,

      -- Bad
      ["Надписи"] = -100,
      ["надписи"] = -100,
      ["Signs"] = -100,
      ["signs"] = -100,
      ["Forced"] = -100,
      ["forced"] = -100,

      -- Studio
      ["HDRezka"] = 50,
      ["hdrezka"] = 50,
      ["Лебовски"] = 50,
      ["лебовски"] = 50,
    },
    language = {
      ["Russian"] = 2000,
      ["russian"] = 2000,
      ["Rus"] = 2000,
      ["rus"] = 2000,
      ["Ru"] = 2000,
      ["ru"] = 2000,

      ["English"] = 1000,
      ["english"] = 1000,
      ["En"] = 1000,
      ["en"] = 1000,
      ["Eng"] = 1000,
      ["eng"] = 1000,
    }
  },

  audio = {
    NO_TITLE = 9000, -- usually tracks with no title means it's "original" one
    title = {
      --  Good
      ["Полные"] = 10,
      ["полные"] = 10,
      ["Full"] = 10,
      ["full"] = 10,
      ["sdh"] = -10,

      -- Bad
      ["Надписи"] = -10,
      ["надписи"] = -10,
      ["Signs"] = -10,
      ["signs"] = -10,
      ["Forced"] = -10,
      ["forced"] = -10,
    },
    language = {
      ["Original"] = 9000,
      ["original"] = 9000,

      ["Japanese"] = 5000,
      ["japanese"] = 5000,
      ["Jap"] = 5000,
      ["jap"] = 5000,
      ["Jp"] = 5000,
      ["jp"] = 5000,
      ["Ja"] = 5000,
      ["ja"] = 5000,

      ["English"] = 4000,
      ["english"] = 4000,
      ["Eng"] = 4000,
      ["eng"] = 4000,
      ["En"] = 4000,
      ["en"] = 4000,

      -- Sometimes original tracks has no title/lang at all, so skip Rus/Ukr for now

      -- ["Ukranian"] = 3000,
      -- ["ukranian"] = 3000,
      -- ["Ukr"] = 3000,
      -- ["ukr"] = 3000,
      -- ["Uk"] = 3000,
      -- ["uk"] = 3000,

      -- ["Russian"] = 1000,
      -- ["russian"] = 1000,
      -- ["Rus"] = 1000,
      -- ["rus"] = 1000,
      -- ["Ru"] = 1000,
      -- ["ru"] = 1000,
    }
  }
}
