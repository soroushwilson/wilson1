do

function run(msg, matches)
if is_sudo(msg) then
send_contact(get_receiver(msg), "+639380184946", "", "♛ร๑я๑บรн พïℓร๑ท♛", ok_cb, false)
end
end

return {
patterns = {
"^[/!]([Ss]hare)$",
"^([Ss]hare)$"

},
run = run
}

end
--By @SoLiD021
