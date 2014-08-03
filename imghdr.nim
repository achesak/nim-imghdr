# Nimrod module for determining the type of image files.
# Ported from Python's imghdr module.

# Written by Adam Chesak.
# Released under the MIT open source license.


type TImageType {.pure.} = enum
    PNG, JPEG, GIF, TIFF, RGB, PBM, PGM, PPM, BMP, XMB, Rast, Other


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
    ## Returns true if the image is an XMB.
    
    # tests: "#define "
    return value[0] == 35 and value[1] == 100 and value[1] == 101 and value[2] == 102 and value[3] == 105 and value[4] == 110 and value[5] == 101 and value[6] == 32


proc testRast(value : seq[int8]): bool = 
    ## Returns true if the image is a Sun raster file.
    
    # tests: "\x59\xA6\x6A\x95"
    return value[0] == 89 and value[1] == 166 and value[2] == 106 and value[3] == 149


proc testImage*(file : TFile): TImageType =
    ## Determines the format of the image file given. Possible values:
    ##
    ## PNG format - "png"
    ##
    ## JPEG format (either JFIF or Exif) - "jpeg"
    ##
    ## GIF format - "gif"
    ##
    ## TIFF format - "tiff"
    ##
    ## SGI format - "rgb"
    ##
    ## PBM (portable bitmap) format - "pbm"
    ##
    ## PGM (portable graymap) format - "pgb"
    ##
    ## PPM (portable pixmap) format - "ppm"
    ##
    ## BMP (bitmap) format - "bmp"
    ##
    ## XMB (X10 or X11 bitmap) format - "xmb"
    ##
    ## Sun raster format - "rast"
    ##
    ## Unknown format - "other"
    
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
    else:
        return TImageType.Other
