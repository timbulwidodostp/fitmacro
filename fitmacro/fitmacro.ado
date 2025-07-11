*! version 1.1, 25Oct2002, John_Hendrickx@yahoo.com
/*
Direct comments to: John Hendrickx <John_Hendrickx@yahoo.com>
*/

program define fitmacro
  version 7
  if "`e(cmd)'" ~= "glm" & "`e(varfunct)'" ~= "Poisson" {
    display "For use only with the poisson family of glm models"
    exit
  }

  * assuming the dependent variable consists of counts, calculate their sum
  tempvar sumfreq
  gen `sumfreq'=sum(`e(depvar)')
  local ncases=`sumfreq'[_N]

  local prob=chiprob(e(df),e(deviance))
  local bic=e(deviance)-e(df)*ln(`ncases')
  local aic=e(deviance)-2*e(df)
  local cn01=1 + invchi2(e(df),.01)/(e(deviance)/(`ncases'-1))
  local cn05=1 + invchi2(e(df),.05)/(e(deviance)/(`ncases'-1))
  local cn10=1 + invchi2(e(df),.10)/(e(deviance)/(`ncases'-1))

  display _dup(79) "-"
  display "deviance"                   _col(68) %12.3f e(deviance)
  display "df"                         _col(68) %12.0f e(df)
  display "prob"                       _col(68) %12.3f `prob'
  display "bic"                        _col(68) %12.3f `bic'
  display "aic"                        _col(68) %12.3f `aic'
  display "Critical N at .01"          _col(68) %12.0f `cn01'
  display "Critical N at .05"          _col(68) %12.0f `cn05'
  display "Critical N at .10"          _col(68) %12.0f `cn10'
  display "Number of parameters"       _col(68) %12.0f e(df_m)
  display "Number of cases"            _col(68) %12.0f `ncases'
  display _dup(79) "-"
end
