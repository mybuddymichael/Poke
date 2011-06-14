module Color
  Black       = Gosu::Color::BLACK
  White       = Gosu::Color::WHITE
  Trans_black = Gosu::Color.argb(0xd5000000)
end

module ZOrder
  Background, Grid, Map, Player, Pause_background, Pause_button = *0..5
end

module Media
  Font = 'media/poke.dfont'
end
