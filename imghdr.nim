# Nimrod module for determining the type of image files.
# Ported from Python's imghdr module.

# Written by Adam Chesak.
# Released under the MIT open source license.


## nimrod-imghdr is a Nimrod module for determining the type of image files.
##
## List of detected formats:
##
## - PNG (Portable Network Graphics) format - TImageType.PNG
## - JPEG (Joint Photographic Experts Group) format (either JFIF or Exif) - TImageType.JPEG
## - GIF (Graphics Interchange Format) format - TImageType.GIF
## - TIFF (Tagged Image File Format) format - TImageType.TIFF
## - SVG (Scalable Vector Graphics) format - TImageType.SVG
## - SGI (Silicon Graphics workstation) format - TImageType.RGB
## - PBM (portable bitmap) format - TImageType.PBM
## - PGM (portable graymap) format - TImageType.PGM
## - PPM (portable pixmap) format - TImageType.PPM
## - BMP (bitmap) format - TImageType.BMP
## - XMB (X10 or X11 bitmap) format - TImageType.XMB
## - Rast (Sun raster) format - TImageType.Rast
## - CRW (Canon camera RAW) format - TImageType.CRW
## - CR2 (Canon camera RAW 2) format - TImageType.CR2
## - MRW (Minolta camera RAW) format - TImageType.MRW
## - X3F (Sigma camera RAW) format - TImageType.X3F
## - WEBP format - TImageType.WEBP
## - XCF (GIMP native) format - TImageType.XCF
## - GKSM (Graphics Kernel System) format - TImageType.GKSM
## - PM (XV image) format - TImageType.PM
## - FITS (Flexible Image Transport System) format - TImageType.FITS
## - XPM (X PixMap 1 and 3) format - TImageType.XPM
## - XPM2 (X PixMap 2) format - TImageType.XPM2
## - PS (PostScript) format - TImageType.PS
## - Xfig format - TImageType.Xfig
## - IRIS format - TImageType.IRIS
## - SPIFF (Still Picture Interchange File Format) format - TImageType.SPIFF
## - GEM (GEM Raster) format - TImageType.GEM
## - Amiga icon format - TImageType.Amiga
## - TIB (Acronis True Image) format - TImageType.TIB
## - JB2 (JBOG2) format - TImageType.JB2
## - CIN (Kodak Cineon) format - TImageType.CIN
## - PSP (Corel Paint Shop Pro) format - TImageType.PSP
## - EXR (OpenEXR) format - TImageType.EXR
## - CALS (CALS raster bitmap) format - TImageType.CALS
## - DPX (Society of Motion Picture and Television Engineers Digital Picture Exchange image) format - TImageType.DPX
## - SYM (Windows SDK graphics symbol) format - TImageType.SYM
## - SDR (SmartDraw Drawing) format - TImageType.SDR
## - IMG (Img Software Set Bitmap) format - TImageType.IMG
## - ADEX (ADEX Corp. ChromaGraph Graphics Card Bitmap Graphic) format - TImageType.ADEX
## - NITF (National Imagery Transmission Format) format - TImageType.NITF
## - BigTIFF (Big Tagged Image File Format; TIFF > 4 GB) format - TImageType.BigTIFF
## - GX2 (Show Partner graphics) format - TImageType.GX2
## - PAT (GIMP pattern) format - TImageType.PAT
## - CPT (Corel Photopaint) format - TImageType.CPT
## - SYW (Harvard Graphics symbol graphic) format - TImageType.SYW
## - DWG (generic AutoCAD drawing) format - TImageType.DWG
## - PSD (Photoshop image) format - TImageType.PSD
## - FBM (fuzzy bitmap) format - TImageType.FBM
## - HDR (Radiance High Dynamic Range image) format - TImageType.HDR
## - MP (Monochrome Picture TIFF bitmap) format - TImageType.MP
## - DRW (generic drawing) format - TImageType.DRW
## - Micrografx (Micrografx vector graphics) format - TImageType.Micrografx
## - PIC (generic picture) format - TImageType.PIC
## - VDI (Ventura Publisher/GEM VDI Image Format Bitmap) format - TImageType.VDI
## - ICO (Windows icon) format - TImageType.ICO
## - JP2 (JPEG-2000) format - TImageType.JP2
## - Unknown format - TImageType.Other


import int2ascii


type TImageType* {.pure.} = enum
    PNG, JPEG, GIF, TIFF, RGB, PBM, PGM, PPM, BMP, XMB, CRW, CR2, SVG, MRW, X3F, WEBP, XCF,
    GKSM, PM, FITS, XPM, XPM2, PS, Xfig, IRIS, Rast, SPIFF, GEM, Amiga, TIB, JB2, CIN, PSP,
    EXR, CALS, DPX, SYM, SDR, IMG, ADEX, NITF, BigTIFF, GX2, PAT, CPT, SYW, DWG, PSD, FBM,
    HDR, MP, DRW, Micrografx, PIC, VDI, ICO, JP2, Other


proc testImage(data : seq[int8]): TImageType


