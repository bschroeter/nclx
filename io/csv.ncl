; Functions for working with CSV files.

undef("csv_read")
function csv_read(filepath:string)
; Read a CSV file into a string array.
; Args:
;   filepath (string) : Full path to the file
; Returns:
;   content (array) : String array of the file content
local data, cols, rows, csv, i
begin

    ; Read all of the data, line by line
    data = asciiread(filepath, -1, "string")

    ; Extract the dimensionality
    cols = dimsizes(str_split(data(0),","))
    rows = dimsizes(data)

    ; Build the empty string matrix, fill it
    csv = new((/rows,cols/),"string")
    do i = 0, rows-1
        csv(i,:) = str_split(data(i),",")
    end do

    ; Return the result
    return csv
end

undef("csv_write")
procedure csv_write(filepath:string, content, header:string)
; Write content to filepath as a CSV
; Args:
;   filepath (string) : Full path to file
;   content (array, mixed) : 2D array of data
local shape, num_lines, lines, line, row_ix
begin

    shape = dimsizes(data)

    if (dimsizes(shape).ne.2) then
        print("Data must be 2D to write to csv")
        return False
    end if

    ; Add the header, if it is set
    if (isatt(content, "csv_header")) then

        num_lines = shape(0) + 1
        lines = new(num_lines, string)

        lines(0) = content@csv_header

        do row_ix = 0, shape(0)-1
            ; write loop content
            line := str_join(tostring(data(row_ix,:)),",")
            lines(row_ix+1) = line
        end do

    else

        num_lines = shape(0)
        lines = new(num_lines, string)

        do row_ix = 0, shape(0)-1
            ; write loop content
            line := str_join(tostring(data(row_ix,:)),",")
            lines(row_ix) = line
        end do

    end if

    ; Output the CSV
    asciiwrite(filepath, lines)

end
