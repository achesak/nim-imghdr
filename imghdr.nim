# Nim module for determining the type of image files.
# Ported from Python's imghdr module.

# Written by Adam Chesak.
# Released under the MIT open source license.


## nim-imghdr is a Nim module for determining the type of image files.
##
## List of detectable formats:
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
## - PAM format - ImageType.PAM
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
## - YCC (Kodak YCC image) format - ImageType.YCC
## - FPX (FlashPix) format - ImageType.FPX
## - DCX (Graphics Multipage PCX bitmap) format - ImageType.DCX
## - ITC format - ImageType.ITC
## - NIFF (Navy Image File Format) format - ImageType.NIFF
## - WMP (Windows Media Photo) format - ImageType.WMP
## - BPG format - ImageType.BPG
## - FLIF format - ImageType.FLIF
## - PDF (Portable Document Format) format - ImageType.PDF
## - Unknown format - ImageType.Other


import os


proc int2ascii(i : seq[int8]): string =
    ## Converts a sequence of integers into a string containing all of the characters.
    
    let h = high(uint8).int + 1
    
    var s : string = ""
    for j, value in i:
        s = s & chr(value %% h)
    return s


proc `==`(i : seq[int8], s : string): bool =
    ## Operator for comparing a seq of ints with a string.
    
    return int2ascii(i) == s


type ImageType* {.pure.} = enum
    PNG, JPEG, GIF, TIFF, RGB, PBM, PGM, PPM, PAM, BMP, XMB, CRW, CR2, SVG, MRW, X3F, WEBP, XCF,
    GKSM, PM, FITS, XPM, XPM2, PS, Xfig, IRIS, Rast, SPIFF, GEM, Amiga, TIB, JB2, CIN, PSP,
    EXR, CALS, DPX, SYM, SDR, IMG, ADEX, NITF, BigTIFF, GX2, PAT, CPT, SYW, DWG, PSD, FBM,
    HDR, MP, DRW, Micrografx, PIC, VDI, ICO, JP2, YCC, FPX, DCX, ITC, NIFF, WMP, BPG, FLIF, PDF,
    Other


proc testImage*(data : seq[int8]): ImageType {.gcsafe.}


proc testPNG(value : seq[int8]): ImageType =
    # tests: "\211PNG\r\n"
    return if value[1..3] == "PNG" and value[4] == 13 and value[5] == 10: PNG else: Other


proc testJFIF(value : seq[int8]): ImageType =
    # tests: "JFIF"
    return if value[6..9] == "JFIF": JPEG else: Other


proc testEXIF(value : seq[int8]): ImageType =
    # tests: "Exif"
    return if value[6..9] == "Exif": JPEG else: Other


proc testGIF(value : seq[int8]): ImageType =
    # tests: "GIF87a" or "GIF89a"
    return if value[0..5] == "GIF87a" or value[0..5] == "GIF89a": GIF else: Other


proc testTIFF(value : seq[int8]): ImageType =
    # tests: "MM" or "II"
    return if value[0..1] == "MM" or value[0..1] == "II": TIFF else: Other


proc testRGB(value : seq[int8]): ImageType =
    # tests: "\001\332"
    return if value[0] == 1 and value[1] == 332: RGB else: Other


proc testPBM(value : seq[int8]): ImageType =
    # tests: "P[1,4][ \t\n\r]"
    return if len(value) >= 3 and value[0] == 80 and (value[1] == 49 or value[1] == 52) and (value[3] == 32 or value[3] == 9 or value[3] == 10 or value[3] == 13): PBM else: Other


proc testPGM(value : seq[int8]): ImageType =
    # tests: "P[2,5][ \t\n\r]"
    return if len(value) >= 3 and value[0] == 80 and (value[1] == 50 or value[1] == 53) and (value[3] == 32 or value[3] == 9 or value[3] == 10 or value[3] == 13): PGM else: Other


proc testPPM(value : seq[int8]): ImageType =
    # tests: "P[3,6][ \t\n\r]"
    return if len(value) >= 3 and value[0] == 80 and (value[1] == 51 or value[1] == 54) and (value[3] == 32 or value[3] == 9 or value[3] == 10 or value[3] == 13): PPM else: Other


