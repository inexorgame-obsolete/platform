This is a pack of libraries required to run and compile OctaForge on
the Windows operating system.

bin_win32 contains DLLs required to run Win32 builds of OctaForge. Copy
these into your bin_win32 directories.

bin_win64 contains DLLs required to run Win64 builds of OctaForge. Do
the same.

The "platform_windows" directory contains import libs and headers required
to compile OctaForge on Windows (both Win32 and Win64, feel free to remove
whichever you don't need). Copy the platform_windows directory into the src/
directory of OctaForge in order to compile.

The package exactly contains:

zlib - licensed under the zlib license.
SDL(_mixer,_image) - LGPL.
libcurl - MIT.
