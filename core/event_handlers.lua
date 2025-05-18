function OnPlayerPause()
  Log("[event] OnPlayerPause")
end

function OnPlayerPlay()
  Log("[event] OnPlayerPlay")
end

function OnStartFile()
  Log("[event] OnStartFile")
  ApplyDebugResolution()
end

function OnFileLoaded()
  Log("[event] OnFileLoaded")

  HandleTracks()
end
