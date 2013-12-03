DIY Canon IR Remote
===================

Inspiration:

- http://www.thingiverse.com/thing:9914
- http://www.doc-diy.net/photo/eos_ir_remote/

Canon RC-1 IR remote control protocol:

- http://www.doc-diy.net/photo/rc-1_hacked/index.php

Code
----

The code is written in C for the Atmel ATtiny13a microcontroller.

To build the code::

    cd code
    make

The makefile is configured for the ATtiny13a. To upload the hex file to the
microcontroller::

    cd code
    make upload

If you want to reset the fuses to the default settings::

    cd code
    make setfuses

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
