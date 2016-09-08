do

local function run(msg, matches)


local text = matches[1]

  local b = 1

  while b ~= 0 do
    textc = text:trim()
    text,b = text:gsub(' ','.')
    
    
  if msg.to.type == 'chat' then 
      return nil
      else
  local receiver = get_receiver(msg)
  local about = 'سلام دوست عزیز❤\n برای دریافت گروه به ایدی @xX_Xx_Zendegi_bizaram_azat_Xx_xX پیام بدید'
      return about
end
end
  end
return {
  description = "Return Msg",
  usage = {
    "(.*)"
  },
  patterns = {
    "^(.*)$"
  },
  run = run
}

end