proc testPNG(value : seq[int8]): bool = 
    ## Returns true if the image is a PNG.
    
    # tests: "\211PNG\r\n"
    return value[1] == 80 and value[2] == 78 and value[3] == 71 and value[4] == 13 and value[5] == 10


proc testJFIF(value : seq[int8]): bool = 
    ## Returns true if the image is JPEG data in JFIF format.
    
    # tests: "JFIF"
    return value[6] == 74 and value[7] == 70 and value[8] == 73 and value[9] == 70


proc testEXIF(value : seq[int8]): bool = 
    ## Returns true if the image is JPEG data in EXIF format.
    
    # tests: "Exif"
    return value[6] == 69 and value[7] == 120 and value[8] == 105 and value[9] == 102


proc testGIF(value : seq[int8]): bool = 
    ## Returns true if the image is a GIF.
    
    # tests: "GIF87a" or "GIF89a"
    return value[0] == 71 and value[1] == 73 and value[2] == 70 and value[3] == 56 and (value[4] == 57 or value[4] == 55) and value[5] == 97


proc testTIFF(value : seq[int8]): bool = 
    ## Returns true if the image is TIFF.
    
    # tests: "MM" or "II"
    return (value[0] == 77 and value[1] == 77) or (value[0] == 73 and value[1] == 73)


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
    return value[0] == 66 and value[1] == 77


proc testXMB(value : seq[int8]): bool = 
    ## Returns true if the image is a XMB.
    
    # tests: "#define "
    return value[0] == 35 and value[1] == 100 and value[1] == 101 and value[2] == 102 and value[3] == 105 and value[4] == 110 and value[5] == 101 and value[6] == 32


proc testRast(value : seq[int8]): bool = 
    ## Returns true if the image is a Sun raster file.
    
    # tests: "\x59\xA6\x6A\x95"
    return value[0] == 89 and value[1] == 166 and value[2] == 106 and value[3] == 149


proc testCRW(value : seq[int8]): bool = 
    ## Returns true if the image is a CRW (Canon camera RAW) file.
    
    # tests: "II" and "HEAPCCDR"
    return value[0] == 73 and value[1] == 73 and value[6] == 72 and value[7] == 69 and value[8] == 65 and value[9] == 67 and value[10] == 67 and value[11] == 68 and value[12] == 82


proc testCR2(value : seq[int8]): bool = 
    ## Returns true if the image is a CR2 (Canon camera Raw 2) file.
    
    # tests: ("II" or "MM") and "CR"
    return ((value[0] == 73 and value[1] == 73) or (value[0] == 77 and value[1] == 77)) and value[8] == 67 and value[9] == 82


proc testSVG(value : seq[int8]): bool = 
    ## Returns true if the image is a SVG.
    
    # tests: "<?xml" 
    # NOTE: this is a bad way of testing for an SVG, as it can easily fail (eg. extra whitespace before the xml definition)
    # TODO: write a better way. Might require changing from testing the first 32 bytes to testing everything, and using an
    # xml parser for ths one.
    return value[0] == 60 and value[1] == 63 and value[2] == 120 and value[3] == 109 and value[4] == 108


proc testMRW(value : seq[int8]): bool = 
    ## Returns true if the image is a MRW (Minolta camera RAW) file.
    
    # tests: " MRM"
    return value[0] == 32 and value[1] == 77 and value[2] == 82 and value[3] == 77


proc testX3F(value : seq[int8]): bool = 
    ## Returns true if the image is a X3F (Sigma camera RAW) file.
    
    # tests: "FOVb"
    return value[0] == 70 and value[1] == 79 and value[2] == 86 and value[3] == 98


proc testWEBP(value : seq[int8]): bool = 
    ## Returns true if the image is a WEBP.
    
    # tests: "RIFF" and "WEBP"
    return value[0] == 82 and value[1] == 73 and value[2] == 70 and value[3] == 70 and value[8] == 87 and value[9] == 69 and value[10] == 66 and value[11] == 80


proc testXCF(value : seq[int8]): bool = 
    ## Returns true if the image is a XCF.
    
    # tests: "gimp xcf"
    return value[0] == 103 and value[1] == 105 and value[2] == 109 and value[3] == 112 and value[4] == 32 and value[5] == 120 and value[6] == 99 and value[7] == 102


proc testGKSM(value : seq[int8]): bool = 
    ## Returns true if the image is a GKSM (Graphics Kernel System) file. Yay for supporting things that are utterly out of date!
    ##http://en.wikipedia.org/wiki/Graphical_Kernel_System
    
    # tests: "GKSM"
    return value[0] == 71 and value[1] == 75 and value[2] == 83 and value[3] == 77


proc testPM(value : seq[int8]): bool = 
    ## Returns true if the image is a PM.
    
    # tests: "VIEW"
    return value[0] == 86 and value[1] == 73 and value[2] == 69 and value[3] == 87


