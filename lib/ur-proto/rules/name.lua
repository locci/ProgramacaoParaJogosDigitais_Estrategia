
return function (ruleset)

  local r = ruleset.record

  r:new_property('named', { name = "Unknown" })

  function ruleset.define:get_name(id)
    function self.when()
      return r:is(id, 'named')
    end
    function self.apply()
      return r:get(id, 'named', 'name')
    end
  end

end

