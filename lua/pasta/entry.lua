local Entry = {}

function Entry.is_same(entry1, entry2)
  if type(entry1) ~= type(entry2) then
    return false
  end
  if entry1.regtype ~= entry2.regtype then
    return false
  end
  if #entry1.regcontents ~= #entry2.regcontents then
    return false
  end
  for i = 1, #entry1.regcontents do
    if entry1.regcontents[i] ~= entry2.regcontents[i] then
      return false
    end
  end
  return true
end

function Entry.clone(entry)
  local new_entry = {}
  new_entry.regtype = entry.regtype
  new_entry.regcontents = {}
  for i = 1, #entry.regcontents do
    new_entry.regcontents[i] = entry.regcontents[i]
  end
  return new_entry
end

return Entry
