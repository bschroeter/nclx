# nclx

nclx is a collection of useful functions that acts as a drop-in library of functionality on top of the core NCL command set. It aims to make common tasks simpler through generic utilities so that we can all stop figuring out how to read or write a CSV line-by-line and get back to discovering great things from our data.

## Installation

1. Clone or download and unzip this repo.
2. Put it somewhere useful (like $HOME/lib/nclx)
3. Add the following to your .bash_profile (or equivalent):

```
export NCLX_ROOT=$HOME/lib/nclx
```

## Usage

To use the NCLx library, add this to the top of your script:

```
load "$NCLX_ROOT/nclx.ncl"
```

You can then use libraries in a number of ways:

```
; Load the library
load "$NCLX_ROOT/nclx.nclx"

; 1. Import a single module
import("io/csv")

; 2. Import multiple modules
import((/"io/csv", "io/netcdf", "strings"/))

; 3. Import the module directly
load "$NCLX_ROOT/io/csv.ncl"
```

See documentation for individual libraries by navigating to the markdown (.md) files on this repository.
