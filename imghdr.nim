# Nimrod module for determining the type of image files.
# Ported from Python's imghdr module.

# Written by Adam Chesak.
# Released under the MIT open source license.


type TImageType* {.pure.} = enum
    PNG, JPEG, GIF, TIFF, RGB, PBM, PGM, PPM, BMP, XMB, CRW, CR2, SVG, MRW, X3F, WEBP, XCF,
    GKSM, PM, FITS, XPM, XPM2, PS, Xfig, IRIS, Rast, Other


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


proc testImage*(file : TFile): TImageType =
    ## Determines the format of the image file given. Possible values:
    ##
    ## - PNG format - TImageType.PNG
    ## - JPEG format (either JFIF or Exif) - TImageType.JPEG
    ## - GIF format - TImageType.GIF
    ## - TIFF format - TImageType.TIFF
    ## - SVG format - TImageType.SVG
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
    ## - Unknown format - TImageType.Other
    
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
    else:
        return TImageType.Other
