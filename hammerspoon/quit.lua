-- Module: quit
--
-- Re-binds Cmd+Q to quit frontmost application after two presses to prevent
-- accidental closing.
--
-- Source: https://github.com/raulchen/dotfiles.

-- modal is the quitting modal. It holds the inner-binding to Cmd-Q which wll
-- actually invoke the quit.
local modal = hs.hotkey.modal.new('cmd', 'q')

-- modal:entered uses a timer to exit the modal one second after entering.
function modal:entered()
  hs.timer.doAfter(1, function() modal:exit() end)
end

-- quit selects the frontmost application and selects the first menu item
-- matching "Quit", the exits the modal.
local function quit()
  local app = hs.application.frontmostApplication()
  if app:title() == "Messages" then;
    app:selectMenuItem("^Close Window.*$")
  else;
    app:selectMenuItem("^Quit.*$")
  end

  modal:exit()
end

-- inner-binding for quitting an application
modal:bind('cmd', 'q', quit)
-- inner-binding for leaving the modal
modal:bind('', 'escape', function() modal:exit() end)
