# CSV

The CSV module facilitates some of the basic operations when dealing with CSV files, namely reading and writing.

To use the module, you must first import it into the current context (or import the whole nclx library):

```
; Import the csv module
load "$NCLX_ROOT/io/csv.ncl"
```

## Reading CSV files

```
function csv_read(filepath:string)
; Read a CSV file into a string array.
; Args:
;   filepath (string) : Full path to the file
; Returns:
;   content (array) : String array of the file content
```

For simplicity, CSV files are read in as string arrays (everything can be a string), so you will have to convert back into your desired data type before working with your data.

```
; Read the data (content will now be a 2D string array)
content = csv_read("my_data.csv")

; Get a list of the column headings
headers = content(0,:)

; Get the data and convert it to floats (ignoring the header on the first line)
data = tofloat(content(1:,:))
```

## Writing CSV files

```
procedure csv_write(filepath:string, content, header:string)
; Write content to filepath as a CSV
; Args:
;   filepath (string) : Full path to file
;   content (array, mixed) : 2D array of data
; Returns:
;   status (boolean) : True on success, False otherwise
```

Writing CSV files requires that you have 2-dimensional data to work with. Assume that you have a 2D array with a column of latitudes and a column of corresponding average temperature values. To write that into a CSV, you would use the following code:

```
; Add a header (omitting this creates a header-less csv)
temps_by_lat@csv_header = "latitude,avg_temperature"

; Write the CSV
csv_write("temp_by_lat.csv", temps_by_lat)
```

This would write a file in the current directory called "temp_by_lat.csv" with a header of "latitude,avg_temperature" and columnar data of latitudes and average temperatures.
