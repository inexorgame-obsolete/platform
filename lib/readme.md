# Prebuilt Libraries for VS13, MinGW and some rare Linux ones

This directory contains a couple of subdirectories; this is
because we need separate sets of libs for separate targets:

* Different CPUs need different libs (32/64 bit)
* While C libs (or C++ libs not dependend on the stdlib) compiled in mingw/vs are compatible, C++ libs
  are not.
* C++ code compiled in Debug/Release mode in visual studio
  are incompatible (and not linkable)
* Different versions of VS are incompatible with each other
* VS uses import libraries (.libs that reference .dlls),
  while mingw needs the .dlls only
* Code compiled with mingw is generally compatible with code
  compiled in mingw.

In order to tackle this problem we maintain separate folders
for each target:

  **windows-ARCH**   -  containing the pure C libs (working for all windows compilers)
  **vs13-ARCH**      -  containing C++ libs for Visual Studio 13
  **mingw-ARCH**     -  containing C++ libs for mingw
  **linux-ARCH**     -  containing all shipped libs for linux compilers

Here **ARCH** is `i686` or `x86_64` (for a linux target) or `win32`/`win64` (for a windows target)

each compiler uses the corresponding general (platform) directory 
and its own compiler specific directory.

Since Visual Studio C++ Libraries are incompatible between debug and release mode, 
those are postfixed with the mode, e.g. `protobuf_debug.lib`.

# DLLs

All the DLLs we use are SDL libs. Since SDL is purely C code
they can be used for VS and mingw.
We need to be a bit careful about the dll import libs: The
dlls themselve are stored in windows-win32/windows-win64.
The import libs are stored in vs13-i686/vs13-x86_64, so VS
sees them and mingw does not. (For some reason mingw can't
handle these right).
