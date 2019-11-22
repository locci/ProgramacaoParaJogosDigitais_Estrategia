
return function (ruleset)

  local r = ruleset.record

  function ruleset.define:precedes(e1, e2)
    function self.when()
      return r:is(e1, 'rule') and r:is(e2, 'rule')
    end
    function self.apply()
      return e1.id > e2.id
    end
  end

  function ruleset.define:get_name(e)
    function self.when()
      return true
    end
    function self.apply()
      return tostring(e)
    end
  end

end

