hl.window_rule({
  name = "transparent-code",
  match = {
    class = "code-oss"
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