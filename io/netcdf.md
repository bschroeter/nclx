# NetCDF

The NetCDF module facilitates some of the basic operations when dealing with NetCDF files..

To use the module, you must first import it into the current context (or import the whole nclx library):

```
; Import the csv module
load "$NCLX_ROOT/io/netcdf.ncl"
```

## Reading NetCDF files

```
; Alias to addfile or addfiles (works for both)
; Args:
;   filepath (string) : Full filepath (or array of filepaths) to load
; Returns:
;   file (file) : Opened file(s)
```

Reading a NetCDF file works in the same way as native NCL. The difference being that the function will take either a single file path or a list of file paths to open.

```
; Single file
nc = nc_read("my_file.nc")

; Multiple files
ncs = nc_read((/"file1.nc","file2.nc"/))
```

You can then use standard NCL to work with these file objects.
