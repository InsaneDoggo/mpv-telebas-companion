Plugin (lua scripts) for [MPV Video Player](https://github.com/mpv-player/mpv)

## Features

- Smart(configurable) AudioTrack auto selection
- Smart(configurable) Subtitles auto selection

## Installation

Put following files:

- /scripts
- /mpv.conf

into C:\Users\<username>\AppData\Roaming\mpv


## Config 

Для настройки алгоритма выбора дорожек используйте:
/scripts/telebas/core/config.lua

Файл содержит список "подстрок"(tokens) и их "стоимость"(score)

Токены используются для поиска в title/language дорожкек(audio/subtitles), пример токенов: "japanese" или "HDrezka".
- Каждой дорожке присваивается score (сумма все найденных токенов)
- Побеждает дорожка с наибольшим кол-вом очков.
- Токенам можно задавать отрицательные числа (для уменьшения приоритета), например дли сабов "надписи" или "forced".


Известные проблемы:
- поиск подстроки чувствителен к регистру, поэтому для одной "подстроки" может понадобиться несколько токенов в конфиге:
	- "Надписи"
	- "надписи"