proc testPAM(value : seq[int8]): ImageType =
    # tests: "P7"
    return if value[0..1] == "P7": PAM else: Other


proc testBMP(value : seq[int8]): ImageType =
    # tests: "BM"
    return if value[0..1] == "BM": BMP else: Other


proc testXMB(value : seq[int8]): ImageType =
    # tests: "#define "
    return if value[0..6] == "#define ": XMB else: Other


proc testRast(value : seq[int8]): ImageType =
    # tests: "\x59\xA6\x6A\x95"
    return if value[0] == 89 and value[1] == 166 and value[2] == 106 and value[3] == 149: Rast else: Other


proc testCRW(value : seq[int8]): ImageType =
    # tests: "II" and "HEAPCCDR"
    return if value[0..1] == "II" and value[6..12] == "HEAPCCDR": CRW else: Other


proc testCR2(value : seq[int8]): ImageType =
    # tests: ("II" or "MM") and "CR"
    return if (value[0..1] == "II" or value[0..1] == "MM") and value[8..9] == "CR": CR2 else: Other


proc testSVG(value : seq[int8]): ImageType =
    # tests: "<?xml" 
    # NOTE: this is a bad way of testing for an SVG, as it can easily fail (eg. extra whitespace before the xml definition)
    # TODO: write a better way. Might require changing from testing the first 32 bytes to testing everything, and using an
    # xml parser for ths one.
    return if value[0..4] == "<?xml": SVG else: Other


proc testMRW(value : seq[int8]): ImageType =
    # tests: " MRM"
    return if value[0..3] == " MRM": MRW else: Other


proc testX3F(value : seq[int8]): ImageType =
    # tests: "FOVb"
    return if value[0..3] == "FOVb": X3F else: Other


proc testWEBP(value : seq[int8]): ImageType =
    # tests: "RIFF" and "WEBP"
    return if value[0..3] == "RIFF" and value[8..11] == "WEBP": WEBP else: Other


proc testXCF(value : seq[int8]): ImageType =
    # tests: "gimp xcf"
    return if value[0..7] == "gimp xcf": XCF else: Other


proc testGKSM(value : seq[int8]): ImageType =
    # tests: "GKSM"
    return if value[0..3] == "GKSM": GKSM else: Other


proc testPM(value : seq[int8]): ImageType =
    # tests: "VIEW"
    return if value[0..3] == "VIEW": PM else: Other


proc testFITS(value : seq[int8]): ImageType =
    # tests: "SIMPLE"
    return if value[0..5] == "SIMPLE": FITS else: Other


proc testXPM(value : seq[int8]): ImageType =
    # tests: "/* XPM */"
    return if value[0..8] == "/* XPM */": XPM else: Other


proc testXPM2(value : seq[int8]): ImageType =
    # tests: "! XPM2"
    return if value[0..5] == "! XPM2": XPM2 else: Other


proc testPS(value : seq[int8]): ImageType =
    # tests: "%!"
    return if value[0..1] == "%!": PS else: Other


proc testXFIG(value : seq[int8]): ImageType =
    # tests: "#FIG"
    return if value[0..3] == "#FIG": XFIG else: Other


proc testIRIS(value : seq[int8]): ImageType =
    # tests: 01 da
    return if value[0] == 1 and value[1] == 218: IRIS else: Other


proc testSPIFF(value : seq[int8]): ImageType =
    # tests: "SPIFF"
    return if value[6..10] == "SPIFF": SPIFF else: Other


proc testGEM(value : seq[int8]): ImageType =
    # tests: EB 3C 90 2A
    return if value[0] == 235 and value[1] == 60 and value[2] == 144 and value[3] == 42: GEM else: Other


proc testAmiga(value : seq[int8]): ImageType =
    # tests: E3 10 00 01 00 00 00 00
    return if value[0] == 227 and value[1] == 16 and value[2] == 0 and value[3] == 1 and value[4] == 0 and value[5] == 0 and value[6] == 0 and value[7] == 0: Amiga else: Other


proc testTIB(value : seq[int8]): ImageType =
    # tests: "´nhd"
    return if value[0..3] == "´nhd": TIB else: Other


