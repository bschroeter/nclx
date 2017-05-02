; Functions for working with the OS

undef("os_path_join")
function os_path_join(segments)
; Joins segments (of varying type) into a path
; Args:
;   segments (iterable) : List (or 1D array) of items
; Returns:
;   joined (string) : String of joined path
local _segments, i
begin

    ; 1D array of numerical things
    if (isnumeric(segments)) then
        return str_join(tostring(segments), "/")

    ; 1D array of strings
    else if (isstring(segments))
        return str_join(segments, "/")

    ; List of mixed items
    else if (typeof(segments).eq."list") then

        ; Need to convert to an array internally
        _segments = new(ListCount(segments), string)

        do i = 0, ListCount(segments) - 1
            _segments(i) = tostring(segments[i])
        end do

        return os_path_join(_segments)

    end if
    end if
    end if

end
