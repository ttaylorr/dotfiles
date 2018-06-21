prefix.bind('', 'g', function()
  local contents = hs.pasteboard.getContents()
  contents = string.gsub(contents, "^https://github.com/", "")
  contents = string.gsub(contents, "#.*$", "")
  contents = string.gsub(contents, "/issues/", "#")
  contents = string.gsub(contents, "/pull/", "#")

  hs.pasteboard.setContents(contents)
end)
