local helper ={}

function helper.do_when( a , b, fn_call)
  if a==b then
    fn_call()
  end
end
return helper
