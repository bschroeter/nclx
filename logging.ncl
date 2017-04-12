; Functions for logging

; Log levels
undef("LOG_LEVELS")
LOG_LEVELS = (/"ALL","DEBUG","INFO","WARN","ERROR","FATAL","ALL"/)

; Default options, can be overwritten before or after import
if (.not.isdefined("LOG_PATH")) then LOG_PATH = "./output.log" end if
if (.not.isdefined("LOG_LEVEL")) then LOG_LEVEL = "DEBUG" end if
if (.not.isdefined("LOG_DATE_FORMAT")) then LOG_DATE_FORMAT = "%Y-%m-%d %H:%M:%S" end if

; Script name is taken from the command line
if (.not.isdefined("LOG_SCRIPT_NAME")) then

    LOG_SCRIPT_NAME = get_script_name()

    if (ismissing(LOG_SCRIPT_NAME)) then
        LOG_SCRIPT_NAME = "Unknown"
    end if
    
end if

undef("_log_date")
function _log_date()
; Returns the log date
; Returns:
;   timestamp (string) : The timestamp matching the format requested
begin
    return systemfunc("date +'" + LOG_DATE_FORMAT + "'")
end

undef("_log")
procedure _log(level:string, message)
; Writes to the log file
; Args:
;   level (string) : One of LOG_LEVELS
;   message (string) : Message that is (or can be cast to) a string
begin

    ; Only print messages greater than or equal to current level
    if (ind(LOG_LEVELS.eq.level).ge.ind(LOG_LEVELS.eq.LOG_LEVEL)) then
        system("echo " + _log_date() + " - " + level + " - " + LOG_SCRIPT_NAME + " - " + tostring(message) + " >> " + LOG_PATH)
    end if

end

undef("log_debug")
procedure log_debug(message)
; Log a debug message
; Args:
;   message (string) : Message that is (or can be cast to) a string
begin
    _log("DEBUG", message)
end

undef("log_info")
procedure log_info(message)
; Log an info message
; Args:
;   message (string) : Message that is (or can be cast to) a string
begin
    _log("INFO", message)
end

undef("log_warn")
procedure log_warn(message)
; Log a warn message
; Args:
;   message (string) : Message that is (or can be cast to) a string
begin
    _log("WARN", message)
end

undef("log_error")
procedure log_error(message)
; Log an error message
; Args:
;   message (string) : Message that is (or can be cast to) a string
begin
    _log("ERROR", message)
end

undef("log_fatal")
procedure log_fatal(message)
; Log a fatal message
; Args:
;   message (string) : Message that is (or can be cast to) a string
begin
    _log("FATAL", message)
end
