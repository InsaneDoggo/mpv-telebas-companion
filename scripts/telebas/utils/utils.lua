function Log(message)
  mp.msg.info(message)
end

function PrintTable(t, indent)
  indent = indent or ""
  for k, v in pairs(t) do
    if type(v) == "table" then
      print(indent .. tostring(k) .. ":")
      PrintTable(v, indent .. "  ")
    else
      print(indent .. tostring(k) .. ": " .. tostring(v))
    end
  end
end
