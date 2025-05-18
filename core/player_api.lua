Player = {}

-- ================================= Events ======================================
function Player:ListenToPauseStateChange(onPauseCallback, onPlayCallback)
  local function OnPauseStateChanged(_, value)
    if value then
      onPauseCallback()
    else
      onPlayCallback()
    end
  end

  mp.observe_property("pause", "bool", OnPauseStateChanged)
end

function Player:ListenToOnStartFile(callback)
  mp.register_event("start-file", callback)
end

function Player:ListenToOnFileLoaded(callback)
  mp.register_event("file-loaded", callback)
end

-- ================================= Properties ======================================
function Player:GetTracks()
  return mp.get_property_native("track-list")
end

function Player:SelectAudioTrack(id)
  mp.set_property_native("aid", id)
end

function Player:SelectSubtitleTrack(id)
  mp.set_property_native("sid", id)
end
