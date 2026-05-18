hl.window_rule({
  name = "transparent-code",
  match = {
    class = "code-oss"
  },
  opacity = 0.9,
  
})
hl.window_rule({
  name = "transparent-discord",
  match = {
    class = "discord"
  },
  opacity = 0.9,
  
})
hl.window_rule({
  name = "transparent-whatsapp",
  match = {
    class = "brave-web.whatsapp.com__-Default"
  },
  opacity = 0.9,
  
})
hl.window_rule({
  name = "fullscreen-bypass-idle",
  match = {
    class = "brave-www.youtube.com__-Default"
  },
  idle_inhibit = "fullscreen"
  
})