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

  mp.observe_property(MPV.PROPERTY_PAUSE, MPV.PROP_TYPE_BOOL, OnPauseStateChanged)
end

function Player:ListenToOnStartFile(callback)
  mp.register_event(MPV.EVENT_START_FILE, callback)
end

function Player:ListenToOnFileLoaded(callback)
  mp.register_event(MPV.EVENT_FILE_LOADED, callback)
end

-- ================================= Properties ======================================
function Player:GetTracks()
  return mp.get_property_native(MPV.PROPERTY_TRACK_LIST)
end

function Player:SelectAudioTrack(id)
  mp.set_property_native(MPV.PROPERTY_AUDIO_ID, id)
end

function Player:SelectSubtitleTrack(id)
  mp.set_property_native(MPV.PROPERTY_SUBTITLE_ID, id)
end

function Player:IsSubtitle(track)
  return track[MPV.TRACK.KEY_TYPE] == MPV.TRACK.TYPE_SUBTITLE
end

function Player:IsAudioTrack(track)
  return track[MPV.TRACK.KEY_TYPE] == MPV.TRACK.TYPE_AUDIO
end
