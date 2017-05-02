undef("cnv_kelvin2celsius")
function cnv_kelvin2celsius(kelvin:numeric)
; Convert kelvin to celsius
; Args:
;   kelvin (numeric) : Temperature in kelvin
; Returns:
;   celsius (numeric) : Temperature in celsius
local celsius
begin
    celsius = kelvin - 273.15
    copy_VarMeta(kelvin, celsius)
    celsius@units = "degrees_c"
    return celsius
end
