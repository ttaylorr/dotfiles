local mappings = {
  { 'b', 'Google Chrome' },
  { 'c', 'Hackable Slack Client' },
  { 'f', 'Fantastical 2' },
  { 's', 'Spotify' },
  { 't', 'Terminal' },
}

for i, mapping in ipairs(mappings) do
  prefix.bind('', mapping[1], function()
    hs.application.launchOrFocus(mapping[2])
  end)
end
