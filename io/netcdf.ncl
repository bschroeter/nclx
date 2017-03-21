; Functions for working with NetCDF files

undef("nc_read")
function nc_read(filepath:string)
; Alias to addfile or addfiles (works for both)
; Args:
;   filepath (string) : Full filepath (or array of filepaths) to load
; Returns:
;   file (file) : Opened file(s)
begin
    if (dimsizes(filepath).gt.1) then
        return addfile(filepath, "r")
    else
        return addfiles(filepath, "r")
    end if
end
