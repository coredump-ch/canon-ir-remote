DIY Canon IR Remote
===================

Inspiration:

- http://www.thingiverse.com/thing:9914
- http://www.doc-diy.net/photo/eos_ir_remote/

Canon RC-1 IR remote control protocol:

- http://www.doc-diy.net/photo/rc-1_hacked/index.php

Blogpost about this project (German):
http://www.coredump.ch/2014/01/04/diy-canon-ir-fernausloser/

Code
----

The code is written in C for the Atmel ATtiny13a microcontroller, running at
9.6MHz without the ``CKDIV8`` fuse set.

To build the code::

    cd code
    make

The makefile is configured for the ATtiny13a. First set the fuses::

    make setfuses

To upload the hex file to the microcontroller::

    make upload


The code is based on the work of Luk from `doc-diy.net
<http://www.doc-diy.net>`__ (http://www.doc-diy.net/photo/eos_ir_remote/). My
changes are licensed under the MIT license.

3D Model
--------

In the file ``model/canon_ir_v2.scad`` you can find the OpenSCAD sourcecode for
my remote 3D model. After a conversion to the STL format it can be printed on a
regular 3D printer.

The model is based on the design by Ted Lin
(http://www.thingiverse.com/thing:9914). The modified version is licensed as CC
BY-SA.

Licenses
--------

- Sourcecode: MIT License
- Case: CC BY-SA 3.0
