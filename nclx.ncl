; Master script to load nclx.
; To use:
; load "$NCLX_ROOT/nclx.ncl"
; import("io/csv") ; loads the csv module

undef("import")
procedure import(module)
; Import a module from NCLX
; Args:
;   module (string) : Module to load
local i
begin

    ; Load one module
    if (dimsizes(module).eq.1) then
        loadscript(getenv("NCLX_ROOT") + "/" + module + ".ncl")

    ; Load many modules
    else
        do i = 0, dimsizes(module) - 1
            import(module(i))
        end do
    end if

end
