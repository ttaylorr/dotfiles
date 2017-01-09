local modal = hs.hotkey.modal.new()

prefix.bind('', 'm', function()
  if modal.enabled then
    modal:exit()
  else
    modal:enter()
  end
end)

modal:bind('', 'escape', function() modal:exit() end)
modal:bind('', 'space', function() modal:exit() end)

local function mouseMove(dx, dy)
  local p = hs.mouse.getAbsolutePosition()
  p['x'] = p['x'] + dx
  p['y'] = p['y'] + dy

  hs.mouse.setAbsolutePosition(p)
end

local function mouseScroll(dx, dy)
  local offset = {dx, -dy}
  hs.eventtap.event.newScrollEvent(offset, {}):post()
end

local DELTA = 20
local SLOW_DELTA = 5
local SCROLL_DELTA = 3

local DX = {-1, 0, 0, 1}
local DY = {0, 1, -1, 0}
local KEYS = {'h', 'j', 'k', 'l'}

for i = 1, 4 do
  local moveFn = hs.fnutils.partial(mouseMove, DX[i] * DELTA, DY[i] * DELTA)
  local slowMoveFn = hs.fnutils.partial(mouseMove, DX[i] * SLOW_DELTA, DY[i] * SLOW_DELTA)
  local scrollFn = hs.fnutils.partial(mouseScroll, DX[i] * SCROLL_DELTA, DY[i] * SCROLL_DELTA)

  modal:bind('', KEYS[i], moveFn, nil, moveFn)
  modal:bind('cmd', KEYS[i], slowMoveFn, nil, slowMoveFn)
  modal:bind('shift', KEYS[i], scrollFn, nil, scrollFn)
end

local function click(button)
  local p = hs.mouse.getAbsolutePosition()

  if button == 0 then
    hs.eventtap.leftClick(p)
  elseif button == 1 then
    hs.eventtap.rightClick(p)
  else
    hs.eventtap.middleClick(p)
  end
end

modal:bind('', 'u', hs.fnutils.partial(click, 0), nil, nil)
modal:bind('', 'i', hs.fnutils.partial(click, 1), nil, nil)
modal:bind('', 'o', hs.fnutils.partial(click, 2), nil, nil)
