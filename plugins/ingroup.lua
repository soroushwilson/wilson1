do

-- Check Member
local function check_member_autorealm(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Realm',
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_join = 'no',
          antitag = 'no',
	  antilink = 'no',
	  lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes'
        }
      }
      save_data(_config.moderation.data, data)
      local realms = 'realms'
      if not data[tostring(realms)] then
        data[tostring(realms)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(realms)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'به ریلم جدید خوش آمدید !')
    end
  end
end
local function check_member_realm_add(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Realm',
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_join = 'no',
		  antitag = 'no',
		  antilink = 'no',
		  lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes'
        }
      }
      save_data(_config.moderation.data, data)
      local realms = 'realms'
      if not data[tostring(realms)] then
        data[tostring(realms)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(realms)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'ریلم اضافه شد!')
    end
  end
end
function check_member_group(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Group',
        moderators = {},
        set_owner = member_id ,
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_join = 'no',
		  antitag = 'no',
		  antilink = 'no',
		  lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes',
        }
      }
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'شما به عنوان صاحب گروه تعیین شدید.')
    end
  end
end
local function check_member_modadd(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Group',
        moderators = {},
        set_owner = member_id ,
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_join = 'no',
		  antitag = 'no',
		  antilink = 'no',
		  lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes',
        }
      }
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'گروه اضافه شد و شما صاحب گروه شدید. ')
    end
  end
end
local function automodadd(msg)
  local data = load_data(_config.moderation.data)
  if msg.action.type == 'chat_created' then
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_group,{receiver=receiver, data=data, msg = msg})
  end
end
local function autorealmadd(msg)
  local data = load_data(_config.moderation.data)
  if msg.action.type == 'chat_created' then
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_autorealm,{receiver=receiver, data=data, msg = msg})
  end
