# Nim module for determining the type of image files.
# Ported from Python's imghdr module.

# Written by Adam Chesak.
# Released under the MIT open source license.


## nim-imghdr is a Nim module for determining the type of image files.
##
## List of detected formats:
##
## - PNG (Portable Network Graphics) format - ImageType.PNG
## - JPEG (Joint Photographic Experts Group) format (either JFIF or Exif) - ImageType.JPEG
## - GIF (Graphics Interchange Format) format - ImageType.GIF
## - TIFF (Tagged Image File Format) format - ImageType.TIFF
## - SVG (Scalable Vector Graphics) format - ImageType.SVG
## - SGI (Silicon Graphics workstation) format - ImageType.RGB
## - PBM (portable bitmap) format - ImageType.PBM
## - PGM (portable graymap) format - ImageType.PGM
## - PPM (portable pixmap) format - ImageType.PPM
## - BMP (bitmap) format - ImageType.BMP
## - XMB (X10 or X11 bitmap) format - ImageType.XMB
## - Rast (Sun raster) format - ImageType.Rast
## - CRW (Canon camera RAW) format - ImageType.CRW
## - CR2 (Canon camera RAW 2) format - ImageType.CR2
## - MRW (Minolta camera RAW) format - ImageType.MRW
## - X3F (Sigma camera RAW) format - ImageType.X3F
## - WEBP format - ImageType.WEBP
## - XCF (GIMP native) format - ImageType.XCF
## - GKSM (Graphics Kernel System) format - ImageType.GKSM
## - PM (XV image) format - ImageType.PM
## - FITS (Flexible Image Transport System) format - ImageType.FITS
## - XPM (X PixMap 1 and 3) format - ImageType.XPM
## - XPM2 (X PixMap 2) format - ImageType.XPM2
## - PS (PostScript) format - ImageType.PS
## - Xfig format - ImageType.Xfig
## - IRIS format - ImageType.IRIS
## - SPIFF (Still Picture Interchange File Format) format - ImageType.SPIFF
## - GEM (GEM Raster) format - ImageType.GEM
## - Amiga icon format - ImageType.Amiga
## - TIB (Acronis True Image) format - ImageType.TIB
## - JB2 (JBOG2) format - ImageType.JB2
## - CIN (Kodak Cineon) format - ImageType.CIN
## - PSP (Corel Paint Shop Pro) format - ImageType.PSP
## - EXR (OpenEXR) format - ImageType.EXR
## - CALS (CALS raster bitmap) format - ImageType.CALS
## - DPX (Society of Motion Picture and Television Engineers Digital Picture Exchange image) format - ImageType.DPX
## - SYM (Windows SDK graphics symbol) format - ImageType.SYM
## - SDR (SmartDraw Drawing) format - ImageType.SDR
## - IMG (Img Software Set Bitmap) format - ImageType.IMG
## - ADEX (ADEX Corp. ChromaGraph Graphics Card Bitmap Graphic) format - ImageType.ADEX
## - NITF (National Imagery Transmission Format) format - ImageType.NITF
## - BigTIFF (Big Tagged Image File Format; TIFF > 4 GB) format - ImageType.BigTIFF
## - GX2 (Show Partner graphics) format - ImageType.GX2
## - PAT (GIMP pattern) format - ImageType.PAT
## - CPT (Corel Photopaint) format - ImageType.CPT
## - SYW (Harvard Graphics symbol graphic) format - ImageType.SYW
## - DWG (generic AutoCAD drawing) format - ImageType.DWG
## - PSD (Photoshop image) format - ImageType.PSD
## - FBM (fuzzy bitmap) format - ImageType.FBM
## - HDR (Radiance High Dynamic Range image) format - ImageType.HDR
## - MP (Monochrome Picture TIFF bitmap) format - ImageType.MP
## - DRW (generic drawing) format - ImageType.DRW
## - Micrografx (Micrografx vector graphics) format - ImageType.Micrografx
## - PIC (generic picture) format - ImageType.PIC
## - VDI (Ventura Publisher/GEM VDI Image Format Bitmap) format - ImageType.VDI
## - ICO (Windows icon) format - ImageType.ICO
## - JP2 (JPEG-2000) format - ImageType.JP2
## - Unknown format - ImageType.Other


proc int2ascii(i : seq[int8]): string = 
    ## Converts a sequence of integers into a string containing all of the characters.
    
    var s : string = ""
    for j, value in i:
        s = s & (chr(int(value)))
    return s


