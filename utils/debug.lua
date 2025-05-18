function ApplyDebugResolution()
  if not Telebas.IS_DEBUG then return end

  Log("ApplyDebugResolution")
  mp.set_property("autofit", "1280x720")
end
