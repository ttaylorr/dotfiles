local modal = hs.hotkey.modal.new('cmd alt', 'delete')

function modal:entered()
  local app = hs.application.frontmostApplication()
  local title = app:title()

  if title == "Messages" then;
    hs.timer.doAfter(1, function() modal:exit() end)
  else;
    modal:exit()
  end
end

local function delete()
  hs.eventtap.keyStroke({'cmd', 'alt'}, 'delete');
end


modal:bind('cmd alt', 'delete', delete)
modal:bind('', 'escape', function() modal:exit() end)
