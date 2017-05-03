# Contributor Guidelines

Contributing to nclx is welcome, following these guidelines.

Work in your own branch and send a pull request when you think it is ready to merge.

## Discrete modules

Modules must be discrete, as in they should have focussed intent and minimal dependencies from other sources. You can use other parts of nclx itself, but you must include the import statement at the top of the file. The ```undef``` keyword explained in a later guideline will avoid namespace collisions.

E.g.

```
load "$NCLX_ROOT/io/csv.ncl"

undef("my_function")
function my_function(filepath:string)
...
begin
    data = csv_read(filepath)
    ...
    return result
end
```

## "Like" modules go in a directory

If there are multiple, though similar modules pertaining to a particular use case, put them in a directory. For example, the "csv" and "netcdf" modules both pertain to input/output, so put them in the "io" directory.

## Always undefine

Before implementing a new function, it must be undefined first. This is to avoid namespace collisions and to ensure a clean state between modules. Undefining functions is simple:

```
undef("csv_read")
function csv_read(filepath:string)
...
```

The undefine keyword is to ensure the integrity of the program context, but should not be a replacement for creating a unique name.

## Naming conventions

### Module filenames should be lowercase-underscore and self-explanatory (no jargon).

They should also lend themselves to obvious abbreviation (i.e. the nclx netcdf module is abbreviated to "nc").

### Prefix module functions with the abbreviated name of module in which it resides.

For example, all functions in the "netcdf.ncl" package are prefixed with "nc_".

*netcdf.ncl*

```
; Functions for working with NetCDF files

undef("nc_read")
function nc_read(filepath:string)
```

### Function names should be unique

Take a look at existing components in nclx, as well as the core NCL command reference. DO NOT replace core functions in NCL!

### Functions should be human-readable and obvious in what they do.

Again, no jargon beyond the *very* common (like "csv" or "nc").

### Private functions should be underscored

If you have intermediary functions, that are not intended to be called by anything but another function in the same module, prefix it with an underscore.

```
undef("_my_internal_function")
function _my_internal_function(arg:string)
...
```

The function should otherwise follow these same guidelines, the only exception being the underscore signifying to the user that it should not be called directly.

## Document

Write a one-liner at the top of the file explaining what is to be expected below.

i.e.

```
; Functions for working with CSV files.
```

Docstrings are required for all functions, this follows the Google Python approach, like so:

```
undef("my_function")
function my_function(arg1:string)
; Do a thing.
; Args:
;   arg1 (string) : First argument
; Returns:
;   result (array) : Result of function
local internal_arg1, internal_arg2
begin
    ...
    return result
end
```

Any parts of the code within should also be commented if their purpose isn't immediately obvious.

Comment this:

```
; Find the meaning of life with respect to x
x = super_complex_external_algorithm(x**2, sqrt(2*x))
```

But not this (too obvious):

```
x = x + 1
```

## Always use locals

Use local variables at all times (and define them) so as to not overwrite variables outside of the function scope.

Also, never overwrite an external variable inside the function. Instead, return a variable that can be used by the user to replace the original variable if they wish.

## Assume nothing

Where possible, make no assumptions about the user's intent. Be clear on what the function should do and do not do so the user doesn't get any surprises.

## Be concise

Make smaller, incremental functions that build up to something greater. This enables the user to pick and choose components rather than monolithic functions that are hard to follow.

## Use data types

When defining a function, use a datatype in each parameter declaration. Only omit the data type if the argument could indeed be any of several datatypes and account for that within the function itself for flexibility. Remember to put this in the docstring.

```
function my_function(arg1:string, arg2)
; Do a thing.
; Args:
;   arg1 (string) : First argument
;   arg2 (mixed) : Second argument
```

## Keep it quiet

Module loading, or the calling of their functions should not print anything to screen. Leave that for the user downstream.

## Test, test, test

Test your module under a variety of circumstances to ensure that it behaves accordingly.

Eventually, nclx will feature an automated test suite. In the meantime, just test to make sure it works as best you can.

## Write a documentation file

Create a markdown file alongside your module with the same name as the .ncl file that shows basic usage. This should be Github-flavoured markdown and committed alongside your changes.

*my_module.md*

```
# MY MODULE

Short description of module...

How to load the module...

## Function one

Explain how to do function one with code examples (see existing md files for guidance).
```
