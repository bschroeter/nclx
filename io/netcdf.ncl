; Functions for working with NetCDF files

undef("nc_read")
function nc_read(filepath:string)
; Alias to addfile or addfiles (works for both)
; Args:
;   filepath (string) : Full filepath (or array of filepaths) to load
; Returns:
;   file (file) : Opened file(s)
begin
    if (dimsizes(dimsizes(filepath)).eq.1) then
        return addfile(filepath, "r")
    else
        return addfiles(filepath, "r")
    end if
end

undef("nc_write")
procedure nc_write(filepath:string, data)
; Write a simple netcdf of the variable of data (requires attributes, see doc)
; Args:
;   filepath (string) : Full path to the file
;   data (mixed) : Data (with atttributes) to write
local dim_names, dim_sizes, dim_unlimited, nc, nc_atts, data_atts, var_atts, data_tmp, variable
begin

    ; Create a shallow copy of the data to manipulate
    data_tmp = new(dimsizes(data), float)
    copy_VarMeta(data, data_tmp)

    ; Get the variable dimensions
    dim_names = getvardims(data)
    dim_sizes = dimsizes(data)
    dim_unlimited = new(dimsizes(dim_sizes), logical)
    dim_unlimited(:) = False
    variable = data@nc_variable

    ; Open the file for writing
    nc = addfile(filepath,"c")

    ; Enter define mode
    setfileoption(nc, "DefineMode", True)

    ; Copy attributes from the data to the file (global)
    nc_atts = True
    data_atts = getvaratts(data)
    do i = 0, dimsizes(data_atts) - 1

        ; Skip if it doesn't include the nc_ prefix
        if (ismissing(str_match(data_atts(i), "nc_"))) then
            continue
        end if

        ; Get the generic name of the attribute
        att_name = str_sub_str(data_atts(i), "nc_", "")

        ; Skip fill value
        if (att_name.eq."_FillValue") then
            continue
        end if

        ; Assign it
        nc_atts@$att_name$ = data@$data_atts(i)$

        ; Remove it from data_tmp object (used later)
        delete(data_tmp@$data_atts(i)$)

    end do

    ; Assign the global attributes
    fileattdef(nc, nc_atts)

    ; Create the dimensions
    filedimdef(nc, dim_names, dim_sizes, dim_unlimited)

    ; Create the coordinate variables
    do i = 0, dimsizes(dim_sizes) - 1
        filevardef(nc, dim_names(i), typeof(data&$dim_names(i)$), dim_names(i))
    end do

    ; Create the data variable, fill attributes with the shallow (manipulated) clone data_tmp
    filevardef(nc, variable, typeof(data), dim_names)
    filevarattdef(nc, variable, data_tmp)

    ; Exit define mode
    setfileoption(nc, "DefineMode", False)

    ; Write the coordindate data
    do i = 0, dimsizes(dim_sizes) - 1
        nc->$dim_names(i)$ = (/data&$dim_names(i)$/)
    end do

    ; Write the actual data
    nc->$variable$ = (/data/)

end