proc `==`(i : seq[int8], s : string): bool = 
    ## Operator for comparing a seq of ints with a string.
    
    return int2ascii(i) == s


type ImageType* {.pure.} = enum
    PNG, JPEG, GIF, TIFF, RGB, PBM, PGM, PPM, BMP, XMB, CRW, CR2, SVG, MRW, X3F, WEBP, XCF,
    GKSM, PM, FITS, XPM, XPM2, PS, Xfig, IRIS, Rast, SPIFF, GEM, Amiga, TIB, JB2, CIN, PSP,
    EXR, CALS, DPX, SYM, SDR, IMG, ADEX, NITF, BigTIFF, GX2, PAT, CPT, SYW, DWG, PSD, FBM,
    HDR, MP, DRW, Micrografx, PIC, VDI, ICO, JP2, Other


proc testImage*(data : seq[int8]): ImageType


proc testPNG(value : seq[int8]): bool = 
    ## Returns true if the image is a PNG.
    
    # tests: "\211PNG\r\n"
    return value[1] == 80 and value[2] == 78 and value[3] == 71 and value[4] == 13 and value[5] == 10


proc testJFIF(value : seq[int8]): bool = 
    ## Returns true if the image is JPEG data in JFIF format.
    
    # tests: "JFIF"
    return value[6..9] == "JFIF"


proc testEXIF(value : seq[int8]): bool = 
    ## Returns true if the image is JPEG data in EXIF format.
    
    # tests: "Exif"
    return value[6..9] == "Exif"


proc testGIF(value : seq[int8]): bool = 
    ## Returns true if the image is a GIF.
    
    # tests: "GIF87a" or "GIF89a"
    return value[0..5] == "GIF87a" or value[0..5] == "GIF89a"


proc testTIFF(value : seq[int8]): bool = 
    ## Returns true if the image is TIFF.
    
    # tests: "MM" or "II"
    return value[0..1] == "MM" or value[0..1] == "II"


proc testRGB(value : seq[int8]): bool = 
    ## Returns true if the image is in the SGI format.
    
    # tests: "\001\332"
    return value[0] == 1 and value[1] == 332


proc testPBM(value : seq[int8]): bool = 
    ## Returns true if the image is a PBM.
    
    # tests: "P[1,4][ \t\n\r]"
    return len(value) >= 3 and value[0] == 80 and (value[1] == 49 or value[1] == 52) and (value[3] == 32 or value[3] == 9 or value[3] == 10 or value[3] == 13)


proc testPGM(value : seq[int8]): bool = 
    ## Returns true if the image is a PGM.
    
    # tests: "P[2,5][ \t\n\r]"
    return len(value) >= 3 and value[0] == 80 and (value[1] == 50 or value[1] == 53) and (value[3] == 32 or value[3] == 9 or value[3] == 10 or value[3] == 13)


proc testPPM(value : seq[int8]): bool = 
    ## Returns true if the image is a PPM.
    
    # tests: "P[3,6][ \t\n\r]"
    return len(value) >= 3 and value[0] == 80 and (value[1] == 51 or value[1] == 54) and (value[3] == 32 or value[3] == 9 or value[3] == 10 or value[3] == 13)


proc testBMP(value : seq[int8]): bool = 
    ## Returns true if the image is a BMP.
    
    # tests: "BM"
    return value[0..1] == "BM"


proc testXMB(value : seq[int8]): bool = 
    ## Returns true if the image is a XMB.
    
    # tests: "#define "
    return value[0..6] == "#define "


proc testRast(value : seq[int8]): bool = 
    ## Returns true if the image is a Sun raster file.
    
    # tests: "\x59\xA6\x6A\x95"
    return value[0] == 89 and value[1] == 166 and value[2] == 106 and value[3] == 149


proc testCRW(value : seq[int8]): bool = 
    ## Returns true if the image is a CRW (Canon camera RAW) file.
    
    # tests: "II" and "HEAPCCDR"
    return value[0..1] == "II" and value[6..12] == "HEAPCCDR"


proc testCR2(value : seq[int8]): bool = 
    ## Returns true if the image is a CR2 (Canon camera Raw 2) file.
    
    # tests: ("II" or "MM") and "CR"
    return (value[0..1] == "II" or value[0..1] == "MM") and value[8..9] == "CR"


proc testSVG(value : seq[int8]): bool = 
    ## Returns true if the image is a SVG.
    
    # tests: "<?xml" 
    # NOTE: this is a bad way of testing for an SVG, as it can easily fail (eg. extra whitespace before the xml definition)
    # TODO: write a better way. Might require changing from testing the first 32 bytes to testing everything, and using an
    # xml parser for ths one.
    return value[0..4] == "<?xml"


