Gitvs version (i)
=================

This program wraps git to make it more like cvs.
Dr Owain Kenway

Where it is distributed, it is done so under my special 5 clause,
BSD-style license (see LICENSE.txt)

Install
-------

To install, make sure you have ghc installed, modify the Makefile with
your options and then issue:

make && make install

Usage
-----

The gitvs executable takes input from stdin.

./gitvs [commit] [update]
