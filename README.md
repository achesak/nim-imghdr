About
=====

nim-imghdr is a Nim module for determining the type of an image from a given file, filename, or sequence of bytes.
It can detect many common image formats. nim-imghdr is a port of Python's imghdr module.

Usage:
    
    testImage(file : File)
    testImage(filename : string)
    testImage(data : seq[int8])

nim-imghdr can also be used as a command line program:

    imghdr [filename1] [filename2] ...

List of detected formats:

* PNG (Portable Network Graphics) format - `ImageType.PNG`
* JPEG (Joint Photographic Experts Group) format (either JFIF or Exif) - `ImageType.JPEG`
* GIF (Graphics Interchange Format) format - `ImageType.GIF`
* TIFF (Tagged Image File Format) format - `ImageType.TIFF`
* SVG (Scalable Vector Graphics) format - `ImageType.SVG`
* SGI (Silicon Graphics workstation) format - `ImageType.RGB`
* PBM (portable bitmap) format - `ImageType.PBM`
* PGM (portable graymap) format - `ImageType.PGM`
* PPM (portable pixmap) format - `ImageType.PPM`
* PAM format - `ImageType.PAM`
* BMP (bitmap) format - `ImageType.BMP`
* XMB (X10 or X11 bitmap) format - `ImageType.XMB`
* Rast (Sun raster) format - `ImageType.Rast`
* CRW (Canon camera RAW) format - `ImageType.CRW`
* CR2 (Canon camera RAW 2) format - `ImageType.CR2`
* MRW (Minolta camera RAW) format - `ImageType.MRW`
* X3F (Sigma camera RAW) format - `ImageType.X3F`
* WEBP format - `ImageType.WEBP`
* XCF (GIMP native) format - `ImageType.XCF`
* GKSM (Graphics Kernel System) format - `ImageType.GKSM`
* PM (XV image) format - `ImageType.PM`
* FITS (Flexible Image Transport System) format - `ImageType.FITS`
* XPM (X PixMap 1 and 3) format - `ImageType.XPM`
* XPM2 (X PixMap 2) format - `ImageType.XPM2`
* PS (PostScript) format - `ImageType.PS`
* Xfig format - `ImageType.Xfig`
* IRIS format - `ImageType.IRIS`
* SPIFF (Still Picture Interchange File Format) format - `ImageType.SPIFF`
* GEM (GEM Raster) format - `ImageType.GEM`
* Amiga icon format - `ImageType.Amiga`
* TIB (Acronis True Image) format - `ImageType.TIB`
* JB2 (JBOG2) format - `ImageType.JB2`
* CIN (Kodak Cineon) format - `ImageType.CIN`
* PSP (Corel Paint Shop Pro) format - `ImageType.PSP`
* EXR (OpenEXR) format - `ImageType.EXR`
* CALS (CALS raster bitmap) format - `ImageType.CALS`
* DPX (Society of Motion Picture and Television Engineers Digital Picture Exchange image) format - `ImageType.DPX`
* SYM (Windows SDK graphics symbol) format - `ImageType.SYM`
* SDR (SmartDraw Drawing) format - `ImageType.SDR`
* IMG (Img Software Set Bitmap) format - `ImageType.IMG`
* ADEX (ADEX Corp. ChromaGraph Graphics Card Bitmap Graphic) format - `ImageType.ADEX`
* NITF (National Imagery Transmission Format) format - `ImageType.NITF`
* BigTIFF (Big Tagged Image File Format; TIFF > 4 GB) format - `ImageType.BigTIFF`
* GX2 (Show Partner graphics) format - `ImageType.GX2`
* PAT (GIMP pattern) format - `ImageType.PAT`
* CPT (Corel Photopaint) format - `ImageType.CPT`
* SYW (Harvard Graphics symbol graphic) format - `ImageType.SYW`
* DWG (generic AutoCAD drawing) format - `ImageType.DWG`
* PSD (Photoshop image) format - `ImageType.PSD`
* FBM (fuzzy bitmap) format - `ImageType.FBM`
* HDR (Radiance High Dynamic Range image) format - `ImageType.HDR`
* MP (Monochrome Picture TIFF bitmap) format - `ImageType.MP`
* DRW (generic drawing) format - `ImageType.DRW`
* Micrografx (Micrografx vector graphics) format - `ImageType.Micrografx`
* PIC (generic picture) format - `ImageType.PIC`
* VDI (Ventura Publisher/GEM VDI Image Format Bitmap) format - `ImageType.VDI`
* ICO (Windows icon) format - `ImageType.ICO`
* JP2 (JPEG-2000) format - `ImageType.JP2`
* YCC (Kodak YCC image) format - `ImageType.YCC`
* FPX (FlashPix) format - `ImageType.FPX`
* DCX (Graphics Multipage PCX bitmap) format - `ImageType.DCX`
* ITC format - `ImageType.ITC`
* NIFF (Navy Image File Format) format - `ImageType.NIFF`
* WMP (Windows Media Photo) format - `ImageType.WMP`
* BPG format - `ImageType.BPG`
* FLIF format - `ImageType.FLIF`
* Unknown format - `ImageType.Other`


License
=======

nim-imghdr is released under the MIT open source license.
