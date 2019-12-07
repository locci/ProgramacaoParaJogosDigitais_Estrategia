--alexandre
--11/29/2019

local BUILDWAVE = {}

function BUILDWAVE.build_wave(wave)

      local tab
      local aux = {}
      for _, j in pairs(wave) do
        tab = j
        for _, w in pairs(tab) do
            table.insert(aux, w)
        end
      end
      return aux

end

return BUILDWAVE
