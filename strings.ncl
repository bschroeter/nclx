; Functions for dealing with strings

undef("str_zfill")
function str_zfill(val, dir:string, len:integer)
; Zero pads an integer up to the desired length
; Args:
;   val (mixed) : Value to pad
;   dir (string) : Direction, one of "l" or "r"
;   len (int) : Total length of desired string
; Returns:
;   val_padded (string) : Zero-padded version of val
local val, dir, len, tmp, tmp2
begin

    if (dir.eq."l") then
        return sprinti("%0." + len + "i", val)
    else
        return tostring(toint(val*10^(len-2)))
    end if

end