proc testJB2(value : seq[int8]): ImageType =
    # tests: 97 and "JB2"
    return if value[0] == 151 and value[1..3] == "JB2": JB2 else: Other


proc testCIN(value : seq[int8]): ImageType =
    # tests: 80 2A 5F D7
    return if value[0] == 128 and value[1] == 42 and value[2] == 95 and value[3] == 215: CIN else: Other


proc testPSP(value : seq[int8]): ImageType =
    # tests: "BK" and 00
    return if value[1..2] == "BK" and value[3] == 0: PSP else: Other


proc testEXR(value : seq[int8]): ImageType =
    # tests: "v/1" and 01
    return if value[0..2] == "v/1" and value[2] == 1: EXR else: Other


proc testCALS(value : seq[int8]): ImageType =
    # tests: "srcdocid:"
    return if value[0..8] == "srcdocid:": CALS else: Other


proc testDPX(value : seq[int8]): ImageType =
    # tests: "XPDS" or "SDPX"
    return if value[0..3] == "XPDS" or value[0..3] == "SDPX": DPX else: Other


proc testSYM(value : seq[int8]): ImageType =
    # tests: "Smbl"
    return if value[0..3] == "Smbl": SYM else: Other


proc testSDR(value : seq[int8]): ImageType =
    # tests: "SMARTDRW"
    return if value[0..7] == "SMARTDRW": SDR else: Other


proc testIMG(value : seq[int8]): ImageType =
    # tests: "SCMI"
    return if value[0..3] == "SCMI": IMG else: Other


proc testADEX(value : seq[int8]): ImageType =
    # tests: "PICT" and 00 08
    return if value[0..3] == "PICT" and value[4] == 0 and value[5] == 8: ADEX else: Other


proc testNITF(value : seq[int8]): ImageType =
    # tests: "NITF0"
    return if value[0..4] == "NITF0": NITF else: Other


proc testBigTIFF(value : seq[int8]): ImageType =
    # tests: "MM" and 00 2B
    return if value[0..1] == "MM" and value[2] == 0 and value[3] == 43: BigTIFF else: Other


proc testGX2(value : seq[int8]): ImageType =
    # tests: "GX2"
    return if value[0..2] == "GX2": GX2 else: Other


proc testPAT(value : seq[int8]): ImageType =
    # tests: "GPAT"
    return if value[0..3] == "GPAT": PAT else: Other


proc testCPT(value : seq[int8]): ImageType =
    # tests: "CPTFILE" or "CPT7FILE"
    return if value[0..6] == "CPTFILE" or value[0..7] == "CPT7FILE": CPT else: Other


proc testSYW(value : seq[int8]): ImageType =
    # tests: "AMYO"
    return if value[0..3] == "AMYO": SYW else: Other


proc testDWG(value : seq[int8]): ImageType =
    # tests: "AC10"
    return if value[0..3] == "AC10": DWG else: Other


proc testPSD(value : seq[int8]): ImageType =
    # tests: "8BPS"
    return if value[0..3] == "8BPS": PSD else: Other


proc testFBM(value : seq[int8]): ImageType =
    # tests: "%bitmap"
    return if value[0..6] == "%bitmap": FBM else: Other


proc testHDR(value : seq[int8]): ImageType =
    # tests: "#?RADIANCE"
    return if value[0..9] == "#?RADIANCE": HDR else: Other


proc testMP(value : seq[int8]): ImageType =
    # tests: 0C ED
    return if value[0] == 12 and value[1] == 237: MP else: Other


proc testDRW(value : seq[int8]): ImageType =
    # tests: 07
    return if value[0] == 7: DRW else: Other


proc testMicrografx(value : seq[int8]): ImageType =
    # tests: 01 FF 02 04 03 02
    return if value[0] == 1 and value[1] == 255 and value[2] == 2 and value[3] == 4 and value[4] == 3 and value[5] == 2: Micrografx else: Other


proc testPIC(value : seq[int8]): ImageType =
    # tests: 01 00 00 00 01
    return if value[0] == 1 and value[1] == 0 and value[2] == 0 and value[3] == 0 and value[4] == 1: PIC else: Other


