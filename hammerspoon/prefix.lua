local module = {}
local modal = hs.hotkey.modal.new('ctrl alt', 'space')

function modal:entered()
  modal.alert = hs.alert.show('Prefix Mode', 9999)
  modal.timer = hs.timer.doAfter(5, function()
    modal:exit()
  end)
end

function modal:exited()
  if modal.alert then; hs.alert.closeSpecific(modal.alert); end
  if modal.timer then; modal.timer:stop(); end
end

function module.exit()
  modal:exit()
end

function module.bind(mod, key, fn)
  modal:bind(mod, key, nil, function()
    fn();
    module.exit();
  end)
end

module.bind('', 'escape', function() end)

return module