proc testMRW(value : seq[int8]): bool = 
    ## Returns true if the image is a MRW (Minolta camera RAW) file.
    
    # tests: " MRM"
    return value[0..3] == " MRM"


proc testX3F(value : seq[int8]): bool = 
    ## Returns true if the image is a X3F (Sigma camera RAW) file.
    
    # tests: "FOVb"
    return value[0..3] == "FOVb"


proc testWEBP(value : seq[int8]): bool = 
    ## Returns true if the image is a WEBP.
    
    # tests: "RIFF" and "WEBP"
    return value[0..3] == "RIFF" and value[8..11] == "WEBP"


proc testXCF(value : seq[int8]): bool = 
    ## Returns true if the image is a XCF.
    
    # tests: "gimp xcf"
    return value[0..7] == "gimp xcf"


proc testGKSM(value : seq[int8]): bool = 
    ## Returns true if the image is a GKSM (Graphics Kernel System) file. Yay for supporting things that are utterly out of date!
    ##http://en.wikipedia.org/wiki/Graphical_Kernel_System
    
    # tests: "GKSM"
    return value[0..3] == "GKSM"


proc testPM(value : seq[int8]): bool = 
    ## Returns true if the image is a PM.
    
    # tests: "VIEW"
    return value[0..3] == "VIEW"


proc testFITS(value : seq[int8]): bool = 
    ## Returns true if the image is a FITS.
    
    # tests: "SIMPLE"
    return value[0..5] == "SIMPLE"


proc testXPM(value : seq[int8]): bool = 
    ## Returns true if the image is XPM1 or XPM3.
    
    # tests: "/* XPM */"
    return value[0..8] == "/* XPM */"


proc testXPM2(value : seq[int8]): bool = 
    ## Returns true if the image is XPM2.
    
    # tests: "! XPM2"
    return value[0..5] == "! XPM2"


proc testPS(value : seq[int8]): bool = 
    ## Returns true if the image is PS.
    
    # tests: "%!"
    return value[0..1] == "%!"


proc testXFIG(value : seq[int8]): bool = 
    ## Returns true if the image is Xfig
    
    # tests: "#FIG"
    return value[0..3] == "#FIG"


proc testIRIS(value : seq[int8]): bool = 
    ## Returns true if the image is IRIS.
    
    # tests: 01 da
    return value[0] == 1 and value[1] == 218


proc testSPIFF(value : seq[int8]): bool =
    ## Returns true if the image is JPEG data in SPIFF format.
    
    # tests: "SPIFF"
    return value[6..10] == "SPIFF"


proc testGEM(value : seq[int8]): bool = 
    ## Returns true if the image is a GEM Raster file.
    
    # tests: EB 3C 90 2A
    return value[0] == 235 and value[1] == 60 and value[2] == 144 and value[3] == 42


proc testAmiga(value : seq[int8]): bool = 
    ## Returns true if the image is an Amiga icon file.
    
    # tests: E3 10 00 01 00 00 00 00
    return value[0] == 227 and value[1] == 16 and value[2] == 0 and value[3] == 1 and value[4] == 0 and value[5] == 0 and value[6] == 0 and value[7] == 0


proc testTIB(value : seq[int8]): bool = 
    ## Returns true if the image is an Acronis True Image file.
    
    # tests: "´nhd"
    return value[0..3] == "´nhd"


proc testJB2(value : seq[int8]): bool = 
    ## Returns true if the image is a JBOG2 image file.
    
    # tests: 97 and "JB2"
    return value[0] == 151 and value[1..3] == "JB2"


proc testCIN(value : seq[int8]): bool = 
    ## Returns true if the image is a Kodak Cineon file.
    
    # tests: 80 2A 5F D7
    return value[0] == 128 and value[1] == 42 and value[2] == 95 and value[3] == 215


proc testPSP(value : seq[int8]): bool = 
    ## Returns true if the image is a Corel Paint Shop Pro image file.
    
    # tests: "BK" and 00
    return value[1..2] == "BK" and value[3] == 0


proc testEXR(value : seq[int8]): bool = 
    ## Returns true if the image is an OpenEXR bitmap file.
    
    # tests: "v/1" and 01
    return value[0..2] == "v/1" and value[2] == 1


