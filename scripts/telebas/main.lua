require('utils.utils')
require('utils.constants')
require('utils.debug')

require('core.config')
require('core.player_api')
require('core.event_handlers')
require('core.state')

require('features.tracks_selection')


Player:ListenToPauseStateChange(OnPlayerPause, OnPlayerPlay)
Player:ListenToOnStartFile(OnStartFile)
Player:ListenToOnFileLoaded(OnFileLoaded)
