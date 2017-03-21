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

In any script you want to use the library, put this at the top:

```
load "$NCLX_ROOT/nclx.ncl"
```

You will then have access to all of the functionality in the library. Alternatively, you can load just a single module from the library. Like so:

```
load "$NCLX_ROOT/io/csv.ncl"
```
