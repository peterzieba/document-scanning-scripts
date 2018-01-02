5/11/2017

= Overview =
These shell scripts provide an effective means for preprocessing scanned documents and manuals so that they may be manipulated.
The intention is to ease downstream processing for conversion to a PDF via Acrobat, for printing, or simply lossless compression.

Handled is:
 * Batch compression to a lossless format (LZW compression used in the TIFF format).
 * Removal of hole-punch marks and edges from scans.
 * More advanced functionality includes handling "booklets".
 ** Booklets have been defined here as a set of 8.5x11 pages, folded in half lengthwise, and stapled in the middle.
 ** If the staples were removed and simply batch scanned, the original page order of the scans will be of limited use.
 ** The requirements here are that the pages need to be divided in half and split into seperate files, reordered, and then rotated appropriately.

= Requirements =
 * A series of tiff files, with sequence numbers.
 * A linux box with the following installed:
 ** yum install ImageMagick libtiff-tools -y
 * A directory containing all of the tiff files.
 ** another directory within this one named "out" where the output is to be placed.
 * Tested (and recommended) under the following conditions:
 ** These scripts tested on CentOS 7. Any distro that can provide the "convert" and "tiffcp" commands will work.
 * Files were first generated on a Windows machine with an EPSON GT-S80 ADF scanner.

= Programs =
 * find-normal.sh
 ** Expects to be run from within the directory containing your PDF files.
 ** Expects an "out" directory to exist where the final output will go.
 ** Processes a normal stack of pages
 ** Calls "convert-normal.sh" for each page of the job.
 * find-booklet.sh
 ** Used to process pages that were previously folded in half and part of a booklet.
 ** Handles splitting, rotating, and resequencing the pages.
 ** Can't remember if was designed to start with middle pages first, or outside pages...
 ** Calls "convert-booklet.sh" for each page of the job.

= Variables =
 * To-do. Check convert-normal.sh

= Theory of operation =
 * To-do