proc testFITS(value : seq[int8]): bool = 
    ## Returns true if the image is a FITS.
    
    # tests: "SIMPLE"
    return value[0] == 83 and value[1] == 77 and value[2] == 77 and value[3] == 80 and value[4] == 76 and value[5] == 69


proc testXPM(value : seq[int8]): bool = 
    ## Returns true if the image is XPM1 or XPM3.
    
    # tests: "/* XPM */"
    return value[0] == 47 and value[1] == 42 and value[2] == 32 and value[3] == 88 and value[4] == 80 and value[5] == 77 and value[6] == 32 and value[7] == 42 and value[8] == 47


proc testXPM2(value : seq[int8]): bool = 
    ## Returns true if the image is XPM2.
    
    # tests: "! XPM2"
    return value[0] == 33 and value[1] == 32 and value[2] == 88 and value[3] == 80 and value[4] == 77 and value[5] == 50


proc testPS(value : seq[int8]): bool = 
    ## Returns true if the image is PS.
    
    # tests: "%!"
    return value[0] == 37 and value[1] == 33


proc testXFIG(value : seq[int8]): bool = 
    ## Returns true if the image is Xfig
    
    # tests: "#FIG"
    return value[0] == 35 and value[1] == 70 and value[2] == 73 and value[3] == 71


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
    return value[0..2] == "v/1" and value[0] == 1


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


proc testImage*(file : TFile): TImageType =
    ## Determines the format of the image file given.
    
    var data = newSeq[int8](32)
    discard file.readBytes(data, 0, 32)
    return testImage(data)


proc testImage*(filename : string): TImageType = 
    ## Determines the format of the image with the specified filename.
    
    var file : TFile = open(filename)
    var format : TImageType = testImage(file)
    file.close()
    return format


proc testImage*(data : seq[int8]): TImageType = 
    ## Determines the format of the image from the bytes given.
    
    if testPNG(data):
        return TImageType.PNG
    elif testJFIF(data) or testEXIF(data):
        return TImageType.JPEG
    elif testGIF(data):
        return TImageType.GIF
    elif testCRW(data):
        return TImageType.CRW
    elif testCR2(data):
        return TImageType.CR2
    elif testTIFF(data):
        return TImageType.TIFF
    elif testRGB(data):
        return TImageType.RGB
    elif testPBM(data):
        return TImageType.PBM
    elif testPGM(data):
        return TImageType.PGM
    elif testPPM(data):
        return TImageType.PPM
    elif testBMP(data):
        return TImageType.BMP
    elif testXMB(data):
        return TImageType.XMB
    elif testRast(data):
        return TImageType.Rast
    elif testSVG(data):
        return TImageType.SVG
    elif testMRW(data):
        return TImageType.MRW
    elif testX3F(data):
        return TImageType.X3F
    elif testWEBP(data):
        return TImageType.WEBP
    elif testXCF(data):
        return TImageType.XCF
    elif testGKSM(data):
        return TImageType.GKSM
    elif testPM(data):
        return TImageType.PM
    elif testFITS(data):
        return TImageType.FITS
    elif testXPM(data):
        return TImageType.XPM
    elif testXPM2(data):
        return TImageType.XPM2
    elif testPS(data):
        return TImageType.PS
    elif testXFIG(data):
        return TImageType.Xfig
    elif testIRIS(data):
        return TImageType.IRIS
    elif testSPIFF(data):
        return TImageType.SPIFF
    elif testGEM(data):
        return TImageType.GEM
    elif testAmiga(data):
        return TImageType.Amiga
    elif testTIB(data):
        return TImageType.TIB
    elif testJB2(data):
        return TImageType.JB2
    elif testCIN(data):
        return TImageType.CIN
    elif testPSP(data):
        return TImageType.PSP
    elif testEXR(data):
        return TImageType.EXR
    elif testCALS(data):
        return TImageType.CALS
    elif testDPX(data):
        return TImageType.DPX
    elif testSYM(data):
        return TImageType.SYM
    elif testSDR(data):
        return TImageType.SDR
    elif testIMG(data):
        return TImageType.IMG
    elif testADEX(data):
        return TImageType.ADEX
    elif testNITF(data):
        return TImageType.NITF
    elif testBigTIFF(data):
        return TImageType.BigTIFF
    elif testGX2(data):
        return TImageType.GX2
    elif testPAT(data):
        return TImageType.PAT
    elif testCPT(data):
        return TImageType.CPT
    elif testSYW(data):
        return TImageType.SYW
    elif testDWG(data):
        return TImageType.DWG
    elif testPSD(data):
        return TImageType.PSD
    elif testFBM(data):
        return TImageType.FBM
    elif testHDR(data):
        return TImageType.HDR
    elif testMP(data):
        return TImageType.MP
    elif testDRW(data):
        return TImageType.DRW
    elif testMicrografx(data):
        return TImageType.Micrografx
    elif testPIC(data):
        return TImageType.PIC
    elif testVDI(data):
        return TImageType.VDI
    elif testICO(data):
        return TImageType.ICO
    elif testJP2(data):
        return TImageType.JP2
    else:
        return TImageType.Other
