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


## Writing NetCDF files (single variable)

```
; Write a simple netcdf of the variable of data (requires attributes, see doc)
; Args:
;   filepath (string) : Full path to the file
;   data (mixed) : Data (with atttributes) to write
```

Writing a NetCDF is automated as much as possible based on the attributes and coordinates assigned to a variable. This procedure writes a single-variable (plus coordinate variables) netcdf file to ```filepath```. As this procedure works on metadata and coordinates, you will need to define the following at minimum:

- All dimensions (coordinates) must be named
- The ```data``` variable must have the attribute ```nc_variable```, as this will define the name of the variable in the file.

The following is a basic example of writing a file with the module:

```
; Load the library
load "$NCLX_ROOT/nclx.ncl"
import("io/netcdf")

; Create a dummy variable, assign some data to it
data = new((/2,2,2/), float)
data(:,:,:) = 1.0

; Name the coordinates
data!0 = "time"
data!1 = "lat"
data!2 = "lon"

; Fill the coordinates with something
data&time = (/1.0,2.0/)
data&lat = (/5.0,10.0/)
data&lon = (/50.0,100.0/)

; Attributes prefixed with nc_ become global attributes (and are removed from the variable)
data@nc_variable = "my_awesome_data"
data@nc_title = "Here is the title"

; Other attributes stay on the variable
data@valid_min = 0.0

; Write the file
nc_write("my_file.nc", data)
```

This will create a file at ```my_file.nc``` with the structure as you have defined it:

```
netcdf my_file {
dimensions:
	time = 2 ;
	lat = 2 ;
	lon = 2 ;
variables:
	float time(time) ;
	float lat(lat) ;
	float lon(lon) ;
	float my_awesome_data(time, lat, lon) ;
		my_awesome_data:valid_min = 0.f ;
		my_awesome_data:_FillValue = 9.96921e+36f ;

// global attributes:
		:variable = "my_awesome_data" ;
		:title = "Here is the title" ;
}
```

As you can see, any attributes on the data object prefixed with "nc_" will be written as global attributes and removed from the variable. Remaining attributes will be retained on the variable as expected.
