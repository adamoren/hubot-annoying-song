# Description:
#   Sing an annoying song.  I'd suggest only using this for debug purposes.
#
# Commands:
#   sing <song> - sing the song specified
#   sing - sing a random song
#   stop - makes the singing stop
#
# Author:
#   Andrew Lucas <andrewl@resin.io> <sqweelygig@gmail.com>

module.exports = (robot) ->

  interval = null
  song = null
  line = 0
  songs = {
    'badger': [
      'badger, badger, badger, badger, badger',
      'badger, badger, badger, badger, badger',
      'mushroom, mushroom',
      'badger, badger, badger, badger, badger',
      'badger, badger, badger, badger, badger',
      'mushroom, mushroom',
      'badger, badger, badger, badger, badger',
      'badger, badger, badger, badger, badger',
      'mushroom, mushroom'
      'badger, badger, badger, badger, badger',
      'badger, badger, badger, badger, badger',
      'argh! Snake, a snake!',
      'snaaake! A snaaaake, oooh its a snake!',
      "it's a badger, badger, badger, badger, badger",
      'badger, badger, badger, badger, badger',
      'mushroom, mushroom'
    ],
    'llama': [
      "Here's a llama, there's a llama, and another little llama",
      'Fuzzy llama, funny llama, llama, llama, duck',
      'Llama, llama, cheesecake, llama, tablet, brick, potato, llama',
      'Llama, llama, mushroom, llama, llama, llama, duck',
      'I was once a tree house, I lived in a cake',
      'But I never saw the way, the orange slayed the rake',
      'I was only three years dead, but it told a tale',
      'And now listen little child, To the safety rail',
      'Did you ever see a llama kiss a llama on the llama?',
      "Llama's llama, tastes of llama. Llama llama duck",
      'Half a llama, twice a llama, not a llama',
      'Farmer llama, llama in a car, alarm a llama, llama, duck',
      "Is that how it's told now? Is it all so old?",
      'Is it made of lemon juice? Doorknob, ankle, cold',
      "Now my song is getting thin, I've run out of luck",
      'Time for me to retire now, and become a duck'
    ],
    'short': [
      "I will sing you a song that's not very long"
    ]
  }

  robot.hear /^(sing)\b/i, (res) ->
    clearInterval interval
    line = 0
    potential_songs = []
    for word in res.message.text.split /\W+/
      if songs.hasOwnProperty word
        potential_songs.push word
    if potential_songs.length is 0
      potential_songs = Object.keys songs
    song = res.random potential_songs
    res.send 'singing the ' + song + ' song!'
    interval = setInterval ->
      res.send songs[song][line]
      line++
      if line >= songs[song].length
        clearInterval interval
    , 2000

  robot.hear /stop/i, (res) ->
    clearInterval(interval)

