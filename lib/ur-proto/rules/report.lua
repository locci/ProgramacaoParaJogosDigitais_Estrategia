
return function (ruleset)

  local r = ruleset.record

  r:new_property('report', { subject = 'invalid', about = 'unknown',
                             contents = {} })

  function ruleset.define:get_subject(e)
    function self.when()
      return true
    end
    function self.apply()
      return r:get(e, 'report', 'subject')
    end
  end

  function ruleset.define:get_contents(e)
    function self.when()
      return true
    end
    function self.apply()
      return r:get(e, 'report', 'contents')
    end
  end

  function ruleset.define:report(subject, about, contents)
    function self.when()
      return true
    end
    function self.apply()
      local e = ruleset:new_entity()
      r:set(e, 'report', { subject = subject, about = about,
                           contents = contents or {} })
    end
  end

  function ruleset.define:clear_reports()
    function self.when()
      return true
    end
    function self.apply()
      for _, e in ipairs(r:all('report')) do
        r:clear_all(e)
      end
    end
  end

  function ruleset.define:get_reports_about(about)
    function self.when()
      return true
    end
    function self.apply()
      return r:where('report', { about = about })
    end
  end

end