proc testCALS(value : seq[int8]): bool = 
    ## Returns true if the image is a CALS raster bitmap file.
    
    # tests: "srcdocid:"
    return value[0..8] == "srcdocid:"


proc testDPX(value : seq[int8]): bool = 
    ## Returns true if the image is a Society of Motion Picture and Television Engineers Digital Picture Exchange image file.
   
    # tests: "XPDS" or "SDPX"
    return value[0..3] == "XPDS" or value[0..3] == "SDPX"


proc testSYM(value : seq[int8]): bool =
    ## Returns true if the image is a Windows SDK graphics symbol.
    
    # tests: "Smbl"
    return value[0..3] == "Smbl"


proc testSDR(value : seq[int8]): bool = 
    ## Returns true if the image is a SmartDraw Drawing file.
    
    # tests: "SMARTDRW"
    return value[0..7] == "SMARTDRW"


proc testIMG(value : seq[int8]): bool = 
    ## Returns true if the image is a Img Software Set Bitmap.
    
    # tests: "SCMI"
    return value[0..3] == "SCMI"


proc testADEX(value : seq[int8]): bool = 
    ## Returns true if the image is an ADEX Corp. ChromaGraph Graphics Card Bitmap Graphic.
    
    # tests: "PICT" and 00 08
    return value[0..3] == "PICT" and value[4] == 0 and value[5] == 8


proc testNITF(value : seq[int8]): bool = 
    ## Returns true if the image is a National Imagery Transmission Format.
    
    # tests: "NITF0"
    return value[0..4] == "NITF0"


proc testBigTIFF(value : seq[int8]): bool = 
    ## Returns true if the image is a BigTIFF (TIFF > 4 GB).
    
    # tests: "MM" and 00 2B
    return value[0..1] == "MM" and value[2] == 0 and value[3] == 43


proc testGX2(value : seq[int8]): bool = 
    ## Returns true if the image is a Show Partner graphics.
    
    # tests: "GX2"
    return value[0..2] == "GX2"


proc testPAT(value : seq[int8]): bool = 
    ## Returns true if the image is a GIMP pattern file.
    
    # tests: "GPAT"
    return value[0..3] == "GPAT"


proc testCPT(value : seq[int8]): bool = 
    ## Returns true if the image is a Corel Photopaint file.
    
    # tests: "CPTFILE" or "CPT7FILE"
    return value[0..6] == "CPTFILE" or value[0..7] == "CPT7FILE"


proc testSYW(value : seq[int8]): bool = 
    ## Returns true if the image is a Harvard Graphics symbol graphic.
    
    # tests: "AMYO"
    return value[0..3] == "AMYO"


proc testDWG(value : seq[int8]): bool = 
    ## Returns true if the image is a generic AutoCAD drawing.
    
    # tests: "AC10"
    return value[0..3] == "AC10"


proc testPSD(value : seq[int8]): bool = 
    ## Returns true if the image is a Photoshop image.
    
    # tests: "8BPS"
    return value[0..3] == "8BPS"


proc testFBM(value : seq[int8]): bool = 
    ## Returns true if the image is a Fuzzy bitmap file.
    
    # tests: "%bitmap"
    return value[0..6] == "%bitmap"


proc testHDR(value : seq[int8]): bool = 
    ## Returns true if the image is a Radiance High Dynamic Range image.
    
    # tests: "#?RADIANCE"
    return value[0..9] == "#?RADIANCE"


proc testMP(value : seq[int8]): bool = 
    ## Returns true if the image is a Monochrome Picture TIFF bitmap file.
    
    # tests: 0C ED
    return value[0] == 12 and value[1] == 237


proc testDRW(value : seq[int8]): bool = 
    ## Returns true if the image is a generic drawing.
    
    # tests: 07
    return value[0] == 7


proc testMicrografx(value : seq[int8]): bool = 
    ## Returns true if the image is a Micrografx vector graphics file.
    
    # tests: 01 FF 02 04 03 02
    return value[0] == 1 and value[1] == 255 and value[2] == 2 and value[3] == 4 and value[4] == 3 and value[5] == 2


proc testPIC(value : seq[int8]): bool = 
    ## Returns true if the image is a PIC.
    
    # tests: 01 00 00 00 01
    return value[0] == 1 and value[1] == 0 and value[2] == 0 and value[3] == 0 and value[4] == 1


proc testVDI(value : seq[int8]): bool = 
    ## Returns true if the image is a Ventura Publisher/GEM VDI Image Format Bitmap file.
    
    # tests: 00 01 00 08 00 01 00 01 01
    return value[0] == 0 and value[1] == 1 and value[2] == 0 and value[3] == 8 and value[4] == 0 and value[5] == 1 and value[6] == 0 and
        value[7] == 1 and value[8] == 1


