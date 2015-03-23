# Libs for compiling mingw on windows

This directory contains a couple of subdirectories; this is
because we need separate sets of libs for separate targets:

* Different CPUs need different libs (32/64 bit x86 atm)
* While C libs compiled in mingw/vs are compatible, C++ libs
  are not.
* C++ code compiled with Debug/Release mode in visual studio
  is incompatible too
* Different versions of VS are incompatible with each other
* VS uses import libraries (.lib's that reference .dll's),
  while mingw does not
* Code compiled with mingw is generally compatible with code
  compiled in mingw.

In order to tackle this problem we maintain separate folders
for each target with directories. We use the following
naming scheme:

  COMPILER-ARCH

where COMPILER is either mingw or vs13 (we only support vs
2013), ARCH is i686 or x86_64 and mode is Debug or Release.

Leaving out the modes is valid. In this case the directory
applies for any mode.

The compiler "common" means, that th libs are valid for any
compiler, because they are pure C code.

# DLLs

All the DLLs we use are SDL libs. Since SDL is purely C code
they can be used for VS and mingw.
We need to be a bit careful about the dll import libs: The
dlls themselve are stored in common-i686/common-x86_64.
The import libs are stored in vs13-i686/vs13-x86_64, so VS
sees them and mingw does not. (For some reason mingw can't
handle these right).
