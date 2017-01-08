hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()

hs.hotkey.bind({'ctrl'}, '`', function()
  hs.reload()
end)

require('quit')
