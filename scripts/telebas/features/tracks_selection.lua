function HandleTracks()
  Log("HandleTracks")

  local tracks = Player:GetTracks()

  HandleAudioTracks(tracks)
  HandleSubtitleTracks(tracks)
end

function HandleAudioTracks(tracks)
  Log("========================== Audio Tracks =============================")

  local bestScore = DEFAULT_SCORE
  local winnerId = INVALID_ID
  local winnerTitle = INVALID_TITLE

  for _, track in ipairs(tracks) do
    if (Player:IsAudioTrack(track)) then
      local trackId = track[MPV.TRACK.KEY_ID]
      local trackTitle = tostring(track[MPV.TRACK.KEY_TITLE])

      local score = GetAudioTrackScore(track)

      if (score > bestScore) then
        bestScore = score
        winnerId = trackId
        winnerTitle = trackTitle
      end
    end
  end

  if (winnerId ~= INVALID_ID) then
    Log(string.format("============== Audio Winner id: %d | Title: %s", winnerId, winnerTitle))
    Player:SelectAudioTrack(winnerId)
  end
end

function HandleSubtitleTracks(tracks)
  Log("========================== Subtitles =============================")
  local bestScore = DEFAULT_SCORE
  local winnerId = INVALID_ID
  local winnerTitle = INVALID_TITLE

  for _, track in ipairs(tracks) do
    if (Player:IsSubtitle(track)) then
      local trackId = track[MPV.TRACK.KEY_ID]
      local trackTitle = tostring(track[MPV.TRACK.KEY_TITLE])

      local score = GetSubtitleScore(track)

      if (score > bestScore) then
        bestScore = score
        winnerId = trackId
        winnerTitle = trackTitle
      end
    end
  end

  if (winnerId ~= INVALID_ID) then
    Log(string.format("============== Subtitle Winner id: %d | Title: %s", winnerId, winnerTitle))
    Player:SelectSubtitleTrack(winnerId)
  end
end

function GetAudioTrackScore(track)
  local trackTitle = track[MPV.TRACK.KEY_TITLE]
  local trackLang = track[MPV.TRACK.KEY_LANG]

  local score = 0

  local titleScore = 0
  if (trackTitle) then
    titleScore = GetTitleScore(Tokens.audio.title, trackTitle)
  else
    titleScore = Tokens.audio.NO_TITLE
  end

  score = score + titleScore

  local langScore = GetLanguageScore(Tokens.audio.language, trackLang)
  score = score + langScore

  Log(string.format("AudioTrack: %-32s | lang: %-10s | Total Score: %d | title: %d lang: %d",
    trackTitle, trackLang, score, titleScore, langScore))

  return score
end

function GetSubtitleScore(track)
  local trackTitle = track[MPV.TRACK.KEY_TITLE]
  local trackLang = track[MPV.TRACK.KEY_LANG]

  local score = 0

  local titleScore = GetTitleScore(Tokens.subtitle.title, trackTitle)
  score = score + titleScore

  local langScore = GetLanguageScore(Tokens.subtitle.language, trackLang)
  score = score + langScore

  Log(string.format("Subtitle: %-32s | lang: %-10s | Total Score: %d | title: %d lang: %d",
    trackTitle, trackLang, score, titleScore, langScore))

  return score
end

-- Get score of title. Calcs sum of all matches (accumulative)
-- @param text: string - language text
function GetTitleScore(tokens, text)
  if (not text) then return 0 end

  local score = 0

  for token, points in pairs(tokens) do
    if (string.find(text, token)) then
      score = score + points
    end
  end

  return score
end

-- Get score of language. Calcs first match only (not accumulative)
-- @param text: string - language text
function GetLanguageScore(tokens, text)
  if (not text) then return 0 end

  for token, points in pairs(tokens) do
    if (string.find(text, token)) then
      return points
    end
  end

  return 0
end