proc testICO(value : seq[int8]): bool = 
    ## Returns true if the image is a Windows icon file.
    
    # tests: 00 00 01 00
    return value[0] == 0 and value[1] == 0 and value[2] == 1 and value[3] == 0


proc testJP2(value : seq[int8]): bool = 
    ## Returns true if the image is a JPEG-2000.
    
    # tests: 00 00 00 0C and "jP"
    return value[0] == 0 and value[1] == 0 and value[2] == 0 and value[3] == 12 and value[4..5] == "jP"


proc testImage*(file : File): ImageType =
    ## Determines the format of the image file given.
    
    var data = newSeq[int8](32)
    discard file.readBytes(data, 0, 32)
    return testImage(data)


proc testImage*(filename : string): ImageType = 
    ## Determines the format of the image with the specified filename.
    
    var file : File = open(filename)
    var format : ImageType = testImage(file)
    file.close()
    return format


proc testImage*(data : seq[int8]): ImageType = 
    ## Determines the format of the image from the bytes given.
    
    if testPNG(data):
        return ImageType.PNG
    elif testJFIF(data) or testEXIF(data):
        return ImageType.JPEG
    elif testGIF(data):
        return ImageType.GIF
    elif testCRW(data):
        return ImageType.CRW
    elif testCR2(data):
        return ImageType.CR2
    elif testTIFF(data):
        return ImageType.TIFF
    elif testRGB(data):
        return ImageType.RGB
    elif testPBM(data):
        return ImageType.PBM
    elif testPGM(data):
        return ImageType.PGM
    elif testPPM(data):
        return ImageType.PPM
    elif testBMP(data):
        return ImageType.BMP
    elif testXMB(data):
        return ImageType.XMB
    elif testRast(data):
        return ImageType.Rast
    elif testSVG(data):
        return ImageType.SVG
    elif testMRW(data):
        return ImageType.MRW
    elif testX3F(data):
        return ImageType.X3F
    elif testWEBP(data):
        return ImageType.WEBP
    elif testXCF(data):
        return ImageType.XCF
    elif testGKSM(data):
        return ImageType.GKSM
    elif testPM(data):
        return ImageType.PM
    elif testFITS(data):
        return ImageType.FITS
    elif testXPM(data):
        return ImageType.XPM
    elif testXPM2(data):
        return ImageType.XPM2
    elif testPS(data):
        return ImageType.PS
    elif testXFIG(data):
        return ImageType.Xfig
    elif testIRIS(data):
        return ImageType.IRIS
    elif testSPIFF(data):
        return ImageType.SPIFF
    elif testGEM(data):
        return ImageType.GEM
    elif testAmiga(data):
        return ImageType.Amiga
    elif testTIB(data):
        return ImageType.TIB
    elif testJB2(data):
        return ImageType.JB2
    elif testCIN(data):
        return ImageType.CIN
    elif testPSP(data):
        return ImageType.PSP
    elif testEXR(data):
        return ImageType.EXR
    elif testCALS(data):
        return ImageType.CALS
    elif testDPX(data):
        return ImageType.DPX
    elif testSYM(data):
        return ImageType.SYM
    elif testSDR(data):
        return ImageType.SDR
    elif testIMG(data):
        return ImageType.IMG
    elif testADEX(data):
        return ImageType.ADEX
    elif testNITF(data):
        return ImageType.NITF
    elif testBigTIFF(data):
        return ImageType.BigTIFF
    elif testGX2(data):
        return ImageType.GX2
    elif testPAT(data):
        return ImageType.PAT
    elif testCPT(data):
        return ImageType.CPT
    elif testSYW(data):
        return ImageType.SYW
    elif testDWG(data):
        return ImageType.DWG
    elif testPSD(data):
        return ImageType.PSD
    elif testFBM(data):
        return ImageType.FBM
    elif testHDR(data):
        return ImageType.HDR
    elif testMP(data):
        return ImageType.MP
    elif testDRW(data):
        return ImageType.DRW
    elif testMicrografx(data):
        return ImageType.Micrografx
    elif testPIC(data):
        return ImageType.PIC
    elif testVDI(data):
        return ImageType.VDI
    elif testICO(data):
        return ImageType.ICO
    elif testJP2(data):
        return ImageType.JP2
    else:
        return ImageType.Other
