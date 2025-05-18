function HandleTracks()
  Log("HandleTracks")

  local tracks = Player:GetTracks()

  HandleAudioTracks(tracks)
  HandleSubtitleTracks(tracks)
end

function HandleAudioTracks(tracks)
  Log("\n========================== Audio Tracks =============================")

  local bestScore = DEFAULT_SCORE
  local winnerTrack = nil

  for _, track in ipairs(tracks) do
    if (Player:IsAudioTrack(track)) then
      local score = GetAudioTrackScore(track)

      if (score > bestScore) then
        bestScore = score
        winnerTrack = track
      end
    end
  end

  if (winnerTrack) then
    Log(string.format("\nAudio Winner id: %d | lang: %s | Title: %s",
      winnerTrack[MPV.TRACK.KEY_ID],
      tostring(winnerTrack[MPV.TRACK.KEY_LANG]),
      tostring(winnerTrack[MPV.TRACK.KEY_TITLE])
    ))
    Player:SelectAudioTrack(winnerTrack[MPV.TRACK.KEY_ID])
  end

  Log("==================================================================")
end

function HandleSubtitleTracks(tracks)
  Log("\n========================== Subtitles =============================")
  local bestScore = DEFAULT_SCORE
  local winnerTrack = nil

  for _, track in ipairs(tracks) do
    if (Player:IsSubtitleTrack(track)) then
      local score = GetSubtitleScore(track)

      if (score > bestScore) then
        bestScore = score
        winnerTrack = track
      end
    end
  end

  if (winnerTrack) then
    Log(string.format("\nSubtitle Winner id: %d | lang: %s | Title: %s",
      winnerTrack[MPV.TRACK.KEY_ID],
      tostring(winnerTrack[MPV.TRACK.KEY_LANG]),
      tostring(winnerTrack[MPV.TRACK.KEY_TITLE])
    ))
    Player:SelectSubtitleTrack(winnerTrack[MPV.TRACK.KEY_ID])
  end

  Log("==================================================================")
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