proc testVDI(value : seq[int8]): ImageType =
    # tests: 00 01 00 08 00 01 00 01 01
    return if value[0] == 0 and value[1] == 1 and value[2] == 0 and value[3] == 8 and value[4] == 0 and value[5] == 1 and value[6] == 0 and
        value[7] == 1 and value[8] == 1: VDI else: Other


proc testICO(value : seq[int8]): ImageType =
    # tests: 00 00 01 00
    return if value[0] == 0 and value[1] == 0 and value[2] == 1 and value[3] == 0: ICO else: Other


proc testJP2(value : seq[int8]): ImageType =
    # tests: 00 00 00 0C and "jP"
    return if value[0] == 0 and value[1] == 0 and value[2] == 0 and value[3] == 12 and value[4..5] == "jP": JP2 else: Other


proc testYCC(value : seq[int8]): ImageType =
    # tests: 59 65 60 00
    return if value[0] == 59 and value[1] == 65 and value[2] == 60 and value[3] == 0: YCC else: Other


proc testFPX(value : seq[int8]): ImageType =
    # tests: 71 B2 39 F4
    return if value[0] == 113 and value[1] == 178 and value[2] == 57 and value[3] == 244: FPX else: Other


proc testDCX(value : seq[int8]): ImageType =
    # tests: B1 68 DE 3A
    return if value[0] == 177 and value[1] == 104 and value[2] == 222 and value[3] == 58: DCX else: Other


proc testITC(value : seq[int8]): ImageType =
    # tests: F1 00 40 BB
    return if value[0] == 241 and value[1] == 0 and value[2] == 64 and value[3] == 187: ITC else: Other


proc testNIFF(value : seq[int8]): ImageType =
    # tests: "IIN1"
    return if value[0..3] == "IIN1": NIFF else: Other


proc testWMP(value : seq[int8]): ImageType =
    # tests: "II" and BC
    return if value[0..1] == "II" and value[2] == 188: WMP else: Other

    
proc testBPG(value : seq[int8]): ImageType =
    # tests: "BPG" and FB
    return if value[0..2] == "BPG" and value[3] == 251: BPG else: Other


proc testFLIF(value : seq[int8]): ImageType =
    # tests: "FLIF"
    return if value[0..3] == "FLIF": FLIF else: Other


proc testPDF(value: seq[int8]): ImageType =
    # tests: "%PDF"
    return if value[0..3] == "%PDF": PDF else: Other


proc testImage*(file : File): ImageType {.gcsafe.} =
    ## Determines the format of the image file given.
    
    var data = newSeq[int8](32)
    discard file.readBytes(data, 0, 32)
    return testImage(data)


proc testImage*(filename : string): ImageType {.gcsafe.} =
    ## Determines the format of the image with the specified filename.
    
    var file : File = open(filename)
    var format : ImageType = testImage(file)
    file.close()
    return format


proc testImage*(data : seq[int8]): ImageType =
    ## Determines the format of the image from the bytes given.
    
    let testers = @[testPNG, testJFIF, testEXIF, testGIF, testTIFF, testRGB, testPBM,
        testPGM, testPPM, testPAM, testBMP, testXMB, testRast, testCRW, testCR2,
        testSVG, testMRW, testX3F, testWEBP, testXCF, testGKSM, testPM, testFITS,
        testXPM, testXPM2, testPS, testXFIG, testIRIS, testSPIFF, testGEM, testAmiga,
        testTIB, testJB2, testCIN, testPSP, testEXR, testCALS, testDPX, testSYM,
        testSDR, testIMG, testADEX, testNITF, testBigTIFF, testGX2, testPAT, testCPT,
        testSYW, testDWG, testPSD, testFBM, testHDR, testMP, testDRW, testMicrografx,
        testPIC, testVDI, testICO, testJP2, testYCC, testFPX, testDCX, testITC,
        testNIFF, testWMP, testBPG, testFLIF, testPDF
    ]
    
    for tester in testers:
        if tester(data) != Other:
            return tester(data)
    return Other


# When run as it's own program, determine the type of the provided image file:
when isMainModule:
    
    if paramCount() < 1:
        echo("Invalid number of parameters. Usage:\nimghdr [filename1] [filename2] ...")
    
    for i in 1..paramCount():
        echo("Detected file type for \"" & paramStr(i) & "\": " & $testImage(paramStr(i)))