end
local function check_member_realmrem(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Realm configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local realms = 'realms'
      if not data[tostring(realms)] then
        data[tostring(realms)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(realms)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'ریلم حذف شد و ربات آن را به رسمیت نمیشناسد!')
    end
  end
end
local function check_member_modrem(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'گروه حذف شد و ربات آن را به رسمیت نمیشناسد')
    end
  end
end
--End Check Member
local function show_group_settingsmod(msg, data, target)
 	if not is_momod(msg) then
    	return "فقط مخصوص مدیران!"
  	end
  	local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
     	if data[tostring(msg.to.id)]['settings']['flood_msg_max'] then
        	NUM_MSG_MAX = tonumber(data[tostring(msg.to.id)]['settings']['flood_msg_max'])
        	print('custom'..NUM_MSG_MAX)
      	else 
        	NUM_MSG_MAX = 2
      	end
    end
    local bots_protection = "Yes"
    if data[tostring(msg.to.id)]['settings']['lock_bots'] then
    	bots_protection = data[tostring(msg.to.id)]['settings']['lock_bots']
   	end
    local lock_fwd = "no"
    if data[tostring(msg.to.id)]['settings']['lock_fwd'] then
    	 lock_fwd = data[tostring(msg.to.id)]['settings']['lock_fwd']
   	end
    local lock_media = "no"
    if data[tostring(msg.to.id)]['settings']['lock_media'] then
    	 lock_media = data[tostring(msg.to.id)]['settings']['lock_media']
   	end
    local lock_emoji = "no"
    if data[tostring(msg.to.id)]['settings']['lock_emoji'] then
    	 lock_emoji = data[tostring(msg.to.id)]['settings']['lock_emoji']
   	end
   local leave_ban = "no"
    if data[tostring(msg.to.id)]['settings']['leave_ban'] then
    	leave_ban = data[tostring(msg.to.id)]['settings']['leave_ban']
   	end
   	  local lock_eng = "no"
    if data[tostring(msg.to.id)]['settings']['lock_eng'] then
        lock_eng = data[tostring(msg.to.id)]['settings']['lock_eng']
        end
          local lock_badw = "no"
    if data[tostring(msg.to.id)]['settings']['lock_badw'] then
        lock_badw = data[tostring(msg.to.id)]['settings']['lock_badw']
        end
        local lock_sticker = "no"
    if data[tostring(msg.to.id)]['settings']['lock_sticker'] then
        lock_sticker = data[tostring(msg.to.id)]['settings']['lock_sticker']
        end
        local lock_chat = "no"
    if data[tostring(msg.to.id)]['settings']['lock_chat'] then
    	lock_chat = data[tostring(msg.to.id)]['settings']['lock_chat']
   	end
   	    local lock_video = "no"
    if data[tostring(msg.to.id)]['settings']['lock_video'] then
    	 lock_video = data[tostring(msg.to.id)]['settings']['lock_video']
   	end
   local lock_photos = "no"
    if data[tostring(msg.to.id)]['settings']['lock_photos'] then
    	lock_photos = data[tostring(msg.to.id)]['settings']['lock_photos']
   	end
   	  local lock_gifs = "no"
    if data[tostring(msg.to.id)]['settings']['lock_gifs'] then
        lock_gifs = data[tostring(msg.to.id)]['settings']['lock_gifs']
        end
          local lock_contact = "no"
    if data[tostring(msg.to.id)]['settings']['lock_contact'] then
        lock_contact = data[tostring(msg.to.id)]['settings']['lock_contact']
        end
        local lock_audio = "no"
    if data[tostring(msg.to.id)]['settings']['audio'] then
        lock_audio = data[tostring(msg.to.id)]['settings']['audio']
        end
        local lock_poker = "no"
    if data[tostring(msg.to.id)]['settings']['lock_poker'] then
    	lock_poker = data[tostring(msg.to.id)]['settings']['lock_poker']
   	end
        --[[local arabic_lock = "no"
    if data[tostring(msg.to.id)]['settings']['arabic_lock'] then
    	 arabic_lock = data[tostring(msg.to.id)]['settings']['arabic_lock']
   	end]]
      if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_arabic'] then
			data[tostring(target)]['settings']['lock_arabic'] = 'no'
		end
	end
   	 local groupmodel = "normal"
    if data[tostring(msg.to.id)]['settings']['groupmodel'] then
    	groupmodel = data[tostring(msg.to.id)]['settings']['groupmodel']
   	end
   	 local version = "Final"
    if data[tostring(msg.to.id)]['settings']['version'] then
    	version = data[tostring(msg.to.id)]['settings']['version']
   	end
   	 local welcome = "group"
    if data[tostring(msg.to.id)]['settings']['welcome'] then
    	welcome = data[tostring(msg.to.id)]['settings']['welcome']
   	end

  local settings = data[tostring(target)]['settings']
  local text = "⚙#Group Settings⚙ \n➖➖➖➖➖➖➖➖\n#Lock Group /Join : "..settings.lock_join.."\n#Lock Group /Tag : "..settings.antitag.."\n#Lock Group /Ads : "..settings.antilink.."\n#Lock Group /Name : "..settings.lock_name.."\n#Lock Group /Photo : "..settings.lock_photo.."\n#Lock Group /Member : "..settings.lock_member.."\n#Lock Group /English : "..lock_eng.."\n#Lock Group /Arabic : "..settings.lock_arabic.."\n#Lock Group /BadWords : "..lock_badw.."\n#Lock Group /Sticker : "..lock_sticker.."\n#Lock Group /Forward : "..lock_fwd.."\n#Lock Group /Media : "..lock_media.."\n#Lock Group /Emoji : "..lock_emoji.."\n#Lock Group /Chat : "..lock_chat.."\n#Lock Group /Video : "..lock_video.."\n#Lock Group /Gifs : "..lock_gifs.."\n#Lock Group /Contact : "..lock_contact.."\n#Lock Group /Photos : "..lock_photos.."\n#Lock Group /Audio : "..lock_audio.."\n#Lock Group /Poker : "..lock_poker.."\n#Lock Group /Leave : "..leave_ban.."\n#Flood /Sensitivity : "..NUM_MSG_MAX.."\n#Bot /Protection : "..bots_protection.."\n#Group /Model : "..groupmodel.."\n#Version : "..version.."\n➖➖➖➖➖➖➖➖\n🔘Open Source\n🔘soroush_team"--"\nPublic🚸: "..public
return text
end

local function set_descriptionmod(msg, data, target, about)
  if not is_momod(msg) then
    return "قفط مخصوص مدیران!"
  end
  local data_cat = 'description'
  data[tostring(target)][data_cat] = about
  save_data(_config.moderation.data, data)
  return 'توضیحات گروه تغییر کرد به:\n'..about
end
local function get_description(msg, data)
  local data_cat = 'description'
  if not data[tostring(msg.to.id)][data_cat] then
    return 'هیچ موضوعی برای گروه تعیین نشده.'
  end
  local about = data[tostring(msg.to.id)][data_cat]
  local about = string.gsub(msg.to.print_name, "_", " ")..':\n\n'..about
  return 'توضیحات: '..about
end
local function lock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return "این دستور را فقط مدیر و ادمین ها میتوانند استفاده کنند"
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'yes' then
    return 'قفل عربی از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل عربی فعال شد.'
  end
end

local function unlock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'no' then
    return 'قفل عربی از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل عربی غیر فعال شد'
  end
end
local function lock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'yes' then
    return 'محافظت دربرابر ورود ربات ها از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'محافظت دربرابر ورود ربات ها فعال شد.'
  end
end

local function unlock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'no' then
    return 'محافظت دربرابر ورود ربات ها از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'no'
    save_data(_config.moderation.data, data)
    return 'محافظت دربرابر ربات ها غیر فعال شد.'
  end
end
local function lock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_fwd_lock = data[tostring(target)]['settings']['lock_fwd']
  if group_fwd_lock == 'yes' then
    return 'قفل فروارد از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_fwd'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل فروارد فعال شد.'
  end
end

local function unlock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_fwd_lock = data[tostring(target)]['settings']['lock_fwd']
  if group_fwd_lock == 'no' then
    return 'قفل فروارد از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_fwd'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل فروارد غیر فعال شد.'
  end
end
local function lock_group_media(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_media_lock = data[tostring(target)]['settings']['lock_media']
  if group_media_lock == 'yes' then
    return 'قفل رسانه از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_media'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل رسانه فعال شد.'
  end
end

local function unlock_group_media(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_media_lock = data[tostring(target)]['settings']['lock_media']
  if group_media_lock == 'no' then
    return 'قفل رسانه از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_media'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل رسانه غیر فعال شد.'
  end
end
local function lock_group_emoji(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_emoji_lock = data[tostring(target)]['settings']['lock_emoji']
  if group_emoji_lock == 'yes' then
    return 'قفل ایموجی از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_emoji'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل ایموجی فعال شد.'
  end
end

local function unlock_group_emoji(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_emoji_lock = data[tostring(target)]['settings']['lock_emoji']
  if group_emoji_lock == 'no' then
    return 'قفل ایموجی از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_emoji'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل ایموجی غیر فعال شد.'
  end
end
local function lock_group_tag(msg, data, target)
if not is_momod(msg) then
return "فقط مخصوص مدیران!"
end
local group_tag_lock = data[tostring(target)]['settings']['antitag']
if group_tag_lock == 'yes' then
return 'قفل تگ از قبل فعال بود.'
else
data[tostring(target)]['settings']['antitag'] = 'yes'
save_data(_config.moderation.data, data)
return 'قفل تگ فعال شد.'
end
end
local function unlock_group_tag(msg, data, target)
if not is_momod(msg) then
return "قفط مخصوص مدیران!"
end
local group_tag_lock = data[tostring(target)]['settings']['antitag']
if group_tag_lock == 'no' then
return 'قفل تگ از قبل فعال نبود.'
else
data[tostring(target)]['settings']['antitag'] = 'no'
save_data(_config.moderation.data, data)
return 'قفل تگ غیر فعال شد.'
end
end
local function lock_group_video(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_video_lock = data[tostring(target)]['settings']['lock_video']
  if group_video_lock == 'yes' then
    return 'قفل فیلم از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_video'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل فیلم فعال شد.'
  end
end

local function unlock_group_video(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_video_lock = data[tostring(target)]['settings']['lock_video']
  if group_video_lock == 'no' then
    return 'قفل فیلم از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_video'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل فیلم غیر فعال شد.'
  end
end
local function lock_group_photos(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_photos_lock = data[tostring(target)]['settings']['lock_photos']
  if group_photos_lock == 'yes' then
    return 'قفل اشتراک گذاری عکس از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_photos'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل اشتراک گذاری عکس فعال شد.'
  end
end

local function unlock_group_photos(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_photos_lock = data[tostring(target)]['settings']['lock_photos']
  if group_photos_lock == 'no' then
    return 'قفل اشتراک گذاری عکس از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_photos'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل اشتراک گذاری عکس غیر فعال شد.'
  end
end
local function lock_group_contact(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_contact_lock = data[tostring(target)]['settings']['lock_contact']
  if group_contact_lock == 'yes' then
    return 'قفل اشتراک گذاری مخاطب از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_contact'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل اشتراک گذاری مخاطب فعال شد.'
  end
end

local function unlock_group_contact(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_contact_lock = data[tostring(target)]['settings']['lock_contact']
  if group_contact_lock == 'no' then
    return 'قفل اشتراک گذاری مخاطب از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_contact'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل اشتراک گذاری مخاطب غیر فعال شد.'
  end
end
local function lock_group_gifs(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_gifs_lock = data[tostring(target)]['settings']['lock_gifs']
  if group_gifs_lock == 'yes' then
    return 'قفل گیف از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_gifs'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل گیف فعال شد.'
  end
end

local function unlock_group_gifs(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_gifs_lock = data[tostring(target)]['settings']['lock_gifs']
  if group_gifs_lock == 'no' then
    return 'قفل گیف از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_gifs'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل گیف غیر فعال شد.'
  end
end
local function lock_group_audio(msg, data, target)
if not is_momod(msg) then
return "فقط مخصوص مدیران!"
end
local group_audio_lock = data[tostring(target)]['settings']['lock_audio']
if group_audio_lock == 'yes' then
return 'قفل ارسال صدا از قبل فعال بود.'
else
data[tostring(target)]['settings']['lock_audio'] = 'yes'
save_data(_config.moderation.data, data)
return 'قفل ارسال صدا فعال شد.'
end
end
local function unlock_group_audio(msg, data, target)
if not is_momod(msg) then
return "قفط مخصوص مدیران!"
end
local group_audio_lock = data[tostring(target)]['settings']['lock_audio']
if group_audio_lock == 'no' then
return 'قفل ارسال صدا از قبل فعال نبود.'
else
data[tostring(target)]['settings']['audio'] = 'no'
save_data(_config.moderation.data, data)
return 'قفل صدا غیر فعال شد.'
end
end
local function lock_group_poker(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_poker_lock = data[tostring(target)]['settings']['lock_poker']
  if group_poker_lock == 'yes' then
    return 'قفل پوکر از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_poker'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل پوکر فعال شد.'
  end
end

local function unlock_group_poker(msg, data, target)
  if not is_momod(msg) then
    return 'فقط مخصوص مدیران!'
  end
  local group_poker_lock = data[tostring(target)]['settings']['lock_poker']
  if group_poker_lock == 'no' then
    return 'قفل پوکر از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_poker'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل پوکر غیر فعال شد.'
  end
end
local function lock_group_join(msg, data, target)
if not is_momod(msg) then
return "فقط مخصوص مدیران!"
end
local group_join_lock = data[tostring(target)]['settings']['lock_join']
if group_join_lock == 'yes' then
return 'قفل ورود با لینک از قبل فعال بود.'
else
data[tostring(target)]['settings']['lock_join'] = 'yes'
save_data(_config.moderation.data, data)
return 'قفل ورود با لینک فعال شد.'
end
end
local function unlock_group_join(msg, data, target)
if not is_momod(msg) then
return "فقط مخصوص مدیران!"
end
local group_join_lock = data[tostring(target)]['settings']['lock_join']
if group_join_lock == 'no' then
return 'قفل ورود با لینک از قبل فعال نبود.'
else
data[tostring(target)]['settings']['lock_join'] = 'no'
save_data(_config.moderation.data, data)
return 'قفل ورود با لینک غیر فعال شد.'
end
end
local function lock_group_link(msg, data, target)
if not is_momod(msg) then
return "فقط مخصوص مدیران!"
end
local group_link_lock = data[tostring(target)]['settings']['antilink']
if group_link_lock == 'yes' then
return 'قفل تبلیغات از قبل فعال بود.'
else
data[tostring(target)]['settings']['antilink'] = 'yes'
save_data(_config.moderation.data, data)
return 'قفل تبلیغات فعال شد.'
end
end
local function unlock_group_link(msg, data, target)
if not is_momod(msg) then
return "فقط مخصوص مدیران!"
end
local group_link_lock = data[tostring(target)]['settings']['antilink']
if group_link_lock == 'no' then
return 'قفل تبلیغات از قبل فعال نبود.'
else
data[tostring(target)]['settings']['antilink'] = 'no'
save_data(_config.moderation.data, data)
return 'قفل تبلیغات غیر فعال شد.'
end
end
local function lock_group_namemod(msg, data, target)
  if not is_momod(msg) then
    return "قفط مخصوص مدیران!"
  end
  local group_name_set = data[tostring(target)]['settings']['set_name']
  local group_name_lock = data[tostring(target)]['settings']['lock_name']
  if group_name_lock == 'yes' then
    return 'اسم گروه از قبل قفل بود.'
  else
    data[tostring(target)]['settings']['lock_name'] = 'yes'
    save_data(_config.moderation.data, data)
    rename_chat('chat#id'..target, group_name_set, ok_cb, false)
    return 'اسم گروه قفل شد.'
  end
end
local function unlock_group_namemod(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_name_set = data[tostring(target)]['settings']['set_name']
  local group_name_lock = data[tostring(target)]['settings']['lock_name']
  if group_name_lock == 'no' then
    return 'اسم گروه از قبل قفل نبود.'
  else
    data[tostring(target)]['settings']['lock_name'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل اسم گروه غیر فعال شد.'
  end
end
local function lock_group_floodmod(msg, data, target)
  if not is_owner(msg) then
    return "مخصوص صاحب گروه"
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'yes' then
    return 'قفل حساسیت اسپم در گروه از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['flood'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل حساسیت اسپم در گروه فعال شد.'
  end
end

local function unlock_group_floodmod(msg, data, target)
  if not is_owner(msg) then
    return "فقط مخصوص صاحب گروه"
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'no' then
    return 'قفل حساسیت اسپم در گروه از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['flood'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل حساسیت اسپم در گروه غیر فعال شد.'
  end
end

local function lock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'yes' then
    return 'قفل ورود اعضا از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_member'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return 'قفل ورود اعضا فعال شد.'
end

local function unlock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'no' then
    return 'قفل ورود اعضا از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_member'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل ورود اعضا غیر فعال شد.'
  end
end


local function set_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return "For moderators only!"
  end
  local group_member_lock = data[tostring(target)]['settings']['public']
  if group_member_lock == 'yes' then
    return 'Group is already public'
  else
    data[tostring(target)]['settings']['public'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return 'Group is now: public'
end

local function unset_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return "For moderators only!"
  end
  local group_member_lock = data[tostring(target)]['settings']['public']
  if group_member_lock == 'no' then
    return 'Group is not public'
  else
    data[tostring(target)]['settings']['public'] = 'no'
    save_data(_config.moderation.data, data)
    return 'Group is now: not public'
  end
end

local function lock_group_leave(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local leave_ban = data[tostring(msg.to.id)]['settings']['leave_ban']
  if leave_ban == 'yes' then
    return 'قفل خروج=بن از قبل فعال بود.'
  else
    data[tostring(msg.to.id)]['settings']['leave_ban'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return 'قفل خروج=بن فعال شد و کسانی که لفت دهند خودکار بن خواهند شد.'
end

local function unlock_group_leave(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local leave_ban = data[tostring(msg.to.id)]['settings']['leave_ban']
  if leave_ban == 'no' then
    return 'قفل خروج=بن از قبل فعال نبود.'
  else
    data[tostring(msg.to.id)]['settings']['leave_ban'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل خروج=بن غیر فعال شد.'
  end
end
--[[local function lock_group_eng(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_eng_lock = data[tostring(target)]['settings']['lock_eng']
  if group_eng_lock == 'yes' then
    return 'قفل انگلیسی از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_eng'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل انگلیسی فعال شد.'
  end
end

local function unlock_group_eng(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_eng_lock = data[tostring(target)]['settings']['lock_eng']
  if group_eng_lock == 'no' then
    return 'قفل انگلیسی از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_eng'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل انگلیسی غیر فعال شد.'
  end
end]]
local function lock_group_eng(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_eng_lock = data[tostring(target)]['settings']['lock_eng']
  if group_eng_lock == 'yes' then
    return 'قفل انگلیسی از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_eng'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل انگلیسی فعال شد.'
  end
end

local function unlock_group_eng(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_eng_lock = data[tostring(target)]['settings']['lock_eng']
  if group_eng_lock == 'no' then
    return 'قفل انگلیسی از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_eng'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل انگلیسی غیر فعال شد.'
  end
end
--[[local function lock_group_badw(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_badw_lock = data[tostring(target)]['settings']['lock_badw']
  if group_badw_lock == 'yes' then
    return 'قفل فحش از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_badw'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل فحش فعال شد.'
  end
end]]

local function unlock_group_badw(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_badw_lock = data[tostring(target)]['settings']['lock_badw']
  if group_badw_lock == 'no' then
    return 'قفل فحش از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_badw'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل فحش غیر فعال شد.'
  end
end
local function lock_group_badw(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_badw_lock = data[tostring(target)]['settings']['lock_badw']
  if group_badw_lock == 'yes' then
    return 'قفل فحش از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_badw'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل فحش فعال شد.'
  end
end

local function unlock_group_badw(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_badw_lock = data[tostring(target)]['settings']['lock_badw']
  if group_badw_lock == 'no' then
    return 'قفل فحش از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_badw'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل فحش غیر فعال شد.'
  end
end
local function lock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'yes' then
    return 'قفل استیکر از قبل فعال بود.'
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل استیکر فعال شد.'
  end
end

local function unlock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'no' then
    return 'قفل استیکر از قبل فعال نبود.'
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل استیکر غیر فعال شد.'
  end
end

local function lock_group_chat(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران❗️"
  end
  local group_chat_lock = data[tostring(target)]['settings']['lock_chat']
  if group_chat_lock == 'yes' then
    return 'قفل چت از قبل فعال بود.' else
    data[tostring(target)]['settings']['lock_chat'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'قفل چت فعال شد.'  
    end
end

local function unlock_group_chat(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران❗️"
  end
  local group_chat_lock = data[tostring(target)]['settings']['lock_chat']
  if group_chat_lock == 'no' then
    return 'قفل چت از قبل فعال نبود.' else
    data[tostring(target)]['settings']['lock_chat'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل چت غیر فعال شد.'   end
end


local function unlock_group_photomod(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
  if group_photo_lock == 'no' then
    return 'عکس گروه از قبل قفل نبود.'
  else
    data[tostring(target)]['settings']['lock_photo'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل عکس گروه غیر فعال شد.'
  end
end

local function set_rulesmod(msg, data, target)
  if not is_momod(msg) then
    return "فقط مخصوص مدیران!"
  end
  local data_cat = 'rules'
  data[tostring(target)][data_cat] = rules
  save_data(_config.moderation.data, data)
  return 'قوانین تغییر کرد به:\n'..rules
end
local function modadd(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin(msg) then
    return "فقط مخصوص سودو و ادمین!"
  end
  local data = load_data(_config.moderation.data)
  if is_group(msg) then
    return 'گروه از قبل اضافه شده بود.'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_modadd,{receiver=receiver, data=data, msg = msg})
end
local function realmadd(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin(msg) then
    return "فقط مخصوص سودو و ادمین!"
  end
  local data = load_data(_config.moderation.data)
  if is_realm(msg) then
    return 'ریلم از قبل اضافه شده بود.'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_realm_add,{receiver=receiver, data=data, msg = msg}) 
end
-- Global functions
function modrem(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin(msg) then
    return "فقط مخصوص سودو و ادمین!"
  end
  local data = load_data(_config.moderation.data)
  if not is_group(msg) then
    return 'گروه هنوز به رسمیت شناخته نشده.'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_modrem,{receiver=receiver, data=data, msg = msg})
end

function realmrem(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin(msg) then
    return "فقط مخصوص سودو و ادمین"
  end
  local data = load_data(_config.moderation.data)
  if not is_realm(msg) then
    return 'ریلم هنوز به رسمیت شناخته نشده.'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_realmrem,{receiver=receiver, data=data, msg = msg})
end
local function get_rules(msg, data)
  local data_cat = 'rules'
  if not data[tostring(msg.to.id)][data_cat] then
    return 'هیچ قوانینی ثبت نشده.'
  end
  local rules = data[tostring(msg.to.id)][data_cat]
  local rules = 'قوانین گروه:\n_____________________________\n'..rules
  return rules
end

local function set_group_photo(msg, success, result)
  local data = load_data(_config.moderation.data)
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/photos/chat_photo_'..msg.to.id..'.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    chat_set_photo (receiver, file, ok_cb, true)
    data[tostring(msg.to.id)]['settings']['set_photo'] = file
    save_data(_config.moderation.data, data)
    data[tostring(msg.to.id)]['settings']['lock_photo'] = 'yes'
    save_data(_config.moderation.data, data)
    send_large_msg(receiver, 'عکس ذخیره شد!', ok_cb, true)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'اشتباهی رخ داده است دوباره امتحان کنید!', ok_cb, true)
  end
end

local function promote(receiver, member_username, member_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'chat#id', '')
  if not data[group] then
    return send_large_msg(receiver, 'گروه هنوز به رسمیت شناخته نشده.')
  end
  if data[group]['moderators'][tostring(member_id)] then
    return send_large_msg(receiver, member_username..' از قبل مدیر بود.')
  end
  data[group]['moderators'][tostring(member_id)] = member_username
  save_data(_config.moderation.data, data)
  return send_large_msg(receiver, member_username..' مدیر شد.')
end

local function promote_by_reply(extra, success, result)
    local msg = result
    local full_name = (msg.from.first_name or '')..' '..(msg.from.last_name or '')
    if msg.from.username then
      member_username = '@'.. msg.from.username
    else
      member_username = full_name
    end
    local member_id = msg.from.id
    if msg.to.type == 'chat' then
      return promote(get_receiver(msg), member_username, member_id)
    end  
end

local function demote(receiver, member_username, member_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'chat#id', '')
  if not data[group] then
    return send_large_msg(receiver, 'گروه هنوز به رسمیت شناخته نشده.')
  end
  if not data[group]['moderators'][tostring(member_id)] then
    return send_large_msg(receiver, member_username..' از قبل مدیر نبوده.')
  end
  data[group]['moderators'][tostring(member_id)] = nil
  save_data(_config.moderation.data, data)
  return send_large_msg(receiver, member_username..' از مدیریت برکنار شد.')
end

local function demote_by_reply(extra, success, result)
    local msg = result
    local full_name = (msg.from.first_name or '')..' '..(msg.from.last_name or '')
    if msg.from.username then
      member_username = '@'..msg.from.username
    else
      member_username = full_name
    end
    local member_id = msg.from.id
    if msg.to.type == 'chat' then
      return demote(get_receiver(msg), member_username, member_id)
    end  
end

local function setowner_by_reply(extra, success, result)
  local msg = result
  local receiver = get_receiver(msg)
  local data = load_data(_config.moderation.data)
  local name_log = msg.from.print_name:gsub("_", " ")
  data[tostring(msg.to.id)]['set_owner'] = tostring(msg.from.id)
      save_data(_config.moderation.data, data)
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] setted ["..msg.from.id.."] as owner")
      local text = msg.from.print_name:gsub("_", " ").."\n صاحب گروه شد.\nنام گروه : "..msg.to.title.."\nآیدی گروه : "..msg.to.id.."\nیوزر : @"..(msg.from.username or '').."\nآیدی : "..msg.from.id
      return send_large_msg(receiver, text)
end

local function promote_demote_res(extra, success, result)
--vardump(result)
--vardump(extra)
      local member_id = result.id
      local member_username = "@"..result.username
      local chat_id = extra.chat_id
      local mod_cmd = extra.mod_cmd
      local receiver = "chat#id"..chat_id
      if mod_cmd == 'promote' then
        return promote(receiver, member_username, member_id)
      elseif mod_cmd == 'demote' then
        return demote(receiver, member_username, member_id)
      end
end

local function modlist(msg)
  local data = load_data(_config.moderation.data)
  local groups = "groups"
  if not data[tostring(groups)][tostring(msg.to.id)] then
    return 'گروه هنوز به رسمیت شناخته نشده.'
  end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['moderators']) == nil then --fix way
    return 'هیچ مدیری برای گروه تعیین نشده.'
  end
  local i = 1
  local message = '\nلیست مدیران: \n_____________________________\n ' .. string.gsub(msg.to.print_name, '_', ' ') .. ':\n'
  for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
    message = message ..i..' - '..v..' [' ..k.. '] \n'
    i = i + 1
  end
  return message
end

local function callbackres(extra, success, result)
--vardump(result)
  local user = result.id
  local name = string.gsub(result.print_name, "_", " ")
  local chat = 'chat#id'..extra.chatid
  send_large_msg(chat, user..'\n'..name)
  return user
end


local function help()
  local help_text = tostring(_config.help_text)
  return help_text
end

local function cleanmember(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user(v.id, result.id)     
  end
end

local function killchat(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.id, result.id)     
  end
end

local function killrealm(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.id, result.id)     
  end
end

local function user_msgs(user_id, chat_id)
  local user_info
  local uhash = 'user:'..user_id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..user_id..':'..chat_id
  user_info = tonumber(redis:get(um_hash) or 0)
  return user_info
end

local function kick_zero(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local chat = "chat#id"..chat_id
    local ci_user
    local re_user
    for k,v in pairs(result.members) do
        local si = false
        ci_user = v.id
        local hash = 'chat:'..chat_id..':users'
        local users = redis:smembers(hash)
        for i = 1, #users do
            re_user = users[i]
            if tonumber(ci_user) == tonumber(re_user) then
                si = true
            end
        end
        if not si then
            if ci_user ~= our_id then
                if not is_momod2(ci_user, chat_id) then
                  chat_del_user(chat, 'user#id'..ci_user, ok_cb, true)
                end
            end
        end
    end
end

local function kick_inactive(chat_id, num, receiver)
    local hash = 'chat:'..chat_id..':users'
    local users = redis:smembers(hash)
    -- Get user info
    for i = 1, #users do
        local user_id = users[i]
        local user_info = user_msgs(user_id, chat_id)
        local nmsg = user_info
        if tonumber(nmsg) < tonumber(num) then
            if not is_momod2(user_id, chat_id) then
              chat_del_user('chat#id'..chat_id, 'user#id'..user_id, ok_cb, true)
            end
        end
    end
    return chat_info(receiver, kick_zero, {chat_id = chat_id})
end

local function run(msg, matches)
  local data = load_data(_config.moderation.data)
  local receiver = get_receiver(msg)
   local name_log = user_print_name(msg.from)
  local group = msg.to.id
  if msg.media then
    if msg.media.type == 'photo' and data[tostring(msg.to.id)]['settings']['set_photo'] == 'waiting' and is_chat_msg(msg) and is_momod(msg) then
      load_photo(msg.id, set_group_photo, msg)
    end
  end
  if matches[1]:lower() == 'add' and not matches[2] then
    if is_realm(msg) then
       return 'خطا: اینجا ریلم هست.'
    end
    chat_add_user('chat#id'..msg.to.id,'170324143',ok_cb,false)
    print("group "..msg.to.print_name.."("..msg.to.id..") added")
    return modadd(msg)
  end
   if matches[1]:lower() == 'add' and matches[2] == 'realm' then
    if is_group(msg) then
       return 'خطا: اینجا گروه هست.'
    end
    print("group "..msg.to.print_name.."("..msg.to.id..") added as a realm")
    return realmadd(msg)
  end
  if matches[1]:lower() == 'rem' and not matches[2] then
    print("group "..msg.to.print_name.."("..msg.to.id..") removed")
    return modrem(msg)
  end
  if matches[1]:lower() == 'rem' and matches[2] == 'realm' then
    print("group "..msg.to.print_name.."("..msg.to.id..") removed as a realm")
    return realmrem(msg)
  end
  if matches[1] == 'chat_created' and msg.from.id == 0 and group_type == "group" then
    return automodadd(msg)
  end
  if matches[1] == 'chat_created' and msg.from.id == 0 and group_type == "realm" then
    return autorealmadd(msg)
  end

  if msg.to.id and data[tostring(msg.to.id)] then
    local settings = data[tostring(msg.to.id)]['settings']
    if matches[1] == 'chat_add_user' then
      if not msg.service then
        return "Are you trying to troll me?"
      end
      local group_member_lock = settings.lock_member
      local user = 'user#id'..msg.action.user.id
      local chat = 'chat#id'..msg.to.id
      if group_member_lock == 'yes' and not is_owner2(msg.action.user.id, msg.to.id) then
        chat_del_user(chat, user, ok_cb, true)
      elseif group_member_lock == 'yes' and tonumber(msg.from.id) == tonumber(our_id) then
        return nil
      elseif group_member_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'chat_del_user' then
      if not msg.service then
         -- return "Are you trying to troll me?"
      end
      local user = 'user#id'..msg.action.user.id
      local chat = 'chat#id'..msg.to.id
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] deleted user  "..user)
    end
    if matches[1] == 'chat_delete_photo' then
      if not msg.service then
        return "Are you trying to troll me?"
      end
      local group_photo_lock = settings.lock_photo
      if group_photo_lock == 'yes' then
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        redis:incr(picturehash)
        ---
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        local picprotectionredis = redis:get(picturehash) 
        if picprotectionredis then 
          if tonumber(picprotectionredis) == 4 and not is_owner(msg) then 
            kick_user(msg.from.id, msg.to.id)
          end
          if tonumber(picprotectionredis) ==  8 and not is_owner(msg) then 
            ban_user(msg.from.id, msg.to.id)
            local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
            redis:set(picturehash, 0)
          end
        end
        
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] tried to deleted picture but failed  ")
        chat_set_photo(receiver, settings.set_photo, ok_cb, false)
      elseif group_photo_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'chat_change_photo' and msg.from.id ~= 0 then
      if not msg.service then
        return "Are you trying to troll me?"
      end
      local group_photo_lock = settings.lock_photo
      if group_photo_lock == 'yes' then
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        redis:incr(picturehash)
        ---
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        local picprotectionredis = redis:get(picturehash) 
        if picprotectionredis then 
          if tonumber(picprotectionredis) == 4 and not is_owner(msg) then 
            kick_user(msg.from.id, msg.to.id)
          end
          if tonumber(picprotectionredis) ==  8 and not is_owner(msg) then 
            ban_user(msg.from.id, msg.to.id)
          local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
          redis:set(picturehash, 0)
          end
        end
        
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] tried to change picture but failed  ")
        chat_set_photo(receiver, settings.set_photo, ok_cb, false)
      elseif group_photo_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'chat_rename' then
      if not msg.service then
        return "Are you trying to troll me?"
      end
      local group_name_set = settings.set_name
      local group_name_lock = settings.lock_name
      local to_rename = 'chat#id'..msg.to.id
      if group_name_lock == 'yes' then
        if group_name_set ~= tostring(msg.to.print_name) then
          local namehash = 'name:changed:'..msg.to.id..':'..msg.from.id
          redis:incr(namehash)
          local namehash = 'name:changed:'..msg.to.id..':'..msg.from.id
          local nameprotectionredis = redis:get(namehash) 
          if nameprotectionredis then 
            if tonumber(nameprotectionredis) == 4 and not is_owner(msg) then 
              kick_user(msg.from.id, msg.to.id)
            end
            if tonumber(nameprotectionredis) ==  8 and not is_owner(msg) then 
              ban_user(msg.from.id, msg.to.id)
              local namehash = 'name:changed:'..msg.to.id..':'..msg.from.id
              redis:set(namehash, 0)
            end
          end
          
          savelog(msg.to.id, name_log.." ["..msg.from.id.."] tried to change name but failed  ")
          rename_chat(to_rename, group_name_set, ok_cb, false)
        end
      elseif group_name_lock == 'no' then
        return nil
      end
    end
    if matches[1]:lower() == 'setname' or matches[1] == 'تغییر نام'  and is_momod(msg) then
      local new_name = string.gsub(matches[2], '_', ' ')
      data[tostring(msg.to.id)]['settings']['set_name'] = new_name
      save_data(_config.moderation.data, data)
      local group_name_set = data[tostring(msg.to.id)]['settings']['set_name']
      local to_rename = 'chat#id'..msg.to.id
      rename_chat(to_rename, group_name_set, ok_cb, false)
      
      savelog(msg.to.id, "Group { "..msg.to.print_name.." }  name changed to [ "..new_name.." ] by "..name_log.." ["..msg.from.id.."]")
    end
    if matches[1]:lower() == 'setphoto' and is_momod(msg) then
      data[tostring(msg.to.id)]['settings']['set_photo'] = 'waiting'
      save_data(_config.moderation.data, data)
      return 'لطفا عکس مورد نظر برای گروه را ارسال کنید.'
    end
     if matches[1]:lower() == 'تغییر عکس' and is_momod(msg) then
      data[tostring(msg.to.id)]['settings']['set_photo'] = 'waiting'
      save_data(_config.moderation.data, data)
      return 'لطفا عکس مورد نظر برای گروه را ارسال کنید.'
    end
    if matches[1]:lower() == 'promote' and not matches[2] then
      if not is_owner(msg) then
        return "فقط مخصوص صاحب گروه"
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, promote_by_reply, false)
      end
    end
    if matches[1]:lower() == 'promote' and matches[2] then
      if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "فقط مخصوص صاحب گروه"
      end
	local member = matches[2]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted @".. member)
	local cbres_extra = {
	chat_id = msg.to.id,
        mod_cmd = 'promote', 
	from_id = msg.from.id
	}
	local username = matches[2]
	local username = string.gsub(matches[2], '@', '')
	return res_user(username, promote_demote_res, cbres_extra)
    end
    if matches[1]:lower() == 'demote' and not matches[2] then
      if not is_owner(msg) then
        return "فقط مخصوص صاحب گروه."
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, demote_by_reply, false)
      end
    end
    if matches[1]:lower() == 'demote' and matches[2] then
      if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "فقط مخصوص صاحب گروه."
      end
      if string.gsub(matches[2], "@", "") == msg.from.username and not is_owner(msg) then
        return "شما نمیتوانید خودتان را از مدیریت برکنار کنید."
      end
	local member = matches[2]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted @".. member)
	local cbres_extra = {
	chat_id = msg.to.id,
        mod_cmd = 'demote', 
	from_id = msg.from.id
	}
	local username = matches[2]
	local username = string.gsub(matches[2], '@', '')
	return res_user(username, promote_demote_res, cbres_extra)
end
    if matches[1] == 'افزودن مدیر' and not matches[2] then
      if not is_owner(msg) then
        return "فقط مخصوص صاحب گروه."
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, promote_by_reply, false)
      end
    end
    if matches[1] == 'افزودن مدیر' and matches[2] then
      if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "فقط مخصوص صاحب گروه."
      end
	local member = matches[2]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted @".. member)
	local cbres_extra = {
	chat_id = msg.to.id,
        mod_cmd = 'افزودن مدیر', 
	from_id = msg.from.id
	}
	local username = matches[2]
	local username = string.gsub(matches[2], '@', '')
	return res_user(username, promote_demote_res, cbres_extra)
    end
    if matches[1] == 'حذف مدیر' and not matches[2] then
      if not is_owner(msg) then
        return "فقط مخصوص صاحب گروه."
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, demote_by_reply, false)
      end
    end
    if matches[1] == 'حذف مدیر' and matches[2] then
      if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "فقط مخصوص صاحب گروه."
      end
      if string.gsub(matches[2], "@", "") == msg.from.username and not is_owner(msg) then
        return "شما نمیتوانید خودتان را از مدیریت برکنار کنید."
      end
	local member = matches[2]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted @".. member)
	local cbres_extra = {
	chat_id = msg.to.id,
        mod_cmd = 'حذف مدیر', 
	from_id = msg.from.id
	}
	local username = matches[2]
	local username = string.gsub(matches[2], '@', '')
	return res_user(username, promote_demote_res, cbres_extra)
    end
    if matches[1]:lower() == 'modlist'or matches[1] == 'لیست مدیران' then 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group modlist")
      return modlist(msg)
    end
    if matches[1]:lower() == 'about' or matches[1] == 'توضیحات' then 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group description")
      return get_description(msg, data)
    end
    if matches[1]:lower() == 'rules'or matches[1] == 'قوانین' then 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group rules")
      return get_rules(msg, data)
    end
    if matches[1]:lower() == 'set' then
      if matches[2] == 'rules' then
        rules = matches[3]
        local target = msg.to.id
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group rules to ["..matches[3].."]")
        return set_rulesmod(msg, data, target)
      end
      if matches[2] == 'about'then 
        local data = load_data(_config.moderation.data)
        local target = msg.to.id
        local about = matches[3]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group description to ["..matches[3].."]")
        return set_descriptionmod(msg, data, target, about)
      end
end
 if matches[1] == 'ثبت' then
      if matches[2] == 'قوانین' then
        rules = matches[3]
        local target = msg.to.id
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group rules to ["..matches[3].."]")
        return set_rulesmod(msg, data, target)
      end
      if matches[2] == 'توضیحات'then 
        local data = load_data(_config.moderation.data)
        local target = msg.to.id
        local about = matches[3]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group description to ["..matches[3].."]")
        return set_descriptionmod(msg, data, target, about)
      end
    end
    if matches[1]:lower() == 'lock' then
      local target = msg.to.id
      if matches[2] == 'name' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked name ")
        return lock_group_namemod(msg, data, target)
      end
      if matches[2] == 'member' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked member ")
        return lock_group_membermod(msg, data, target)
        end
      if matches[2] == 'flood' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked flood ")
        return lock_group_floodmod(msg, data, target)
      end
      if matches[2] == 'arabic' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked arabic ")
        return lock_group_arabic(msg, data, target)
      end
      if matches[2] == 'bots' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked bots ")
        return lock_group_bots(msg, data, target)
      end
      if matches[2] == 'fwd' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked fwd ")
        return lock_group_fwd(msg, data, target)
      end
      if matches[2] == 'media' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked media ")
        return lock_group_media(msg, data, target)
      end
      if matches[2] == 'emoji' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked emoji ")
        return lock_group_emoji(msg, data, target)
      end
    if matches[2] == 'leave' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked leaving ")
       return lock_group_leave(msg, data, target)
     end
       if matches[2] == 'eng' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked eng ")
        return lock_group_eng(msg, data, target)
      end
        if matches[2] == 'badw' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked badw ")
        return lock_group_badw(msg, data, target)
      end
        if matches[2] == 'sticker' or matches[2] == 's' then
          savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked sticker ")
          return lock_group_sticker(msg, data, target)
      end
       if matches[2] == 'chat' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked chat")
        return lock_group_chat(msg, data, target)
      end
           if matches[2] == 'video' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked video ")
        return lock_group_video(msg, data, target)
        end
      if matches[2] == 'photos' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked photos ")
        return lock_group_photos(msg, data, target)
      end
      if matches[2] == 'gifs' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked gifs ")
        return lock_group_gifs(msg, data, target)
      end
      if matches[2] == 'contact' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked contact ")
        return lock_group_contact(msg, data, target)
      end
      if matches[2] == 'audio' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked audio ")
        return lock_group_audio(msg, data, target)
      end
      if matches[2] == 'poker' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked poker ")
        return lock_group_poker(msg, data, target)
      end
       
	 if matches[2] == 'ads' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked link ")
       return lock_group_link(msg, data, target)
     end
	 if matches[2] == 'tag' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked tag ")
       return lock_group_tag(msg, data, target)
     end
	 if matches[2] == 'join' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked joining link ")
       return lock_group_join(msg, data, target)
     end
   end
    if matches[1]:lower() == 'unlock' then 
      local target = msg.to.id
      if matches[2] == 'name' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked name ")
        return unlock_group_namemod(msg, data, target)
      end
      if matches[2] == 'member' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked member ")
        return unlock_group_membermod(msg, data, target)
      end
      if matches[2] == 'photo' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked photo ")
        return unlock_group_photomod(msg, data, target)
      end
      if matches[2] == 'flood' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked flood ")
        return unlock_group_floodmod(msg, data, target)
      end
      if matches[2] == 'arabic' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked arabic ")
        return unlock_group_arabic(msg, data, target)
      end
	  if matches[2] == 'ads' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked link ")
        return unlock_group_link(msg, data, target)
      end
      if matches[2] == 'bots' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked bots ")
        return unlock_group_bots(msg, data, target)
      end
	  if matches[2] == 'fwd' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked fwd ")
        return unlock_group_fwd(msg, data, target)
      end
	  if matches[2] == 'media' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked media ")
        return unlock_group_media(msg, data, target)
      end
	  if matches[2] == 'emoji' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked emoji ")
        return unlock_group_emoji(msg, data, target)
      end
	  if matches[2] == 'join' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked joining link ")
        return unlock_group_join(msg, data, target)
      end
   if matches[2] == 'leave' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked leaving ")
       return unlock_group_leave(msg, data, target)
     end
      if matches[2] == 'eng' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked eng ")
        return unlock_group_eng(msg, data, target)
      end
       if matches[2] == 'badw' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked badw ")
        return unlock_group_badw(msg, data, target)
      end
        if matches[2] == 'sticker' or matches[2] == 's' then
          savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked sticker ")
          return unlock_group_sticker(msg, data, target)
      end
       if matches[2] == 'chat' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked chat")
        return unlock_group_chat(msg, data, target)
      end
           if matches[2] == 'video' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked video ")
        return unlock_group_video(msg, data, target)
      end
      if matches[2] == 'photos' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked photos ")
        return unlock_group_photos(msg, data, target)
      end
      if matches[2] == 'gifs' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked gifs ")
        return unlock_group_gifs(msg, data, target)
      end
      if matches[2] == 'contact' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked contact ")
        return unlock_group_contact(msg, data, target)
      end
	  if matches[2] == 'audio' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked audio ")
        return unlock_group_audio(msg, data, target)
      end
      if matches[2] == 'poker' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked poker ")
        return unlock_group_poker(msg, data, target)
      end
     
	 if matches[2] == 'tag' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked tag ")
       return unlock_group_tag(msg, data, target)
     end
end
    if matches[1]:lower() == 'قفل' then
      local target = msg.to.id
      if matches[2] == 'نام' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked name ")
        return lock_group_namemod(msg, data, target)
      end
      if matches[2] == 'اعضا' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked member ")
        return lock_group_membermod(msg, data, target)
        end
      if matches[2] == 'حساسیت' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked flood ")
        return lock_group_floodmod(msg, data, target)
      end
      if matches[2] == 'عربی' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked arabic ")
        return lock_group_arabic(msg, data, target)
      end
      if matches[2] == 'ربات' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked bots ")
        return lock_group_bots(msg, data, target)
      end
      if matches[2] == 'فروارد' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked fwd ")
        return lock_group_fwd(msg, data, target)
      end
      if matches[2] == 'رسانه' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked media ")
        return lock_group_media(msg, data, target)
      end
      if matches[2] == 'ایموجی' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked emoji ")
        return lock_group_emoji(msg, data, target)
      end
    if matches[2] == 'لفت' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked leaving ")
       return lock_group_leave(msg, data, target)
     end
       if matches[2] == 'انگلیسی' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked eng ")
        return lock_group_eng(msg, data, target)
      end
        if matches[2] == 'فحش' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked badw ")
        return lock_group_badw(msg, data, target)
      end
        if matches[2] == 'استیکر' or matches[2] == 's' then
          savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked sticker ")
          return lock_group_sticker(msg, data, target)
      end
       if matches[2] == 'چت' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked chat")
        return lock_group_chat(msg, data, target)
      end
                if matches[2] == 'فیلم' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked video ")
        return lock_group_video(msg, data, target)
        end
      if matches[2] == 'عکس ها' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked photos ")
        return lock_group_photos(msg, data, target)
      end
      if matches[2] == 'گیف' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked gifs ")
        return lock_group_gifs(msg, data, target)
      end
      if matches[2] == 'مخاطب' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked contact ")
        return lock_group_contact(msg, data, target)
      end
      if matches[2] == 'صدا' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked audio ")
        return lock_group_audio(msg, data, target)
      end
      if matches[2] == 'پوکر' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked poker ")
        return lock_group_poker(msg, data, target)
      end
       
	 if matches[2] == 'تبلیغات' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked link ")
       return lock_group_link(msg, data, target)
     end
	 if matches[2] == 'تگ' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked tag ")
       return lock_group_tag(msg, data, target)
     end
	 if matches[2] == 'جوین' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked joining link ")
       return lock_group_join(msg, data, target)
     end
   end
    if matches[1]:lower() == 'باز کردن' then 
      local target = msg.to.id
      if matches[2] == 'نام' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked name ")
        return unlock_group_namemod(msg, data, target)
      end
      if matches[2] == 'اعضا' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked member ")
        return unlock_group_membermod(msg, data, target)
      end
      if matches[2] == 'عکس' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked photo ")
        return unlock_group_photomod(msg, data, target)
      end
      if matches[2] == 'حساسیت' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked flood ")
        return unlock_group_floodmod(msg, data, target)
      end
      if matches[2] == 'عربی' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked arabic ")
        return unlock_group_arabic(msg, data, target)
      end
	  if matches[2] == 'تبلیغات' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked link ")
        return unlock_group_link(msg, data, target)
      end
      if matches[2] == 'ربات' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked bots ")
        return unlock_group_bots(msg, data, target)
      end
      if matches[2] == 'فروارد' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked fwd ")
        return unlock_group_fwd(msg, data, target)
      end
      if matches[2] == 'رسانه' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked media ")
        return unlock_group_media(msg, data, target)
      end
      if matches[2] == 'ایموجی' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked emoji ")
        return unlock_group_emoji(msg, data, target)
      end
	  if matches[2] == 'جوین' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked joining link ")
        return unlock_group_join(msg, data, target)
      end
   if matches[2] == 'لفت' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked leaving ")
       return unlock_group_leave(msg, data, target)
     end
      if matches[2] == 'انگلیسی' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked eng ")
        return unlock_group_eng(msg, data, target)
      end
       if matches[2] == 'فحش' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked badw ")
        return unlock_group_badw(msg, data, target)
      end
        if matches[2] == 'استیکر' then
          savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked sticker ")
          return unlock_group_sticker(msg, data, target)
      end
       if matches[2] == 'چت' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked chat")
        return unlock_group_chat(msg, data, target)
      end
         if matches[2] == 'فیلم' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked video ")
        return unlock_group_video(msg, data, target)
      end
      if matches[2] == 'عکس ها' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked photos ")
        return unlock_group_photos(msg, data, target)
      end
      if matches[2] == 'گیف' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked gifs ")
        return unlock_group_gifs(msg, data, target)
      end
      if matches[2] == 'مخاطب' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked contact ")
        return unlock_group_contact(msg, data, target)
      end
	  if matches[2] == 'صدا' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked audio ")
        return unlock_group_audio(msg, data, target)
      end
      if matches[2] == 'پوکر' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked poker ")
        return unlock_group_poker(msg, data, target)
      end
     
	 if matches[2] == 'تگ' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked tag ")
       return unlock_group_tag(msg, data, target)
     end
end
 if matches[1]:lower() == 'setgroup' then
	  if not is_sudo(msg) then
       return "For sudoers only❗️"
      end
      if matches[2] == 'realm' then
        if groupmodel ~= 'realm' then
          data[tostring(msg.to.id)]['settings']['groupmodel'] = 'realm'
          save_data(_config.moderation.data, data)
        end
        return 'Group model has been changed to realm'
      end
      if matches[2] == 'support' then
        if groupmodel ~= 'support' then
          data[tostring(msg.to.id)]['settings']['groupmodel'] = 'support'
          save_data(_config.moderation.data, data)
        end
        return 'Group model has been changed to support'
      end
      if matches[2] == 'feedback' then
        if groupmodel ~= 'feedback' then
          data[tostring(msg.to.id)]['settings']['groupmodel'] = 'feedback'
          save_data(_config.moderation.data, data)
        end
        return 'Group model has been changed to feedback'
      end
      if matches[2] == 'vip' then
        if groupmodel ~= 'vip' then
          data[tostring(msg.to.id)]['settings']['groupmodel'] = 'vip'
          save_data(_config.moderation.data, data)
        end
        return 'Group model has been changed to vip'
      end
      if matches[2] == 'hell bot' then
        if groupmodel ~= 'hell bot' then
          data[tostring(msg.to.id)]['settings']['groupmodel'] = 'hell bot'
          save_data(_config.moderation.data, data)
        end
        return 'Group model has been changed to hell bot'
      end
      if matches[2] == 'normal' then
        if groupmodel == 'normal' then
          return 'Group model has been changed to normal'
        else
          data[tostring(msg.to.id)]['settings']['groupmodel'] = 'normal'
          save_data(_config.moderation.data, data)
          return 'Group model has been changed to normal'
        end
      end
end
  if matches[1] == 'setversion' then
	  if not is_sudo(msg) then
       return "For sudoers only❗️"
      end
      if matches[2] == '1.0' then
        if version ~= '1.0' then
          data[tostring(msg.to.id)]['settings']['version'] = '1.0'
          save_data(_config.moderation.data, data)
        end
        return 'group version has been changed to 1.0'
      end
      if matches[2] == '2.0' then
        if version ~= '2.0' then
          data[tostring(msg.to.id)]['settings']['version'] = '2.0'
          save_data(_config.moderation.data, data)
        end
        return 'group version has been changed to 2.0'
      end
      if matches[2] == '3.5' then
        if version == '3.5' then
          return 'group version has been changed to 3.5'
        else
          data[tostring(msg.to.id)]['settings']['version'] = '3.5'
          save_data(_config.moderation.data, data)
          return 'group version has been changed to 3.5'
        end
      end
    end
    if matches[1]:lower() == 'settings' or matches[1] == 'تنظیمات' then
      local target = msg.to.id
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group settings ")
      return show_group_settingsmod(msg, data, target)
    end	
  --[[if matches[1] == 'public' then
    local target = msg.to.id
    if matches[2] == 'yes' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: public")
      return set_public_membermod(msg, data, target)
    end
    if matches[2] == 'no' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: not public")
      return unset_public_membermod(msg, data, target)
    end
  end]]

    if matches[1]:lower() == 'newlink'or matches[1] == 'لینک جدید'  and not is_realm(msg) then
      if not is_momod(msg) then
        return "فقط مخصوص مدیران!"
      end
      local function callback (extra , success, result)
        local receiver = 'chat#'..msg.to.id
        if success == 0 then
           return send_large_msg(receiver, '*خطا: لینک جدید ساخته نشد* \nعلت: ربات سازنده گروه نیست.')
        end
        send_large_msg(receiver, "لینک جدید ساخته شد توسط : \nنام : "..msg.from.first_name.."\nیوزر : @"..(msg.from.username or '').."\nایدی : "..msg.from.id)
        data[tostring(msg.to.id)]['settings']['set_link'] = result
        save_data(_config.moderation.data, data)
      end
      local receiver = 'chat#'..msg.to.id
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] revoked group link ")
      return export_chat_link(receiver, callback, true)
    end
    if matches[1]:lower() == 'link' or matches[1] == 'لینک' then 
      if not is_momod(msg) then
        return "فقط مخصوص مدیران!"
      end
      local group_link = data[tostring(msg.to.id)]['settings']['set_link']
      if not group_link then 
        return "ابتدا با دستور newlink/ لینک جدید بسازید !"
      end
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group link ["..group_link.."]")
      return "درخواست لینک گروه توسط : \nنام : "..msg.from.first_name.."\nیوزر : @"..(msg.from.username or '').."\nآیدی : "..msg.from.id.."\nنام گروه : "..msg.to.title.."\nلینک گروه :\n"..group_link
    end
	if matches[1]:lower() == 'linkpv'or matches[1] == 'لینک خصوصی' then 
      if not is_momod(msg) then
        return "فقط مخصوص مدیران!"
      end
      local group_link = data[tostring(msg.to.id)]['settings']['set_link']
      if not group_link then 
        return "ابتدا با دستور newlink/ لینک جدید بسازید !"
      end
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group link ["..group_link.."]")
     send_large_msg('user#id'..msg.from.id, "Group link:\n"..group_link)
    end
    if matches[1]:lower() == 'setowner' and matches[2] then
      if not is_admin(msg) then
        return "فقط مخصوص سودو و ادمین!"
      end
      data[tostring(msg.to.id)]['set_owner'] = matches[2]
      save_data(_config.moderation.data, data)
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set ["..matches[2].."] as owner")
      local text = matches[2].." صاحب گروه شد."
      return text
    end
    if matches[1]:lower() == 'setowner' and not matches[2] then
      if not is_admin(msg) then
        return "فقط مخصوص سودو و ادمین!"
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, setowner_by_reply, false)
      end
    end
    if matches[1]:lower() == 'owner'or matches[1] == 'صاحب؟' then 
      local group_owner = data[tostring(msg.to.id)]['set_owner']
      if not group_owner then 
        return "صاحبی برای این گروه تعیین نشده،لطفا در گروه پشتیبانی ربات مطرح کنید."
      end
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] used /owner")
      return "صاحب گروه:\nآیدی: ["..group_owner..']'
    end
    if matches[1] == 'setgpowner' then
      local receiver = "chat#id"..matches[2]
      if not is_admin(msg) then
        return "فقط مخصوص سودو و ادمین!"
      end
      data[tostring(matches[2])]['set_owner'] = matches[3]
      save_data(_config.moderation.data, data)
      local text = matches[3].." added as owner"
      send_large_msg(receiver, text)
      return
    end
    if matches[1]:lower() == 'setflood'or matches[1] == 'حساسیت' then 
      if not is_momod(msg) then
        return "فقط مخصوص مدیران!"
      end
      if tonumber(matches[2]) < 2 or tonumber(matches[2]) >30 then
        return "لطفا یک عدد از بین [2-30] انتخاب کنید."
      end
      local flood_max = matches[2]
      data[tostring(msg.to.id)]['settings']['flood_msg_max'] = flood_max
      save_data(_config.moderation.data, data)
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set flood to ["..matches[2].."]")
      return 'مقدار حساسیت اسپم تغییر کرد به: '..matches[2]
    end
    if matches[1]:lower() == 'clean'or matches[1] == 'پاک کردن' then 
      if not is_owner(msg) then
        return "فقط مخصوص صاحب گروه!"
      end
      if matches[2] == 'member'or matches[2] == 'اعضا'  then
        if not is_sudo(msg) then
          return "فقط مخصوص سودو!"
        end
        local receiver = get_receiver(msg)
        chat_info(receiver, cleanmember, {receiver=receiver})
      end
      if matches[2] == 'modlist' then
        if next(data[tostring(msg.to.id)]['moderators']) == nil then --fix way
          return 'هیچ مدیری برای گروه تعیین نشده.'
        end
        local message = '\nلیست مدیران: ' .. string.gsub(msg.to.print_name, '_', ' ') .. ':\n'
        for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
          data[tostring(msg.to.id)]['moderators'][tostring(k)] = nil
          save_data(_config.moderation.data, data)
        end
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned modlist")
send_large_msg(get_receiver(msg), "لیست مدیران پاک شد.")
      end
      if matches[2] == 'rules' or matches[2] == 'قوانین' then 
        local data_cat = 'rules'
        data[tostring(msg.to.id)][data_cat] = nil
        save_data(_config.moderation.data, data)
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned rules")
send_large_msg(get_receiver(msg), "قوانین پاک شد.")
      end
      if matches[2] == 'about'or matches[2] == 'توضیحات' then 
        local data_cat = 'description'
        data[tostring(msg.to.id)][data_cat] = nil
        save_data(_config.moderation.data, data)
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned about")
send_large_msg(get_receiver(msg), "توضیحات پاک شد.")
      end     
if matches[2] == 'banlist' or matches[2] == 'لیست بن' then 
local chat_id = msg.to.id
local hash = 'banned:'..chat_id
        local data_cat = 'banlist'
        data[tostring(msg.to.id)][data_cat] = nil
        save_data(_config.moderation.data, data)
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned banlist")
send_large_msg(get_receiver(msg), "لیست بن پاک شد.")
redis:del(hash)
end
end
    if matches[1] == 'kill' and matches[2] == 'chat' then
      if not is_admin(msg) then
          return nil
      end
      if not is_realm(msg) then
          local receiver = get_receiver(msg)
          return modrem(msg),
          print("Closing Group..."),
          chat_info(receiver, killchat, {receiver=receiver})
      else
          return 'این یک ریلم هست!'
      end
   end
    if matches[1] == 'kill' and matches[2] == 'realm' then
     if not is_admin(msg) then
         return nil
     end
     if not is_group(msg) then
        local receiver = get_receiver(msg)
        return realmrem(msg),
        print("Closing Realm..."),
        chat_info(receiver, killrealm, {receiver=receiver})
     else
        return 'این یک گروه هست!'
     end
   end
    if matches[1] == 'help' then
      if not is_momod(msg) or is_realm(msg) then
        return
      end
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /help")
      return help()
    end
    if matches[1]:lower() == 'res' and is_momod(msg) then 
      local cbres_extra = {
        chatid = msg.to.id
      }
      local username = matches[2]
      local username = username:gsub("@","")
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /res "..username)
      return res_user(username,  callbackres, cbres_extra)
    end
    if matches[1] == 'kickinactive' then
      --send_large_msg('chat#id'..msg.to.id, 'I\'m in matches[1]')
	    if not is_momod(msg) then
	      return 'فقط مخصوص مدیران'
	    end
	    local num = 1
	    if matches[2] then
	        num = matches[2]
	    end
	    local chat_id = msg.to.id
	    local receiver = get_receiver(msg)
      return kick_inactive(chat_id, num, receiver)
    end
  end 
end

return {
  patterns = {
  "^(قوانین)$",
  "^(توضیحات)$",
  "^(حذف مدیر) (.*)$",
  "^(حذف مدیر)$",
  "^(افزودن مدیر) (.*)$",
  "^(افزودن مدیر)$",
  "^(قوانین)$",
  "^(توضیحات)$",
  "^(تغییر نام) (.*)$",
  "^(تغییر عکس)$",
  "^(پاک کردن) (.*)$",
  "^(ثبت) ([^%s]+) (.*)$",
  "^(قفل) (.*)$",
  "^(باز کردن) (.*)$",
  "^(صاحب؟)$",
  "^(قوانین) (.*)$",
  "^(حساسیت) (%d+)$",
  "^(لیست مدیران)$",
  "^(لینک جدید)$",
"^(لینک خصوصی)$",
  "^(لینک)$",
  "^[#!/](add)$",
  "^[#!/](add) (realm)$",
  "^[#!/](rem)$",
  "^[#!/](rem) (realm)$",
  "^[#!/](rules)$",
  "^[#!/](about)$",
  "^[#!/](setname) (.*)$",
  "^[#!/](setphoto)$",
  "^[#!/](promote) (.*)$",
  "^[#!/](promote)$",
  --"^[!/](help)$",
  "^[#!/](clean) (.*)$",
  "^[#!/](kill) (chat)$",
  "^[#!/](kill) (realm)$",
  "^[#/](demote) (.*)$",
  "^[#!/](demote)$",
  "^[#!/](set) ([^%s]+) (.*)$",
  "^[#!/](lock) (.*)$",
  "^[#!/](setowner) (%d+)$",
  "^[#!/](setowner)",
  "^[#!/](owner)$",
  "^[#!/](setgroup) (.*)$",
  "^[#!/](res) (.*)$",
  "^[#!/](setgpowner) (%d+) (%d+)$",-- (group id) (owner id)
  "^[#!/](unlock) (.*)$",
  "^[#!/](setflood) (%d+)$",
  "^[#!/](settings)$",
  "^[#!/](public) (.*)$",
  "^[#!/](modlist)$",
  "^[#!/](newlink)$",
  "^[#!/](link)$",
  "^[#!/](setlink)$",
  "^[#!/](linkpv)$",
  "^[#!/](kickinactive)$",
  "^[#!/](kickinactive) (%d+)$",
  "^([Aa]dd)$",
  "^(تنظیمات)$",
  "^([Rr]em)$",
  "^([Rr]ules)$",
  "^({Aa]bout)$",
  "^([Ss]etname) (.*)$",
  "^([Ss]etphoto)$",
  "^([Pp]romote) (.*)$",
  "^([Pp]romote)$",
  --"^([Hh]elp)$",
  "^([Cc]lean) (.*)$",
  "^([Dd]emote) (.*)$",
  "^([Dd]emote)$",
  "^([Ss]et) ([^%s]+) (.*)$",
  "^([Ll]ock) (.*)$",
  "^([Ss]etowner) (%d+)$",
  "^([Ss]etowner)$",
  "^([Oo]wner)$",
  "^([Ss]etgroup) (.*)$",
  "^([Rr]es) (.*)$",
  "^([Ss]etgpowner) (%d+) (%d+)$",-- (group id) (owner id)
  "^([Uu]nlock) (.*)$",
  "^([Ss]etflood) (%d+)$",
  "^([Ss]ettings)$",
  "^([Mm]odlist)$",
  "^([Nn]ewlink)$",
  "^([Ll]ink)$",
  "%[(photo)%]",
  "^!!tgservice (.+)$",
  },
  run = run
}
end

