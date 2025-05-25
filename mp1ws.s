.n64

.open "mp1.z64", "mp1_temprom.z64", 0

SCREEN_W equ 416
SCREEN_W_FLOAT equ 416.0
SCREEN_H equ 240
CFB_ADDR equ 0x80400000
ZBUF_ADDR equ 0x80700000
BG_TILE_CNT_X equ (((SCREEN_W+63)/64)+1)
BG_TILE_CNT equ (12*6)

BG_MSGQ1_ADDR equ (ZBUF_ADDR+(SCREEN_W*SCREEN_H*2))
BG_MSGQ2_ADDR equ (BG_MSGQ1_ADDR+(4*BG_TILE_CNT))
BG_MSGQ3_ADDR equ (BG_MSGQ2_ADDR+(4*BG_TILE_CNT))
BG_TILEINFO_ADDR equ (BG_MSGQ3_ADDR+(4*BG_TILE_CNT))
BG_TILEINFO_LIST_ADDR equ (BG_TILEINFO_ADDR+(20*BG_TILE_CNT))


.headersize 0x80000400-0x1000 //Main Segment

.org 0x8001A380
lui a2, 0x8033 //Move Audio Heap

.org 0x8001A400
lui a1, hi(ZBUF_ADDR) //High Part of Z Buffer Address

.org 0x8001A408
addiu a1, a1, lo(ZBUF_ADDR) //Low Part of Z Buffer Address

.org 0x8001D5F0
li.u a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l a3, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x8001DA88
li.u at, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l at, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x8001DAC4
li.u at, (SCREEN_W_FLOAT/2) //Scale for 3D to 2D Conversions

.org 0x8001DDEC
li.u at, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l at, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x8001DE04
li.u at, SCREEN_W_FLOAT //Scale for 2D to 3D Conversions

.org 0x800252FC
li s0, ((SCREEN_W << 14)|(SCREEN_H << 2)) //Fix Fade Scissor

.org 0x800256C0
ori v1, v1, (SCREEN_W-1) //Width of Framebuffer

.org 0x8003B368
lui a1, 0x1F //Expand Heap

.org 0x8003DF30
li.u at, (SCREEN_W_FLOAT+50) //Fix Maximum X Position for 3D Models in Boards

.org 0x80042A2C
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Player Images

.org 0x80042D1C
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Minigame List

.org 0x800433FC
addiu a2, a2, ((SCREEN_W/2)-110) //Fix X Position of Minigame List Cursor

.org 0x80045C2C
addiu a0, r0, (SCREEN_W/2) //Fix X Position of Board Help Window

.org 0x80046D1C
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Game Over Text

.org 0x8004736C
li.u at, ((SCREEN_W_FLOAT/2)-80) //Fix X Position of Minigame Type Sign

.org 0x80047378
c.le.s f0, f2 //Alter Comparison
lui a0, 0x800D //Load Constant Ahead of Time

.org 0x800473A0
swc1 f2, 0x18(s0) //Reset X Position of Minigame Type Sign
sw v0, 0x64FC(a0) //Alter Replaced Operation

.org 0x80047AD4
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Player Start Text

.org 0x80047CB4
li.u at, (SCREEN_W_FLOAT+64) //Fix X Position of Minigame Type Sign

.org 0x8004836C
li.u at, (SCREEN_W_FLOAT*4) //Fix Toad Viewport Width

.org 0x800483DC
li.u at, (SCREEN_W_FLOAT*2) //Fix Toad Viewport Offset

.org 0x80048440
addiu a0, r0, ((SCREEN_W/2)-85) //Fix X Position of Toad Window

.org 0x80048528
addiu a1, r0, ((SCREEN_W/2)-85) //Fix X Position of Toad Window

.org 0x800487B8
li.u at, ((SCREEN_W_FLOAT/2)+128) //Fix X Position of Bowser Event List

.org 0x800492D0
addiu a2, a2, ((SCREEN_W/2)-110) //Fix X Position of Bowser Event Cursor

.org 0x80049DDC
addiu a0, r0, ((SCREEN_W/2)-37) //Fix X Position of Stop Roulette Window

.org 0x8004A1CC
li.u at, (SCREEN_W_FLOAT/2) //Fix Camera Right Boundary Offset

.org 0x8004A218
li.u at, (SCREEN_W_FLOAT/2) //Fix Camera Left Boundary Offset

.org 0x8004A42C
la a1, BG_MSGQ1_ADDR //Fix First Message Queue Address

.org 0x8004A438
addiu a2, r0, BG_TILE_CNT //Fix Number of Background Tiles

.org 0x8004A444
la a1, BG_MSGQ2_ADDR //Fix Second Message Queue Address

.org 0x8004A450
addiu a2, r0, BG_TILE_CNT //Fix Number of Background Tiles

.org 0x8004A45C
la a1, BG_MSGQ3_ADDR //Fix Third Message Queue Address

.org 0x8004A468
addiu a2, r0, BG_TILE_CNT //Fix Number of Background Tiles

.org 0x8004A630
li s2, BG_TILEINFO_ADDR //Fix Tileinfo Address

.org 0x8004A660
slti v0, s0, BG_TILE_CNT //Fix Iterating over Tileinfo

.org 0x8004A698
li s0, BG_TILEINFO_ADDR //Fix Tileinfo Address

.org 0x8004A6C4
slti v0, s1, BG_TILE_CNT //Fix Iterating over Tileinfo

.org 0x8004A6D0
li a0, BG_TILEINFO_LIST_ADDR //Move Tileinfo List

.org 0x8004A6DC
addiu a1, r0, ((((SCREEN_W+127)/64)*6)*4) //Move Tileinfo List

.org 0x8004A6F8
li v1, BG_TILEINFO_ADDR //Move Tileinfo List

.org 0x8004A728
slti v0, a0, BG_TILE_CNT //Fix Iterating over Tileinfo

.org 0x8004A750
li s0, BG_TILEINFO_ADDR //Move Tileinfo List

.org 0x8004A780
slti v0, s1, BG_TILE_CNT //Fix Iterating over Tileinfo

.org 0x8004A8A4
li v1, BG_TILEINFO_ADDR //Move Tileinfo List

.org 0x8004A8E0
slti v0, a1, BG_TILE_CNT //Fix Tile Num,ber

.org 0x8004A9AC
li s6, BG_TILEINFO_LIST_ADDR //Move Tileinfo List

.org 0x8004A9C8
addiu v0, v1, -(SCREEN_W/2) //Fix Board BG Tile Load Offset

.org 0x8004A9D0
addiu v0, v1, ((-(SCREEN_W/2))+63) //Fix Board BG Tile Load Offset

.org 0x8004AA24
sll v0, v0, 4 //Fix Pitch of Board BG Tile Load

.org 0x8004AA50
sll v1, v1, 4 //Fix Pitch of Board BG Tile Load

.org 0x8004AA64
slti v0, s0, ((SCREEN_W+127)/64) //Fix Number of Board BG Tiles to Load

.org 0x8004ADD4
addiu a0, v1, -(SCREEN_W/2) //Fix Board BG Tile Load Offset

.org 0x8004ADE0
addiu v0, v1, ((-(SCREEN_W/2))+63) //Fix Board BG Tile Load Offset

.org 0x8004AF20
li s5, BG_TILEINFO_LIST_ADDR //Move Tileinfo List

.org 0x8004AF5C
sll v0, v0, 4 //Fix Pitch of Board BG Tile Load

.org 0x8004AFA0
slti v0, v0, ((SCREEN_W+127)/64) //Fix Number of Board BG Tiles to Render

.org 0x8004B0B4
li.u at, (SCREEN_W_FLOAT*2) //Fix Camera Viewport Size

.org 0x8004B108
li.u at, ((SCREEN_W_FLOAT/2)-0.5) //Fix Viewport X Offset
li.l at, ((SCREEN_W_FLOAT/2)-0.5) //Fix Viewport X Offset

.org 0x8004B23C
li.u at, (SCREEN_W_FLOAT/2) //Fix Camera Scissor Offset

.org 0x8004B24C
li.u at, (SCREEN_W_FLOAT*2) //Fix Camera Viewport Offset

.org 0x8004B560
addiu a0, a0, (SCREEN_W/2) //Fix Camera Background Offset

.org 0x8004B640
li.u at, (SCREEN_W_FLOAT/2) //Fix Camera Coordinate Offset

.org 0x8004B698
li.u at, (SCREEN_W_FLOAT/2) //Fix Camera Coordinate Offset

.org 0x8004B6F4
li.u at, (SCREEN_W_FLOAT/2) //Fix Camera Coordinate Offset

.org 0x8004B758
li.u at, (SCREEN_W_FLOAT/2) //Fix Camera 2D Offset

.org 0x800502E0
addiu a2, r0, (SCREEN_W/2) //Fix Title Screen Background X Position

.org 0x80050840
addiu a2, r0, (SCREEN_W/2) //Fix Pause Play Mode X Position

.org 0x800508DC
addiu a2, r0, ((SCREEN_W/2)-20) //Fix Pause Turn Text X Position

.org 0x80050968
addiu a3, r0, ((SCREEN_W/2)+42) //Fix Pause Turn Number X Position

.org 0x80050994
addiu a3, r0, ((SCREEN_W/2)+13) //Fix Pause Turn Number X Position

.org 0x800509D0
addiu a3, r0, ((SCREEN_W/2)+22) //Fix Pause Max Turn Number X Position

.org 0x80050A40
addiu a2, r0, (SCREEN_W/2) //Fix Pause Board Logo X Position

.org 0x80050EB8
addiu a0, r0, ((SCREEN_W/2)-50) //Fix X Position of Main Pause Menu

.org 0x800511C8
addiu a0, r0, ((SCREEN_W/2)-70) //Fix X Position of Minigame Pause Menu

.org 0x80051324
addiu a0, r0, ((SCREEN_W/2)-55) //Fix X Position of Save Pause Menu

.org 0x80051454
addiu a0, r0, ((SCREEN_W/2)-25) //Fix X Position of Message Speed Pause Menu

.org 0x8005156C
addiu a0, r0, ((SCREEN_W/2)-65) //Fix X Position of Quit Pause Menu

.org 0x80052868
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Pause Filter

.org 0x80052878
li.u a2, (SCREEN_W_FLOAT/8) //Fix X Scale of Pause Filter

.org 0x800530B0
li.u at, (SCREEN_W_FLOAT-16) //Fix Board Camera Right Border

.org 0x80053114
li.u at, (SCREEN_W_FLOAT-16) //Fix Board Camera Right Border

.org 0x800551BC
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Minigame VS Sprite

.org 0x800551E8
li.u at, (SCREEN_W_FLOAT/2) //Fix X Position of Minigame VS Sprite

.org 0x80055F2C
addiu a2, r0, (SCREEN_W/2) //Fix X Position of World Text

.org 0x80055F5C
addiu a2, r0, (SCREEN_W/2) //Fix X Position of World Dash

.org 0x80056018
addiu a2, r0, ((SCREEN_W/2)-16) //Fix X Position of World Number

.org 0x80056430
addiu a2, r0, (SCREEN_W-94) //Fix X Position of Minigame Island Coin

.org 0x80056480
addiu a2, r0, (SCREEN_W-68) //Fix X Position of Minigame Island Coin X

.org 0x8005653C
addiu a2, r0, (SCREEN_W-52) //Fix X Position of Minigame Island Coin Number

.org 0x80057390
addiu a0, r0, ((SCREEN_W/2)-72) //Fix X Position of Save Window

.org 0x8005762C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Poison Mushroom Sick Window

.org 0x80057BFC
addiu a0, r0, ((SCREEN_W/2)-104) //Fix X Position of Hidden Block Window

.org 0x80057F14
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Poison Mushroom Window

.org 0x80059C3C
addiu a0, r0, ((SCREEN_W/2)-96) //Fix X Position of Menu Window

.org 0x8005A550
addiu a2, r0, (SCREEN_W/2) //Fix Width of Pause Screen Window 2

.org 0x8005A580
addiu a0, r0, (SCREEN_W/2) //Fix X Position of Pause Screen Window 2

.org 0x8005A588
addiu a2, r0, (SCREEN_W/2) //Fix Width of Pause Screen Window 2

.org 0x8005A5B0
addiu a0, r0, SCREEN_W //Fix X Position of Pause Screen Window 3

.org 0x8005A5B8
addiu a2, r0, SCREEN_W //Fix Width of Pause Screen Window 3

.org 0x8005A5E0
addiu a0, r0, SCREEN_W //Fix X Position of Pause Screen Window 4

.org 0x8005A5E8
addiu a2, r0, SCREEN_W //Fix Width of Pause Screen Window 4

.org 0x8005A66C
addiu a2, r0, ((SCREEN_W/2)-28) //Fix X Position of Item Text on Pause Screen

.org 0x8005A804
addiu a2, r0, ((SCREEN_W/2)+32) //Fix X Position of Played Text on Pause Screen

.org 0x8005A834
addiu a2, r0, ((SCREEN_W/2)+104) //Fix X Position of Stars Text on Pause Screen

.org 0x8005A860
addiu a2, r0, ((SCREEN_W/2)-50) //Fix X Position of Current Standings Text on Pause Screen

.org 0x8005A8EC
addiu a2, r0, ((SCREEN_W/2)-66) //Fix X Position of Board Names on Pause Screen

.org 0x8005A9A4
la a1, pauseRecordMes //Fix Address of Pause Record Message

.org 0x8005A9AC
addiu a2, r0, ((SCREEN_W/2)+12) //Fix Initial X Position of Pause Record Message

.org 0x8005AAD4
addiu v0, r0, (SCREEN_W/16) //Fix X Speed Of Pause Screen Window Right Move

.org 0x8005AB04
addiu v0, r0, -(SCREEN_W/16) //Fix X Speed Of Pause Screen Window Right Move

.org 0x8005AB4C
slti v0, v0, (SCREEN_W+1) //Fix Max X Position of Pause Screen Windows

.org 0x8005AB58
addiu v0, v1, -(SCREEN_W*2) //Fix X Right Move of Pause Screen Windows

.org 0x8005AB68
slti v0, v0, (-SCREEN_W+1) //Fix Max X Position of Pause Screen Windows

.org 0x8005AB70
addiu v0, v1, (SCREEN_W*2) //Fix X Right Move of Pause Screen Windows

.org 0x8005AD34
addiu a0, r0, ((SCREEN_W/2)-91) //Fix X Position of No Controller Window

.org 0x8005ADF4
addiu a2, r0, (SCREEN_W/2) //Fix X Position of No Controller Text

.org 0x8005B9B8
addiu a0, r0, ((SCREEN_W/2)-65) //Fix X Position of Minigame Island Enter Window

.org 0x8005BAE4
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of Minigame Island Window

.org 0x8005E6AC
lui a1, hi(ZBUF_ADDR) //High Part of Z Buffer Address

.org 0x8005E6B4
addiu a1, a1, lo(ZBUF_ADDR) //Low Part of Z Buffer Address

.org 0x8005F010
addiu a0, r0, ((SCREEN_W/2)-35) //Fix X Position of Pause Shadow in Debug Pause Menu

.org 0x8005F030
addiu a0, r0, ((SCREEN_W/2)-36) //Fix X Position of Pause Shadow in Debug Pause Menu

.org 0x8005F094
addiu a0, r0, ((SCREEN_W/2)-28) //Fix X Position of Pause Text in Debug Pause Menu

.org 0x8005F0E4
addiu a0, r0, ((SCREEN_W/2)-28) //Fix X Position of Pause Text in Debug Pause Menu

.org 0x8005F128
addiu a0, r0, ((SCREEN_W/2)-28) //Fix X Position of Pause Text in Debug Pause Menu

.org 0x8005F188
addiu a0, r0, ((SCREEN_W/2)-28) //Fix X Position of Pause Text in Debug Pause Menu

.org 0x8005F1D8
addiu a0, r0, ((SCREEN_W/2)-28) //Fix X Position of Pause Text in Debug Pause Menu

.org 0x8005F924
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Black Window in Debug Pause Menu

.org 0x8005F92C
addiu a2, r0, ((SCREEN_W/2)+48) //Fix X Position of Black Window in Debug Pause Menu

.org 0x8005F948
addiu a0, r0, ((SCREEN_W/2)-44) //Fix X Position of Blue Window in Debug Pause Menu

.org 0x8005F950
addiu a2, r0, ((SCREEN_W/2)+44) //Fix X Position of Blue Window in Debug Pause Menu

.org 0x800625B4
li v0, (((SCREEN_W-1) << 14)|(339 << 2)) //Fix FB End Scissor

.org 0x80062B04
li v0, (0xF6000000|((SCREEN_W-24) << 14)|(16 << 2)) //Fix Safety Frame Top Line

.org 0x80062B24
li a0, (0xF6000000|((SCREEN_W-24) << 14)|(224 << 2)) //Fix Safety Frame Bottom Line

.org 0x80062B60
li v0, (((SCREEN_W-24) << 14)|(16 << 2)) //Fix Safety Frame Right Line

.org 0x80062B7C
li v0, (((SCREEN_W-1) << 14)|(339 << 2)) //Fix FB End Scissor

.org 0x80062F4C
sltiu v0, v0, SCREEN_W //Fix Maximum Debug Print X Position

.org 0x80064C28
li.u a1, -(SCREEN_W_FLOAT/2) //Sprite Ortho Left Edge
li.u a2, (SCREEN_W_FLOAT/2) //Sprite Ortho Right Edge

.org 0x80066854
li v0, (SCREEN_W << 14)|(SCREEN_H << 2) //Fix Sprite Scissor

.org 0x80066BEC
li v0, (SCREEN_W << 14)|(SCREEN_H << 2) //Fix Sprite Scissor

.org 0x80068460
li.u s3, SCREEN_W_FLOAT //Fix Maximum Left Sprite X Position
li.l s3, SCREEN_W_FLOAT //Fix Maximum Left Sprite X Position

.org 0x8006A004
addiu a1, a1, -(SCREEN_W/2) //Fix Rotating Sprite Offset

.org 0x800729B4
li v0, (0xF6000000|(SCREEN_W << 14)|(SCREEN_H << 2)) //Fix Color Fades

.org 0x800742BC
li v0, ((SCREEN_W << 14)|(SCREEN_H << 2)) //Fix Scissor for Image Fades

.org 0x800745BC
li.u at, (SCREEN_W_FLOAT/2) //Fix X Position of Image Fades

.org 0x80074ACC
lui v1, (0xF600|(SCREEN_W >> 2)) //Fix Right Edge of Image Fades

.org 0x80074AFC
li v0, (0xF6000000|(SCREEN_W << 14)|(SCREEN_H << 2)) //Fix Bottom-Right Edge of Image Fades

.org 0x80074BA0
slti v0, a1, SCREEN_W //Fix Right Edge of Image Fades

.org 0x80074BA8
lui v1, (0xF600|(SCREEN_W >> 2)) //Fix Right Edge of Image Fades

.org 0x80075D7C
li.u at, (SCREEN_W_FLOAT/2) //Fix Default X Position of Game Messages

.org 0x80075F1C
li.u at, (SCREEN_W_FLOAT/2) //Fix Default X Position of Top Timers

.org 0x80076448
addiu a2, r0, ((SCREEN_W/2)-77) //Fix X Position of Start Text

.org 0x800775F0
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Time Up Text

.org 0x80077778
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Time Up Sprite

.org 0x8007796C
li.u at, SCREEN_W_FLOAT //Fix Screen Width for 1P Win

.org 0x80077A2C
li.u at, SCREEN_W_FLOAT //Fix Screen Width for 1P Win

.org 0x80078108
li.u at, SCREEN_W_FLOAT //Fix Screen Width for 1P Lose

.org 0x8007A2E0
addiu a2, r0, ((SCREEN_W/2)+128) //Fix X Position of 2-Player Win Player 1

.org 0x8007A308
addiu a2, r0, ((SCREEN_W/2)-128) //Fix X Position of 2-Player Win Player 2

.org 0x8007A340
addiu a2, r0, (SCREEN_W/2) //Fix X Position of 2-Player Win Win Text

.org 0x8007A3EC
li.u at, ((SCREEN_W_FLOAT/2)-128) //Fix X Position of Player 1 Winner Name

.org 0x8007A3FC
li.u at, SCREEN_W_FLOAT //Fix Screen Width for 2-Player Win Text

.org 0x8007A4E0
li.u at, ((SCREEN_W_FLOAT/2)-128) //Fix X Position of Player 1 Winner Name

.org 0x8007ABFC
addiu a2, r0, ((SCREEN_W/2)+128) //Fix X Position of 3-Player Win Player 1

.org 0x8007AC34
addiu a2, r0, (SCREEN_W/2) //Fix X Position of 3-Player Win Player 2

.org 0x8007AC5C
addiu a2, r0, ((SCREEN_W/2)-128) //Fix X Position of 3-Player Win Player 3

.org 0x8007AC88
addiu a2, r0, (SCREEN_W/2) //Fix X Position of 3-Player Win Player 2

.org 0x8007AD20
li.u at, SCREEN_W_FLOAT //Fix Screen Width for 3-Player Win Text

.org 0x8007AD3C
addiu a2, a2, -((SCREEN_W/2)-160) //Fix P1 Name Offset

.org 0x8007AD6C
nop //Disable Sign Extension Part 2

.org 0x8007AEBC
addiu a2, a2, ((SCREEN_W/2)-160) //Fix P3 Name Offset

.org 0x8007AEDC
nop //Disable Sign Extension Part 2

.org 0x8007B5A4
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Pause Menu Window 1

.org 0x8007B604
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Pause Menu Window 2

.org 0x8007BA70
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Pause Menu Pause Text

.org 0x800C3114
.float SCREEN_W_FLOAT*2 //Fix Viewport Setup 1 Scale

.org 0x800C3120
.float SCREEN_W_FLOAT //Fix Viewport Setup 5 Scale

.org 0x800C312C
.float SCREEN_W_FLOAT //Fix Viewport Setup 3 Scale

.org 0x800C3138
.float SCREEN_W_FLOAT //Fix Viewport Setup 4 Scale

.org 0x800C3144
.float SCREEN_W_FLOAT //Fix Viewport Setup 5 Scale

.org 0x800C3150
.float SCREEN_W_FLOAT*2 //Fix Viewport Setup 1 Translation

.org 0x800C315C
.float SCREEN_W_FLOAT //Fix Viewport Setup 2 Translation

.org 0x800C3168
.float SCREEN_W_FLOAT*3 //Fix Viewport Setup 3 Translation

.org 0x800C3174
.float SCREEN_W_FLOAT //Fix Viewport Setup 4 Translation

.org 0x800C3180
.float SCREEN_W_FLOAT //Fix Viewport Setup 5 Translation

.org 0x800C3194
.float SCREEN_W_FLOAT //Fix Viewport 1 Scissor Width

.org 0x800C31A4
.float SCREEN_W_FLOAT/2 //Fix Viewport 2 Scissor Width

.org 0x800C31AC
.float SCREEN_W_FLOAT/2 //Fix Viewport 3 Scissor X Position

.org 0x800C31B4
.float SCREEN_W_FLOAT //Fix Viewport 3 Scissor Width

.org 0x800C31C4
.float SCREEN_W_FLOAT/2 //Fix Viewport 4 Scissor Width

.org 0x800C31CC
.float SCREEN_W_FLOAT/2 //Fix Viewport 5 Scissor X Position

.org 0x800C31D4
.float SCREEN_W_FLOAT //Fix Viewport 5 Scissor Width

.org 0x800C3450
.dw (0xF6000000|((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Upper Half of Z Clear Command

.org 0x800C3478
.dw (0xF6000000|((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Upper Half of Clear Command

.org 0x800C4250
.dw CFB_ADDR //CFB1 Address
.dw (CFB_ADDR+(SCREEN_W*SCREEN_H*2)) //CFB2 Address
.dw (CFB_ADDR+((SCREEN_W*SCREEN_H*2)*2)) //CFB3 Address

.org 0x800C430C
.dh ((SCREEN_W/2)-94) //Fix X Position of P1 on Map
.dh ((SCREEN_W/2)+94) //Fix X Position of P2 on Map
.dh ((SCREEN_W/2)-94) //Fix X Position of P3 on Map
.dh ((SCREEN_W/2)+94) //Fix X Position of P4 on Map

.org 0x800C4D40
.dh ((SCREEN_W/2)-100) //Fix X Position of 3-Entry List Element 1

.org 0x800C4D48
.dh ((SCREEN_W/2)-100) //Fix X Position of 3-Entry List Element 2

.org 0x800C4D50
.dh ((SCREEN_W/2)-100) //Fix X Position of 3-Entry List Element 3

.org 0x800C4D58
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 1

.org 0x800C4D60
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 2

.org 0x800C4D68
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 3

.org 0x800C4D70
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 4

.org 0x800C4D78
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 5

.org 0x800C4D80
.dh ((SCREEN_W/2)-100) //Fix X Position of 3-Entry List Element 1

.org 0x800C4D88
.dh ((SCREEN_W/2)-100) //Fix X Position of 3-Entry List Element 2

.org 0x800C4D90
.dh ((SCREEN_W/2)-100) //Fix X Position of 3-Entry List Element 3

.org 0x800C4D98
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 1

.org 0x800C4DA0
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 2

.org 0x800C4DA8
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 3

.org 0x800C4DB0
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 4

.org 0x800C4DB8
.dh ((SCREEN_W/2)-100) //Fix X Position of 5-Entry List Element 5

.org 0x800C4EF8
.dh ((SCREEN_W/2)-80) //Fix X Position of Last in Last Turns

.org 0x800C4EFC
.dh ((SCREEN_W/2)+80) //Fix X Position of Turns in Last Turns

.org 0x800C4F00
.dh ((SCREEN_W/2)-5) //Fix X Position of Number in Last Turns

.org 0x800C4F04
.dh ((SCREEN_W/2)-56) //Fix X Position of Last in Last Turn

.org 0x800C4F08
.dh ((SCREEN_W/2)+56) //Fix X Position of Turn in Last Turn

.org 0x800C4F0C
.dh (SCREEN_W*2) //Fix X Position of Number in Last Turn

.org 0x800C4F14
.dh (SCREEN_W+32) //Fix X Position of Bowser Roulette Row 1

.org 0x800C4F1C
.dh (SCREEN_W+32) //Fix X Position of Bowser Roulette Row 2

.org 0x800C4F24
.dh (SCREEN_W+32) //Fix X Position of Bowser Roulette Row 3

.org 0x800C4F2C
.dh (SCREEN_W+32) //Fix X Position of Bowser Roulette Row 4

.org 0x800C4F34
.dh (SCREEN_W+32) //Fix X Position of Bowser Roulette Row 5

.org 0x800C53AC
.dh ((SCREEN_W/2)-60) //Fix Player 1 Pause Configuration X Position
.dh ((SCREEN_W/2)+60) //Fix Player 2 Pause Configuration X Position
.dh ((SCREEN_W/2)-60) //Fix Player 3 Pause Configuration X Position
.dh ((SCREEN_W/2)+60) //Fix Player 4 Pause Configuration X Position

.org 0x800C54DC
.dh (SCREEN_W-120) //Fix X Position of P2 In HUD

.org 0x800C54E4
.dh (SCREEN_W-120) //Fix X Position of P4 In HUD

.org 0x800C54EC
.dh (SCREEN_W+96) //Fix X Position of P2 In HUD

.org 0x800C54F4
.dh (SCREEN_W+96) //Fix X Position of P4 Out HUD

.org 0x800C54F8
.dh ((SCREEN_W/2)-100) //Fix X Position of P1 HUD in Minigame Setup Start

.org 0x800C54FC
.dh ((SCREEN_W/2)+4) //Fix X Position of P2 HUD in Minigame Setup Start

.org 0x800C5500
.dh ((SCREEN_W/2)-100) //Fix X Position of P3 HUD in Minigame Setup Start

.org 0x800C5504
.dh ((SCREEN_W/2)+4) //Fix X Position of P4 HUD in Minigame Setup Start

.org 0x800C5508
.dh ((SCREEN_W/2)-48) //Fix X Position of P1 1P Minigame Center HUD

.org 0x800C550C
.dh (SCREEN_W+96) //Fix X Position of P1 1P Minigame Right Out HUD

.org 0x800C551C
.dh ((SCREEN_W/2)-48) //Fix X Position of P2 1P Minigame Center HUD

.org 0x800C5524
.dh (SCREEN_W+96) //Fix X Position of P2 1P Minigame Right Out HUD

.org 0x800C552C
.dh (SCREEN_W+96) //Fix X Position of P3 1P Minigame Right Out HUD

.org 0x800C5530
.dh ((SCREEN_W/2)-48) //Fix X Position of P3 1P Minigame Center HUD

.org 0x800C553C
.dh (SCREEN_W+96) //Fix X Position of P4 1P Minigame Right Out HUD

.org 0x800C5544
.dh ((SCREEN_W/2)-48) //Fix X Position of P4 1P Minigame Center HUD

.org 0x800C5548
.dh (SCREEN_W+192) //Fix X Position of P1 Out Column HUD

.org 0x800C554C
.dh (SCREEN_W+192) //Fix X Position of P2 Out Column HUD

.org 0x800C5550
.dh (SCREEN_W+192) //Fix X Position of P3 Out Column HUD

.org 0x800C5554
.dh (SCREEN_W+192) //Fix X Position of P4 Out Column HUD

.org 0x800C5558
.dh ((SCREEN_W/2)+40) //Fix X Position of P1 In Column HUD

.org 0x800C555C
.dh ((SCREEN_W/2)+40) //Fix X Position of P2 In Column HUD

.org 0x800C5560
.dh ((SCREEN_W/2)+40) //Fix X Position of P3 In Column HUD

.org 0x800C5564
.dh ((SCREEN_W/2)+40) //Fix X Position of P4 In Column HUD

.org 0x800C5568
.dh ((SCREEN_W/2)-120) //Fix X Position of P1 No Game HUD

.org 0x800C556C
.dh ((SCREEN_W/2)+24) //Fix X Position of P2 No Game HUD

.org 0x800C5570
.dh ((SCREEN_W/2)-120) //Fix X Position of P3 No Game HUD

.org 0x800C5574
.dh ((SCREEN_W/2)+24) //Fix X Position of P4 No Game HUD

.org 0x800C5578
.dh ((SCREEN_W/2)-120) //Fix X Position of P1 4-Player Minigame HUD

.org 0x800C557C
.dh ((SCREEN_W/2)+24) //Fix X Position of P2 4-Player Minigame HUD

.org 0x800C5580
.dh ((SCREEN_W/2)-120) //Fix X Position of P3 4-Player Minigame HUD

.org 0x800C5584
.dh ((SCREEN_W/2)+24) //Fix X Position of P4 4-Player Minigame HUD

.org 0x800C5588
.dh ((SCREEN_W/2)+24) //Fix X Position of P1 1 Vs 3 Minigame HUD

.org 0x800C558C
.dh ((SCREEN_W/2)+24) //Fix X Position of P2 1 Vs 3 Minigame HUD

.org 0x800C5590
.dh ((SCREEN_W/2)+24) //Fix X Position of P3 1 Vs 3 Minigame HUD

.org 0x800C5594
.dh ((SCREEN_W/2)-120) //Fix X Position of P4 1 Vs 3 Minigame HUD

.org 0x800C5598
.dh ((SCREEN_W/2)-120) //Fix X Position of P1 2 Vs 2 Minigame HUD

.org 0x800C559C
.dh ((SCREEN_W/2)-120) //Fix X Position of P2 2 Vs 2 Minigame HUD

.org 0x800C55A0
.dh ((SCREEN_W/2)+24) //Fix X Position of P3 2 Vs 2 Minigame HUD

.org 0x800C55A4
.dh ((SCREEN_W/2)+24) //Fix X Position of P4 2 Vs 2 Minigame HUD

.org 0x800C55A8
.dh ((SCREEN_W/2)-120) //Fix X Position of P4 1 Vs 3 Minigame HUD

.org 0x800C55A8
.dh ((SCREEN_W/2)-120) //Fix X Position of P1 1 Vs 3 Minigame HUD

.org 0x800C55AC
.dh ((SCREEN_W/2)+24) //Fix X Position of P2 1 Vs 3 Minigame HUD

.org 0x800C55B0
.dh ((SCREEN_W/2)+24) //Fix X Position of P3 1 Vs 3 Minigame HUD

.org 0x800C55B4
.dh ((SCREEN_W/2)+24) //Fix X Position of P4 1 Vs 3 Minigame HUD

.org 0x800C5704
.dh (SCREEN_W-34) //Fix X Position of Right Map Arrow

.org 0x800C5708
.dh (SCREEN_W/2) //Fix X Position of Top Map Arrow

.org 0x800C570C
.dh (SCREEN_W/2) //Fix X Position of Bottom Map Arrow

.org 0x800C5B40
.dh SCREEN_W*2 //Viewport Scale for Sprites

.org 0x800C5B48
.dh SCREEN_W*2 //Viewport X Position for Sprites

.org 0x800C6618
.dw SCREEN_W //VI Framebuffer Width

.org 0x800C6630
.dw ((SCREEN_W*512)/320) //VI Framebuffer Width

.org 0x800C6638
.dw (SCREEN_W*2) //VI Field 1 Framebuffer Offset

.org 0x800C664C
.dw (SCREEN_W*2) //VI Field 2 Framebuffer Offset

.org 0x800C6ED8
.dw SCREEN_W //VI MPAL Framebuffer Width

.org 0x800C6EF0
.dw ((SCREEN_W*512)/320) //VI MPAL Framebuffer Width

.org 0x800C6EF8
.dw (SCREEN_W*2) //VI MPAL Field 1 Framebuffer Offset

.org 0x800C6F0C
.dw (SCREEN_W*2) //VI MPAL Field 2 Framebuffer Offset

.org 0x800C9430 //S2DEX Data Section Area
.area 0x390
pauseRecordMes:
.db 0x11, 0x0A
.db 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x12, 0x0A
.db 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x13, 0x0A
.db 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x14, 0x0A
.db 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x15, 0x0A
.db 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x16, 0x0A
.db 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x17, 0x0A
.db 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x18
.db 0x00
.align 4 //Align code
HmfModelScaleSetWide:
mtc1 a1, f2 //Load X Scale of Model
//Load X Scale Factor
li.u at, (SCREEN_W_FLOAT/320)
li.l at, (SCREEN_W_FLOAT/320)
mtc1 at, f0
nop  //Nop Pad
//Apply X Scale
mul.s f2, f2, f0
mfc1 a1, f2
j 0x80025830 //Call HmfModelScaleSet
nop //Nop Pad
Mg04BackRectFix:
sw a0, 0(v0) //Run Other Replaced Instruction
//Or in Top Half of Texrect Position
lui a0, (((SCREEN_W/2)-160)/4)
j 0x800F9924 //Return to Caller
or a1, a1, a0
Mg16PlayerFixEdge:
//Load Offset for Player Edge
li v0, ((SCREEN_W_FLOAT-320)*2.5481074)
mtc1 v0, f0
lwc1 f2, 0(s1) //Load Player Position
j 0x800F8EC4 //Return to Caller
add.s f2, f2, f0 //Apply Player Edge Offset
Mg17FbCopyDrawFix:
addiu s5, r0, SCREEN_W //Row Width of Framebuffer Copy
multu s5, s2 //Calculate Offset of Framebuffer Copy for Drawing
mflo s5 //Get Offset of Framebuffer Copy for Drawing
j 0x800FAF5C //Return to Caller
nop //Delay Slot
Mg17FbCopyDrawSetupFix:
addiu s6, r0, SCREEN_W //Row Width of Framebuffer Copy Setup
multu s6, s3 //Calculate Offset of Framebuffer Copy for Drawing Setup
mflo s6 //Get Offset of Framebuffer Copy for Drawing Setup
j 0x800FAD68 //Return to Caller
nop //Delay Slot
Mg27LavaSizeFix:
//Set Scale of Skateboard Scamper Lava to 1.1640625f
lui at, 0x3F95
sw at, 0x30(s0)
sw at, 0x34(s0)
sw at, 0x38(s0)
j 0x800F8170 //Return to Caller
lui a0, 0x28 //Run Replaced Instruction
.endarea

.org 0x800CB668
.double (SCREEN_W_FLOAT/SCREEN_H) //Fix 2D Project Aspect Ratio

.org 0x800CB678
.double (SCREEN_W_FLOAT/SCREEN_H) //Fix 2D Project Scale Aspect Ratio

.org 0x800CB680
.double SCREEN_W_FLOAT //Max Sprite X Position

.headersize 0x800F65E0-0xCDA50 //Memory Match Segment

.org 0x800F66B4
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Memory Match

.org 0x800F66C0
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Memory Match

.org 0x800F6974
li.u at, (SCREEN_W_FLOAT/2) //Fix X Position of Sprites in Memory Match

.org 0x800F8198
li.u a2, (SCREEN_W_FLOAT/2) //Fix X Scale of Fade in Memory Match

.org 0x800F81E0
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Fade in Memory Match

.org 0x800FD930
.double SCREEN_W_FLOAT //Fix X Position of Background Elements in Memory Match

.org 0x800FD938
.double (SCREEN_W_FLOAT/2) //Fix X Position of Background Elements in Memory Match

.org 0x800FD958
.double SCREEN_W_FLOAT //Fix X Position of Background Elements in Memory Match

.org 0x800FD968
.double (SCREEN_W_FLOAT/2) //Fix X Position of Background Elements in Memory Match

.org 0x800FD988
.double SCREEN_W_FLOAT //Fix X Position of Background Elements in Memory Match

.org 0x800FD998
.double (SCREEN_W_FLOAT/2) //Fix X Position of Background Elements in Memory Match

.org 0x800FD9A8
.double SCREEN_W_FLOAT //Fix X Position of Background Elements in Memory Match

.org 0x800FD9B0
.double (SCREEN_W_FLOAT/2) //Fix X Position of Background Elements in Memory Match

.headersize 0x800F65E0-0xD51E0 //Chance Time Segment

.org 0x800F67A4
//Load Right Edge of Chance Time Scissor
li.u a3, (SCREEN_W_FLOAT-1)
li.l a3, (SCREEN_W_FLOAT-1)

.org 0x800F67B4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Size in Chance Time

.org 0x800F6C20
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Chance Time Message

.org 0x800FED58
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Trade Window in Chance Time

.org 0x800FF2CC
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Initial Window in Chance Time

.org 0x800FF368
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Bowser Initial Window in Chance Time

.org 0x800FF418
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Trade Window in Chance Time

.org 0x801011FC
.float ((SCREEN_W_FLOAT*400)/320) //Fix End X Position of Bowser

.org 0x8010122C
.float -((SCREEN_W_FLOAT*325)/320) //Fix Start X Position of Player

.headersize 0x800F65E0-0xE02F0 //Slot Machine Segment

.org 0x800F666C
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Slot Machine

.org 0x800F6678
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Slot Machine

.org 0x800F6B44
addiu a2, r0, (SCREEN_W/2) //Fix X Position of CFB Copy

.org 0x800F8648
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Filter

.org 0x800F865C
lui a0, hi(SCREEN_W*SCREEN_H/2) //Load High Half of Filter Size

.org 0x800F8664
addiu a0, a0, lo(SCREEN_W*SCREEN_H/2) //Load Low Half of Filter Size

.org 0x800F8670
sw v0, 0xFA54(v1) //Fix Offset to Data Array

.org 0x800F867C
bnez v0, 0x800F865C //Fix Backbranch

.org 0x800F8784
addiu a2, r0, ((SCREEN_W/2)-20) //Fix Center X Position of Lights

.org 0x800F88EC
li.u a2, ((SCREEN_W_FLOAT/2)-38) //Fix X Scale of Filter

.org 0x800F8908
addiu a2, r0, ((SCREEN_W/2)-79) //Fix X Position of Player Light

.org 0x800F89A0
addiu a2, r0, ((SCREEN_W/2)+45) //Fix X Offset for Lights

.org 0x800F89B4
addiu a2, r0, ((SCREEN_W/2)-205) //Fix X Offset for Lights

.org 0x800F8B68
li.u at, (SCREEN_W_FLOAT/2) //Fix Centering for Lights

.org 0x800F9494
li.u at, ((SCREEN_W_FLOAT/2)-38) //Fix X Scale of Filter

.org 0x800F9A60
lui a0, hi(SCREEN_W*SCREEN_H*2) //Load High Half of Framebuffer Size

.org 0x800F9A68
addiu a0, a0, lo(SCREEN_W*SCREEN_H*2) //Load Low Half of Framebuffer Size

.org 0x800F9B50
lui a2, (CFB_ADDR >> 16) //Fix CFB Copy Source Address

.org 0x800F9B60
li a1, ((SCREEN_W*SCREEN_H)-1) //Fix CFB Copy Word Count

.org 0x800F9BEC
addiu v0, r0, SCREEN_W //Fix CFB Copy Size

.org 0x800F9BFC
addiu v0, r0, (SCREEN_W/2) //Fix CFB Copy Centering

.org 0x800FD44C
li.u at, (SCREEN_W_FLOAT/2) //Fix Center of Items in Slot Machine

.org 0x800FEEB0
.double (SCREEN_W_FLOAT-118) //Fix X Offset of Right Light

.org 0x800FF150
.double (SCREEN_H/SCREEN_W_FLOAT) //Fix 2D Projection Aspect Ratio in Slot Machine

.headersize 0x800F65E0-0xE8F60 //Buried Treasure Segment

.org 0x800F667C
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Buried Treasure

.org 0x800F6688
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Buried Treasure

.org 0x800F9854
lui t6, (0xE400|(((SCREEN_W/2)+160)/4)) //Fix Right Edge of Buried Treasure Background

.org 0x800F991C
j Mg04BackRectFix //Call Hook to Fix Buried Treasure Background
or a0, a0, t6 //Run Replaced Instruction

.org 0x800F9ABC
addiu a2, r0, (SCREEN_W/2) //Fix Center X Position in Buried Treasure

.org 0x800FBF50
.double (SCREEN_W_FLOAT/2) //Fix X Offset of Dirt in Buried Treasure

.headersize 0x800F65E0-0xEE9A0 //Treasure Divers Segment

.org 0x800F667C
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Treasure Divers

.org 0x800F6688
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Treasure Divers

.org 0x800FBBF4
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Treasure Divers Background

.org 0x800FBC04
li.u a2, (SCREEN_W_FLOAT/160) //Fix Scale of Treasure Divers Background

.org 0x800FD37C
//Load Maximum Fish X Position in Treasure Divers
li.u at, ((SCREEN_W_FLOAT*1700)/320)
li.l at, ((SCREEN_W_FLOAT*1700)/320)

.org 0x800FD39C
//Load Minimum Fish X Position in Treasure Divers
li.u at, -((SCREEN_W_FLOAT*1700)/320)
li.l at, -((SCREEN_W_FLOAT*1700)/320)

.org 0x800FD46C
//Load Respawn Fish X Position in Treasure Divers
li.u at, ((SCREEN_W_FLOAT*1690)/320)
li.l at, ((SCREEN_W_FLOAT*1690)/320)

.org 0x800FD4B4
//Load Respawn Fish X Position in Treasure Divers
li.u at, -((SCREEN_W_FLOAT*1690)/320)
li.l at, -((SCREEN_W_FLOAT*1690)/320)

.org 0x800FE6C0
.double (SCREEN_W_FLOAT/2) //Fix Centering of Treasure Divers Effects

.headersize 0x800F65E0-0xF6AB0 //Shell Game Segment

.org 0x800F66AC
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Shell Game

.org 0x800F66B8
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Shell Game

.org 0x800F9408
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Shell Game Background

.org 0x800F943C
li.u a2, (SCREEN_W_FLOAT/2) //Fix X Scale of Shell Game Background

.org 0x800FCDC0
addiu a0, r0, 0 //Disable Shell Game Background Scrolling

.headersize 0x800F65E0-0xFF570 //Same Game Segment

.org 0x800F6678
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Same Game

.org 0x800F6684
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Same Game

.org 0x800F796C
//Fix Zoom in Same Game
li.u at, 878.0
li.l at, 878.0

.headersize 0x800F65E0-0x10CD10 //Hot Bob Omb Segment

.org 0x800F6A38
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Hot Bob Omb

.org 0x800F6A44
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Hot Bob Omb

.org 0x800FA30C
.float 1212 //Fix Hot Bob Omb Intro Zoom 1

.org 0x800FA330
.float 1508 //Fix Hot Bob Omb Intro Zoom 2

.org 0x800FA334
.float -16 //Fix Hot Bob Omb Intro X Position 2

.org 0x800FA344
.float 0 //Fix Hot Bob Omb Intro Y Rotation 2

.org 0x800FA354
.float 1508 //Fix Hot Bob Omb Intro Zoom 3

.org 0x800FA358
.float -16 //Fix Hot Bob Omb Intro X Position 3

.org 0x800FA368
.float 0 //Fix Hot Bob Omb Intro Y Rotation 3

.headersize 0x800F65E0-0x110F90 //Yoshi Tongue Meeting Segment

.org 0x800F6674
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Yoshi Tongue Meeting

.org 0x800F6680
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Yoshi Tongue Meeting

.org 0x800F66E4
addiu a0, r0, 1 //Force Yoshi Tongue Meeting Screen Clearing

.org 0x800F87D0
addiu s0, s0, (SCREEN_W/2) //Fix X Offset of Text in Yoshi Tongue Meeting

.org 0x800F8828
slti v0, s0, (SCREEN_W-55) //Fix Max X Position of Text in Yoshi Tongue Meeting

.org 0x800F8830
addiu s0, r0, (SCREEN_W-56) //Fix Max X Position of Text in Yoshi Tongue Meeting

.org 0x800F9400
.double (SCREEN_H/SCREEN_W_FLOAT) //Fix 2D Projection Aspect Ratio in Yoshi Tongue Meeting

.headersize 0x800F65E0-0x113DC0 //Pipe Maze Segment

.org 0x800F66B8
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Pipe Maze

.org 0x800F66C4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Pipe Maze

.org 0x800F6714
li.u a1, 28.0 //Fix FOV in Pipe Maze

.headersize 0x800F65E0-0x117210 //Ghost Guess Segment

.org 0x800F6678
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Ghost Guess

.org 0x800F6684
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Ghost Guess

.org 0x800F7B18
//Fix Camera End Zoom in Ghost Guess
li.u at, 1273.0
li.l at, 1273.0

.headersize 0x800F65E0-0x11C810 //Musical Mushroom Segment

.org 0x800F6684
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Musical Mushroom

.org 0x800F6690
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Musical Mushroom

.org 0x800F7070
//Fix Camera Zoom Amount in Musical Mushroom
li.u at, 1300.0
li.l at, 1300.0

.org 0x800F70D8
nop //Disable Camera X Rotation in Musical Mushroom

.org 0x800F70F0
nop //Disable Camera Y Rotation in Musical Mushroom

.org 0x800F7158
//Fix Camera Zoom End in Musical Mushroom
li.u at, 2460.0
li.l at, 2460.0

.headersize 0x800F65E0-0x1217D0 //Pedal Power Segment

.org 0x800F67EC
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Pedal Power

.org 0x800F67F8
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Pedal Power

.headersize 0x800F65E0-0x1250D0 //Crazy Cutters Segment

.org 0x800F6B6C
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Crazy Cutters

.org 0x800F6B78
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Crazy Cutters

.org 0x800F6C34
addiu v0, v0, ((SCREEN_W/2)-144) //Fix Centering of Background in Crazy Cutters

.org 0x800F6D74
addiu v0, v0, ((SCREEN_W/2)-80) //Fix Centering of Background in Crazy Cutters

.org 0x800F87C0
addiu a0, a0, -((SCREEN_W/2)-160) //Fix X Offset of Player Paint in Crazy Cutters

.org 0x800F87D0
sh a0, 0x30(sp) //Write X Offset of Player Paint in Crazy Cutters

.org 0x800F8EBC
j Mg16PlayerFixEdge //Fix Edge for Player in Crazy Cutters

.org 0x800F96D0
addiu a0, v0, -((SCREEN_W/2)-160) //Fix X Offset of Players in Crazy Cutters

.org 0x800F96E0
sh a0, 0x0(s0) //Write X Offset of Players in Crazy Cutters

.org 0x800FA93C
addiu a2, a2, ((SCREEN_W/2)-80) //Fix X Position of Miss Text

.org 0x800FCCF0
.float (-690.0+((SCREEN_W_FLOAT-320)*2.5481074)) //Fix X Position of P1 in Crazy Cutters
.float (140.0+((SCREEN_W_FLOAT-320)*2.5481074)) //Fix X Position of P2 in Crazy Cutters
.float (-690+((SCREEN_W_FLOAT-320)*2.5481074)) //Fix X Position of P3 in Crazy Cutters
.float (140.0+((SCREEN_W_FLOAT-320)*2.5481074)) //Fix X Position of P4 in Crazy Cutters

.org 0x800FCFA8
.dh ((SCREEN_W/2)-104) //X Position of P1 Score in Crazy Cutter

.org 0x800FCFAC
.dh ((SCREEN_W/2)+56) //X Position of P2 Score in Crazy Cutter

.org 0x800FCFB0
.dh ((SCREEN_W/2)-104) //X Position of P3 Score in Crazy Cutter

.org 0x800FCFB4
.dh ((SCREEN_W/2)+56) //X Position of P4 Score in Crazy Cutter

.headersize 0x800F65E0-0x12BC20 //Face Lift Segment

.org 0x800F7344
addiu v0, r0, (SCREEN_W-90) //X Position of Winner Score in Face Lift

.org 0x800F83E8
addiu a2, r0, (SCREEN_W/4) //Fix X Position of P1 Character Name

.org 0x800F8418
addiu a2, r0, ((SCREEN_W*3)/4) //Fix X Position of P2 Character Name

.org 0x800F8448
addiu a2, r0, (SCREEN_W/4) //Fix X Position of P3 Character Name

.org 0x800F8478
addiu a2, r0, ((SCREEN_W*3)/4) //Fix X Position of P4 Character Name

.org 0x800F8B98
addiu a2, r0, (SCREEN_W/2) //Offset of P2/P4 Win Tag in Face Lift
multu a2, v0 //Calculate Offset for Current Player Win Tag in Face Lift
mflo a2 //Get Offset for Current Player Win Tag in Face Lift

.org 0x800F8BD4
addiu a2, r0, (SCREEN_W/2) //Offset of P2/P4 Lose Tag in Face Lift
multu a2, v0 //Calculate Offset for Current Player Lose Tag in Face Lift
mflo a2 //Lose Offset for Current Player Lose Tag in Face Lift

.org 0x800F8C0C
addiu a2, a2, (SCREEN_W/4) //X Offset of Win/Lose Tags in Face Lift

.org 0x800F999C
lui a1, hi(ZBUF_ADDR+0x80000000) //High Part of Z Buffer Address in Face Lift
addiu a1, a1, lo(ZBUF_ADDR+0x80000000) //Low Part of Z Buffer Address in Face Lift

.org 0x800F99B8
ori v0, v0, (SCREEN_W-1) //Screen Width for Depth Buffer Clear in Face Lift

.org 0x800F9E70
slti v0, v0, SCREEN_W //Visible Width of Background Tilemap in Face Lift

.org 0x800FA174
li.u at, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio Low Part
li.l at, (SCREEN_W_FLOAT/SCREEN_H) //Load Aspect Ratio High Part

.org 0x800FA210
li.u at, (SCREEN_W_FLOAT-20) //Max X Position for Cursor in Face Lift

.org 0x800FAA74
li a0, ((SCREEN_W*SCREEN_H*2)+64) //Depth Buffer Copy Size in Face Lift

.org 0x800FABA0
addiu v0, r0, SCREEN_W //Framebuffer Copy Rendering Scissor Width

.org 0x800FAD38
ori v0, v0, (SCREEN_W-1) //Screen Width for Framebuffer Copy Rendering Setup in Face Lift

.org 0x800FAD60
j Mg17FbCopyDrawSetupFix //Jump to Code to Fix Framebuffer Copy Draw Setup Offset
nop //Delay Slot

.org 0x800FAD90
addiu v0, r0, SCREEN_W //Screen Width for Framebuffer Copy Setup in Face Lift

.org 0x800FAE68
slti v0, v0, SCREEN_W //Width of Framebuffer Copy Setup Tile Map

.org 0x800FAEA0
ori v0, v0, (SCREEN_W-1) //Screen Width for Normal Rendering in Face Lift

.org 0x800FAF54
j Mg17FbCopyDrawFix //Jump to Code to Fix Framebuffer Copy Draw Offset
nop //Delay Slot

.org 0x800FAF80
addiu v0, r0, SCREEN_W //Framebuffer Width for Rendering Framebuffer Copy

.org 0x800FB064
slti v0, v0, SCREEN_W //Width of Framebuffer Copy Tile Map

.org 0x800FC3D8
.float SCREEN_W_FLOAT //P1 Viewport Width in Face Lift

.org 0x800FC3E4
.float SCREEN_W_FLOAT //P2 Viewport Width in Face Lift

.org 0x800FC3F0
.float SCREEN_W_FLOAT //P3 Viewport Width in Face Lift

.org 0x800FC3FC
.float SCREEN_W_FLOAT //P4 Viewport Width in Face Lift

.org 0x800FC408
.float (SCREEN_W_FLOAT*2) //Center Viewport Width in Face Lift

.org 0x800FC414
.float SCREEN_W_FLOAT //P1 Viewport X Position in Face Lift

.org 0x800FC420
.float (SCREEN_W_FLOAT*3) //P2 Viewport X Position in Face Lift

.org 0x800FC42C
.float SCREEN_W_FLOAT //P3 Viewport X Position in Face Lift

.org 0x800FC438
.float (SCREEN_W_FLOAT*3) //P4 Viewport X Position in Face Lift

.org 0x800FC444
.float (SCREEN_W_FLOAT*2) //Center Viewport X Position in Face Lift

.org 0x800FC458
.float (SCREEN_W_FLOAT/2) //P1 Scissor Right Edge in Face Lift

.org 0x800FC460
.float (SCREEN_W_FLOAT/2) //P2 Scissor Left Edge in Face Lift

.org 0x800FC468
.float SCREEN_W_FLOAT //P2 Scissor Right Edge in Face Lift

.org 0x800FC478
.float (SCREEN_W_FLOAT/2) //P3 Scissor Right Edge in Face Lift

.org 0x800FC480
.float (SCREEN_W_FLOAT/2) //P4 Scissor Left Edge in Face Lift

.org 0x800FC488
.float SCREEN_W_FLOAT //P4 Scissor Right Edge in Face Lift

.org 0x800FC498
.float SCREEN_W_FLOAT //Center View Scissor Right Edge in Face Lift

.org 0x800FC4A4
.dh (SCREEN_W/2) //Fix X Position of P2 Viewport in Face Lift

.org 0x800FC4AC
.dh (SCREEN_W/2) //Fix X Position of P4 Viewport in Face Lift

.org 0x800FC7D4
.dh ((SCREEN_W/4)-24) //X Position of P1 Score in Face Lift

.org 0x800FC7D8
.dh ((SCREEN_W/4)+(SCREEN_W/2)-24) //X Position of P2 Score in Face Lift

.org 0x800FC7DC
.dh ((SCREEN_W/4)-24) //X Position of P3 Score in Face Lift

.org 0x800FC7E0
.dh ((SCREEN_W/4)+(SCREEN_W/2)-24) //X Position of P4 Score in Face Lift

.org 0x800FC808
.dw (0xF6000000|(SCREEN_W-1) << 14|(SCREEN_H-1) << 2) //Depth Buffer Clear Rectangle in Face Lift

.org 0x800FC820
.dw (0xFF100000|(SCREEN_W-1)) //Face Lift Framebuffer Reset Command

.headersize 0x800F65E0-0x131FA0 //Whack a Plant Segment

.org 0x800F6734
li.u a3, SCREEN_W_FLOAT //Scissor Width in Whack a Plant Minigame

.org 0x800F6740
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Whack a Plant Minigame

.org 0x800F76C8
//Fix Zoom Speed in Whack A Plant
li.u at, 7.525
li.l at, 7.525

.org 0x800F9DD4
addiu a1, r0, ((SCREEN_W/2)-18) //X Position of Coin Icon in Whack a Plant

.org 0x800FA014
addiu a1, r0, (SCREEN_W/2) //X Position of First Digit of Coin Count in Whack a Plant

.org 0x800FA048
addiu a1, r0, ((SCREEN_W/2)+16) //X Position of Second Digit of Coin Count in Whack a Plant

.headersize 0x800F65E0-0x137050 //Bash and Cash Segment

.org 0x800F6680
li.u a3, SCREEN_W_FLOAT //Scissor Width in Bash and Cash Minigame

.org 0x800F668C
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Bash and Cash Minigame

.org 0x800FE400
.dh (SCREEN_W-56) //X Position of P2 Coin Count in Bash and Cash

.org 0x800FE408
.dh (SCREEN_W-56) //X Position of P4 Coin Count in Bash and Cash

.org 0x800FE524
.dh (SCREEN_W-56) //X Position of P2 Player Name in Bash and Cash

.org 0x800FE52C
.dh (SCREEN_W-56) //X Position of P4 Player Name in Bash and Cash

.org 0x800FE534
.dh (SCREEN_W-73) //X Position of P2 Coin Icon in Bash and Cash

.org 0x800FE53C
.dh (SCREEN_W-73) //X Position of P4 Coin Icon in Bash and Cash

.headersize 0x800F65E0-0x13EFB0 //Bowl Over Segment

.org 0x800F6764
li a3, (SCREEN_W_FLOAT-1) //Initial Scissor Width in Bowl Over Minigame

.org 0x800F6B60
li a3, (SCREEN_W_FLOAT-1) //Miss Scissor Width in Bowl Over Minigame

.org 0x800F73E0
li a3, (SCREEN_W_FLOAT-1) //Top View Resizing Scissor Width in Bowl Over Minigame

.org 0x800F7418
li a3, (SCREEN_W_FLOAT-1) //Bottom View Resizing Scissor Width in Bowl Over Minigame

.org 0x800F7450
li a3, (SCREEN_W_FLOAT-1) //Top View Scissor Width in Bowl Over Minigame

.org 0x800F7478
li a3, (SCREEN_W_FLOAT-1) //Bottom View Scissor Width in Bowl Over Minigame

.org 0x800F7534
li a3, (SCREEN_W_FLOAT-1) //Hitting View Scissor Width in Bowl Over Minigame

.org 0x800F780C
li a3, (SCREEN_W_FLOAT-1) //Final View Scissor Width in Bowl Over Minigame

.org 0x800F95C0
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Bowl Over Minigame

.headersize 0x800F65E0-0x146200 //Ground Pound Segment

.org 0x800F66A4
li.u a3, SCREEN_W_FLOAT //Scissor Width in Ground Pound Minigame

.org 0x800F66B0
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Ground Pound Minigame

.headersize 0x800F65E0-0x149E80 //Balloon Burst Segment

.org 0x800F6C6C
li.u a3, SCREEN_W_FLOAT //Scissor Width in Balloon Burst Minigame

.org 0x800F6C78
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Balloon Burst Minigame

.headersize 0x800F65E0-0x14E940 //Coin Block Blitz Segment

.org 0x800F6680
li.u a3, SCREEN_W_FLOAT //Scissor Width in Coin Block Blitz Minigame

.org 0x800F668C
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Coin Block Blitz Minigame

.headersize 0x800F65E0-0x152BE0 //Coin Block Bash Segment

.org 0x800F6D00
li.u a3, SCREEN_W_FLOAT //Scissor Width in Coin Block Bash Minigame

.org 0x800F6D0C
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Coin Block Bash Minigame

.org 0x800F7E98
li.u at, (SCREEN_W_FLOAT/2) //X Offset of Particles in Coin Block Bash Minigame

.org 0x80102368
.double (SCREEN_H/SCREEN_W_FLOAT) //Aspect Ratio of Particle Positioning in Coin Block Bash Minigame

.headersize 0x800F65E0-0x15EAF0 //Skateboard Scamper Segment

.org 0x800F664C
li.u a3, SCREEN_W_FLOAT //Scissor Width in Skateboard Scamper Minigame

.org 0x800F6658
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Skateboard Scamper Minigame

.org 0x800F8168
j Mg27LavaSizeFix //Fix Lava Size in Skateboard Scamper
addu s0, a0, r0 //Run Replaced Instruction

.headersize 0x800F65E0-0x166220 //Box Mountain Mayhem Segment

.org 0x800F669C
li.u a3, SCREEN_W_FLOAT //Scissor Width in Box Mountain Mayhem Minigame

.org 0x800F66A8
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Box Mountain Mayhem Minigame

.headersize 0x800F65E0-0x16BD20 //Platform Peril Segment

.org 0x800F6FA0
li.u a3, SCREEN_W_FLOAT //Scissor Width in Platform Peril Minigame

.org 0x800F6FAC
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Platform Peril Minigame

.org 0x800FADA4
addiu a1, r0, (SCREEN_W/2) //Fix Background X Position in Platform Peril

.headersize 0x800F65E0-0x1738E0 //Teetering Towers Segment

.org 0x800FA2C8
li.u a3, SCREEN_W_FLOAT //Scissor Width in Teetering Towers Minigame

.org 0x800FA2D4
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Teetering Towers Minigame

.headersize 0x800F65E0-0x1784E0 //Mushroom Mixup Segment

.org 0x800F6680
li.u a3, SCREEN_W_FLOAT //Scissor Width in Mushroom Mixup Minigame

.org 0x800F668C
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Mushroom Mixup Minigame

.org 0x800FB33C
li.u at, ((SCREEN_W_FLOAT*1000)/320) //Fix Right Spawn X Position of Blooper in Mushroom Mixup

.org 0x800FB360
li.u at, -((SCREEN_W_FLOAT*1000)/320) //Fix Left Spawn X Position of Blooper in Mushroom Mixup

.org 0x800FB984
li.u at, ((SCREEN_W_FLOAT*1000)/320) //Fix Maximum X Position of Blooper in Mushroom Mixup

.org 0x800FB9C8
li.u at, -((SCREEN_W_FLOAT*1000)/320) //Fix Minimum X Position of Blooper in Mushroom Mixup

.headersize 0x800F65E0-0x17E710 //Hammer Drop Segment

.org 0x800F6938
li.u a3, SCREEN_W_FLOAT //Scissor Width in Hammer Drop Minigame

.org 0x800F6944
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Hammer Drop Minigame


.headersize 0x800F65E0-0x1837D0 //Grab Bag Segment

.org 0x800F6738
li.u a3, SCREEN_W_FLOAT //Scissor Width in Grab Bag Minigame

.org 0x800F6744
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Grab Bag Minigame

.org 0x800FB0F8
.dh (SCREEN_W-56) //X Position of P2 Coin Count in Grab Bag

.org 0x800FB100
.dh (SCREEN_W-56) //X Position of P4 Coin Count in Grab Bag

.org 0x800FB1FC
.dh (SCREEN_W-56) //X Position of P2 Player Name in Grab Bag

.org 0x800FB204
.dh (SCREEN_W-56) //X Position of P4 Player Name in Grab Bag

.org 0x800FB20C
.dh (SCREEN_W-73) //X Position of P2 Coin Icon in Grab Bag

.org 0x800FB214
.dh (SCREEN_W-73) //X Position of P4 Coin Icon in Grab Bag

.headersize 0x800F65E0-0x188410 //Bobsled Run Segment

.org 0x800F666C
li.u a3, SCREEN_W_FLOAT //P1 Scissor Width in Bobsled Run Minigame

.org 0x800F6678
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Bobsled Run Minigame

.org 0x800F66F4
li.u a3, SCREEN_W_FLOAT //P2 Scissor Width in Bobsled Run Minigame

.org 0x800F6960
addiu a0, r0, (SCREEN_W-74) //X Position of Record in Bobsled Run

.org 0x800F696C
addiu a0, r0, (SCREEN_W-74) //X Position of Current Time in Bobsled Run

.org 0x800F7734
li.u at, (SCREEN_W_FLOAT-58) //Progress Bar Position Scale in Bobsled Run

.org 0x800FAB50
slti v0, v0, (SCREEN_W-32) //Bar Width Bobsled Run

.org 0x800FAB80
addiu a1, r0, (SCREEN_W-16) //X Position of Last Bar of Progress Meter in Bobsled Run

.org 0x800FABCC
addiu a1, r0, (SCREEN_W-32) //X Position of Finish Bar of Progress Meter in Bobsled Run

.org 0x800FAC18
addiu a1, r0, (SCREEN_W-32) //X Position of Finish Flag of Progress Meter in Bobsled Run

.org 0x800FAD24
li.u at, (SCREEN_W_FLOAT/8) //Width of Death Filter in Bobsled Run  

.headersize 0x800F65E0-0x191700 //Bumper Balls Segment

.org 0x800F66E0
li.u a3, SCREEN_W_FLOAT //Scissor Width in Bumper Balls Minigame

.org 0x800F66EC
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Bumper Balls Minigame

.org 0x800F8904
li.u at, -((SCREEN_W_FLOAT*1200)/320) //Fix Minimum X Position of Blooper Pickup

.org 0x800F8920
li.u at, -((SCREEN_W_FLOAT*1360)/320) //Fix Minimum X Position of Blooper Pickup

.org 0x800F8940
li.u at, ((SCREEN_W_FLOAT*1200)/320) //Fix Maximum X Position of Blooper Pickup

.org 0x800F895C
li.u at, ((SCREEN_W_FLOAT*1360)/320) //Fix Maximum X Position of Blooper Pickup

.org 0x800FB4DC
li.u at, ((SCREEN_W_FLOAT*400)/320) //Fix Size of Bumper Balls Water

.org 0x800FB4E4
li.u at, ((SCREEN_W_FLOAT*1200)/320) //Fix Offset of Bumper Balls Water

.headersize 0x800F65E0-0x197E20 //Tightrope Treachery Segment

.org 0x800F6798
li a3, (SCREEN_W_FLOAT-1) //Scissor Width in Tightrope Treachery Minigame

.org 0x800F67A8
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Tightrope Treachery Minigame

.headersize 0x800F65E0-0x19FEE0 //Knock Block Tower Segment

.org 0x800F6680
li.u a3, SCREEN_W_FLOAT //Scissor Width in Knock Block Tower Minigame

.org 0x800F668C
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Knock Block Tower Minigame

.org 0x800FA160
li.u at, ((SCREEN_W_FLOAT*920)/320) //Fix Maximum X Position for Knock Block Tower Fly Guy

.org 0x800FA204
li.u at, -((SCREEN_W_FLOAT*900)/320) //Fix Minimum X Position for Knock Block Tower Fly Guy

.org 0x800FAF70
addiu a0, r0, 0 //Disable Knock Block Tower Background Scrolling

.org 0x800FB480
addiu a2, r0, (SCREEN_W/2) //X Position of Knock Block Tower Color Background

.org 0x800FB4B4
li.u a2, (SCREEN_W_FLOAT/2) //X Scale of Knock Block Tower Color Background

.headersize 0x800F65E0-0x1A4EB0 //Tipsy Tourney Segment

.org 0x800F6668
li.u a3, (SCREEN_W_FLOAT/2) //Right Edge of P1 Scissor in Tipsy Tourney

.org 0x800F6674
li.u at, SCREEN_W_FLOAT //Width of P1 Viewport in Tipsy Tourney

.org 0x800F66E8
li.u a1, (SCREEN_W_FLOAT/2) //Left Edge of P2 Scissor in Tipsy Tourney
li.u a3, SCREEN_W_FLOAT //Right Edge of P2 Scissor in Tipsy Tourney

.org 0x800F66F8
li.u at, (SCREEN_W_FLOAT*3) //X Position of P2/P4 Viewports in Tipsy Tourney

.org 0x800F6748
li.u a3, (SCREEN_W_FLOAT/2) //Right Edge of P3 Scissor in Tipsy Tourney

.org 0x800F679C
li.u a1, (SCREEN_W_FLOAT/2) //Left Edge of P4 Scissor in Tipsy Tourney

.org 0x800F6808
li.u at, (SCREEN_W_FLOAT*2) //Width of Center Viewport in Tipsy Tourney

.org 0x800F878C
slti v0, v0, SCREEN_W //Width of Cloud Tilemap in Tipsy Tourney

.headersize 0x800F65E0-0x1AA2A0 //Bombs Away Segment

.org 0x800F66A0
li.u a3, SCREEN_W_FLOAT //Scissor Width in Bombs Away Minigame

.org 0x800F66AC
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Bombs Away Minigame

.org 0x800FC74C
addiu a2, r0, (SCREEN_W/2) //X Position of Background in Bombs Away Minigame

.org 0x800FC760
li.u a2, (SCREEN_W_FLOAT/160) //X Scale of Bombs Away Background

.org 0x800FCCF0
addiu a2, r0, (SCREEN_W/2) //X Position of Background in Bombs Away Minigame

.org 0x800FD8E0
li.u at, ((SCREEN_W_FLOAT/2)-60) //X Position of Left Bird in Bombs Away

.org 0x800FD98C
li.u at, ((SCREEN_W_FLOAT/2)-20) //X Position of Right Bird in Bombs Away

.org 0x800FFE50
.float ((SCREEN_W_FLOAT*1000)/320) //Fix Right Blooper Exit X Position

.org 0x800FFE60
.float -((SCREEN_W_FLOAT*1000)/320) //Fix Left Blooper Exit X Position

.org 0x800FFE68
.float -((SCREEN_W_FLOAT*800)/320) //Fix Left Blooper X Position

.org 0x800FFE70
.float ((SCREEN_W_FLOAT*800)/320) //Fix Right Blooper X Position

.headersize 0x800F65E0-0x1B3E00 //Crane Game Segment

.org 0x800F6680
li.u a3, SCREEN_W_FLOAT //Scissor Width in Crane Game Minigame

.org 0x800F668C
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Crane Game Minigame

.org 0x800F69F0
//Fix Zoom in Crane Game
li.u at, 2104.0
li.l at, 2104.0

.org 0x800FF504
.dh (SCREEN_W-56) //X Position of P2 Coin Count in Crane Game

.org 0x800FF50C
.dh (SCREEN_W-56) //X Position of P4 Coin Count in Crane Game

.org 0x800FFCBC
.dh (SCREEN_W-56) //X Position of P2 Player Name in Crane Game

.org 0x800FFCC4
.dh (SCREEN_W-56) //X Position of P4 Player Name in Crane Game

.org 0x800FFCCC
.dh (SCREEN_W-73) //X Position of P2 Coin Icon in Crane Game

.org 0x800FFCD4
.dh (SCREEN_W-73) //X Position of P4 Coin Icon in Crane Game

.headersize 0x800F65E0-0x1BD640 //Coin Shower Flower Segment

.org 0x800F664C
li.u a3, SCREEN_W_FLOAT //Scissor Width in Coin Shower Flower Minigame

.org 0x800F6658
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Coin Shower Flower Minigame

.headersize 0x800F65E0-0x1C1EB0 //Slot Car Derby Segment

.org 0x800F6750
li.u a3, SCREEN_W_FLOAT //Scissor Width in Slot Car Derby Minigame

.org 0x800F675C
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Slot Car Derby Minigame

.org 0x800FB0A8
addiu a2, r0, (SCREEN_W/2) //Fix X  Position of Slot Car Derby Background

.org 0x800FC5A0
addiu a2, r0, (SCREEN_W-90) //X Position of Record Time in Slot Car Derby

.org 0x800FC604
addiu a2, r0, (SCREEN_W-90) //X Position of Current Time in Slot Car Derby

.org 0x801012F8
.double (SCREEN_W_FLOAT/2) //Center X Position for Balloons in Slot Car Derby

.org 0x80101410
.double (SCREEN_W_FLOAT/SCREEN_H) //Aspect Ratio of 3D to 2D Conversions in Slot Car Derby

.headersize 0x800F65E0-0x1CCCF0 //Mario Bandstand Segment

.org 0x800F6684
li.u a3, SCREEN_W_FLOAT //Scissor Width in Mario Bandstand Minigame

.org 0x800F6690
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Mario Bandstand Minigame

.org 0x800F66DC
li.u a1, 23.0 //Fix FOV in Mario Bandstand

.org 0x800FBBCC
addiu a2, r0, ((SCREEN_W/2)-4) //X Position of Song Charts in Mario Bandstand

.org 0x800FBF30
addiu a2, r0, (SCREEN_W+20) //X Position of Unused 1-Team Song Cursor in Mario Bandstand

.org 0x800FC05C
addiu a2, a2, ((SCREEN_W/2)-72) //X Position of 3-Team Song Cursor in Mario Bandstand

.org 0x800FC2CC
addiu a2, a2, ((SCREEN_W/2)-72) //X Position of 3-Team Notes in Mario Bandstand

.org 0x800FC704
addiu a2, r0, (SCREEN_W+20) //Starting X Position of Unused 1-Team Song Cursor in Mario Bandstand

.org 0x800FD144
.dh ((SCREEN_W/2)-120) //X Position of P2 Icon in Mario Bandstand

.org 0x800FD148
.dh ((SCREEN_W/2)-120) //X Position of P3 Icon in Mario Bandstand

.org 0x800FD14C
.dh ((SCREEN_W/2)-120) //X Position of P4 Icon in Mario Bandstand

.headersize 0x800F65E0-0x1D3990 //Desert Dash Segment

.org 0x800F66A0
li.u a3, SCREEN_W_FLOAT //Default P1 Scissor Width in Desert Dash Minigame

.org 0x800F66AC
li.u at, (SCREEN_W_FLOAT*2) //Default Viewport Width in Desert Dash Minigame

.org 0x800F6700
li.u a1, SCREEN_W_FLOAT //Default P2 Scissor X Position in Desert Dash Minigame

.org 0x800F6710
li.u at, (SCREEN_W_FLOAT*3) //Default P2 Viewport X Position in Desert Dash Minigame

.org 0x800F74F8
addiu a0, r0, SCREEN_W //X Position of Right Edge of Desert Dash Background During Zoom-In

.org 0x800F7780
li.u a1, (SCREEN_W_FLOAT*2) //P2 Viewport X Position in Desert Dash Minigame

.org 0x800F77A4
li.u a3, SCREEN_W_FLOAT //Right Edge of P2 Scissor in Desert Dash Minigame

.org 0x800F9E90
li.u at, (SCREEN_W_FLOAT/2) //X Position Scale for Desert Dash Background

.org 0x800F9F24
addiu v0, r0, (SCREEN_W+1) //X Position of Right Edge of P2 Background in Desert Dash

.org 0x800F9F54
slti s0, s0, (SCREEN_W-2) //Minimum X Position for P2 Background Visiblity

.org 0x800FA028
li.u at, (SCREEN_W_FLOAT/2) //Default Sun X Position in Desert Dash Minigame

.org 0x800FA104
addiu v0, r0, SCREEN_W //X Position for Showing of Separator Bar

.org 0x800FA144
slti v0, v0, SCREEN_W //X Position for Hiding of Separator Bar

.org 0x800FC0A0
.double (SCREEN_W_FLOAT/2) //X Offset of Center of Viewports in Desert Dash

.headersize 0x800F65E0-0x1D9690 //Shy Guy Says Segment

.org 0x800F66A4
li.u a3, SCREEN_W_FLOAT //Scissor Width in Shy Guy Says Minigame

.org 0x800F66B0
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Shy Guy Says Minigame

.org 0x800FA834
li.u at, SCREEN_W_FLOAT //X Position of Background in Shy Guy Says Minigame

.org 0x800FA870
li.u a2, (SCREEN_W_FLOAT/160) //Scale of Shy Guy Says Background

.org 0x800FB91C
li.u at, ((SCREEN_W_FLOAT/2)-40) //X Position of Left Bird in Shy Guy Says

.org 0x800FB980
li.u at, (SCREEN_W_FLOAT/2) //X Position of Right Bird in Shy Guy Says

.headersize 0x800F65E0-0x1E0A30 //Limbo Dance Segment

.org 0x800F66A4
li.u a3, SCREEN_W_FLOAT //Scissor Width in Limbo Dance Minigame

.org 0x800F66B0
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Limbo Dance Minigame

.org 0x800FB864
lui v0, (0xE400|(SCREEN_W/4)) //Texture Rectangle for Background in Limbo Dance

.headersize 0x800F65E0-0x1E9440 //Bombsketball Segment

.org 0x800F81E8
li.u a3, SCREEN_W_FLOAT //Scissor Width in Bombsketball Minigame

.org 0x800F81F4
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Bombsketball Minigame

.headersize 0x800F65E0-0x1F0DA0 //Cast Aways Segment

.org 0x800F7224
li.u a1, (SCREEN_W_FLOAT/160) //Scale of Cast Aways Background

.org 0x800F7248
li.u a3, SCREEN_W_FLOAT //Scissor Width in Cast Aways Minigame

.org 0x800F7254
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Cast Aways Minigame

.org 0x800F7E40
li.u at, (SCREEN_W_FLOAT+20) //Max X Position of Obstacles in Cast Aways

.org 0x800FA250
addiu a1, r0, (SCREEN_W/2) //X Position of Cast Aways Background

.org 0x800FB8B4
li.u at, 36.0 //Fix FOV in Cast Aways

.headersize 0x800F65E0-0x1F62C0 //Key-pa-Way Segment

.org 0x800F6718
li.u a3, SCREEN_W_FLOAT //Scissor Width in Key-pa-Way Minigame

.org 0x800F6724
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Key-pa-Way Minigame

.headersize 0x800F65E0-0x1FF1E0 //Running of the Bulb Segment

.org 0x800F6658
//Fix Camera Offset in Running of the Bulb Minigame
li.u at, 1475.0
li.l at, 1475.0

.org 0x800F66A0
li.u a3, SCREEN_W_FLOAT //Scissor Width in Running of the Bulb Minigame

.org 0x800F66AC
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Running of the Bulb Minigame

.org 0x800F6E24
//Fix Camera Stopper in Running of the Bulb Minigame
li.u at, -1843.0
li.l at, -1843.0

.org 0x800F6E94
//Fix Fast Camera Stopper in Running of the Bulb Minigame
li.u at, -1843.0
li.l at, -1843.0

.org 0x800F6EE4
//Fix Fast Camera Stopper in Running of the Bulb Minigame
li.u at, -1843.0
li.l at, -1843.0

.headersize 0x800F65E0-0x207040 //Hot Rope Jump Segment

.org 0x800F6678
li.u a3, SCREEN_W_FLOAT //Scissor Width in Hot Rope Jump Minigame

.org 0x800F6684
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Hot Rope Jump Minigame

.org 0x800F6BE0
addiu a2, r0, (SCREEN_W-56) //X Position of Slash in Score in Hot Rope Jump Minigame

.org 0x800F6CC8
li.u a1, -((SCREEN_W_FLOAT*800)/320) //Fix Offscreen X Position of P1 in Hot Rope Jump

.org 0x800F6D5C
li.u a1, -((SCREEN_W_FLOAT*800)/320) //Fix Offscreen X Position of P2 in Hot Rope Jump

.org 0x800F6DF0
li.u a1, -((SCREEN_W_FLOAT*800)/320) //Fix Offscreen X Position of P3 in Hot Rope Jump

.org 0x800F6E84
li.u a1, -((SCREEN_W_FLOAT*800)/320) //Fix Offscreen X Position of P4 in Hot Rope Jump

.org 0x800FE48E
.dh (SCREEN_W-80) //X Position of First Digit of Score in Hot Rope Jump

.org 0x800FE496
.dh (SCREEN_W-64) //X Position of Second Digit of Score in Hot Rope Jump

.org 0x800FE49E
.dh (SCREEN_W-48) //X Position of First Digit of Max Score in Hot Rope Jump

.org 0x800FE4A6
.dh (SCREEN_W-32) //X Position of First Digit of Max Score in Hot Rope Jump


.headersize 0x800F65E0-0x20F570 //Handcar Havoc Segment

.org 0x800F672C
li.u a3, ((SCREEN_W_FLOAT/2)-16) //P1 Scissor Width in Handcar Havoc Minigame

.org 0x800F6738
li.u at, SCREEN_W_FLOAT //P1 Viewport X Position in Handcar Havoc Minigame

.org 0x800F676C
li.u a1, (SCREEN_W_FLOAT*2) //P1 Viewport Width in Handcar Havoc Minigame

.org 0x800F678C
li.u a1, ((SCREEN_W_FLOAT/2)+16) //P2 Scissor X Position in Handcar Havoc Minigame

.org 0x800F67A0
li.u at, (SCREEN_W_FLOAT*3) //P2 Viewport X Position in Handcar Havoc Minigame

.org 0x800F67B8
li.u a1, (SCREEN_W_FLOAT*2) //P2 Viewport Width in Handcar Havoc Minigame

.org 0x800F761C
addiu v0, r0, ((SCREEN_W/2)-16) //Fix P1 Background Right Edge

.org 0x800F7644
addiu v0, r0, (SCREEN_W/2) //Fix P2 Background Left Edge

.org 0x800F7650
addiu v0, r0, SCREEN_W //Fix P2 Background Right Edge

.org 0x800F7E18
addiu a1, r0, (SCREEN_W/2) //X Position of Handcar Havoc Tracks

.org 0x800F7E64
addiu a1, r0, (SCREEN_W/2) //X Position of Handcar Havoc Finish Line

.org 0x800FCBC4
addiu s0, r0, ((SCREEN_W/2)+8) //X Position of Left Team Progress in Handcar Havoc
addiu s0, r0, ((SCREEN_W/2)-8) //X Position of Right Team Progress in Handcar Havoc

.org 0x800FCE90
addiu s3, r0, ((SCREEN_W/2)-33) //X Position of Current Record and Time in Handcar Havoc

.org 0x800FDF20
addiu v0, r0,  (SCREEN_W/2) //Fix Size of Background Repeat Image

.org 0x800FDF50
addiu v1, r0,  (SCREEN_W/2) //Fix Size of Background Repeat Image

.headersize 0x800F65E0-0x218510 //Deep Sea Divers Segment

.org 0x800F667C
li.u a3, SCREEN_W_FLOAT //Scissor Width in Deep Sea Divers Minigame

.org 0x800F6688
li.u at, (SCREEN_W_FLOAT*2) //Viewport X Position in Deep Sea Divers Minigame

.org 0x800FD540
addiu a2, r0, (SCREEN_W/2) //X Position of Deep Sea Divers Background

.org 0x800FD554
li.u a2, (SCREEN_W_FLOAT/160) //X Scale of Deep Sea Divers Background

.headersize 0x800F65E0-0x222320 //Piranhas Pursuit Segment

.org 0x800F6670
li.u a3, SCREEN_W_FLOAT //Scissor Width in Piranhas Pursuit Minigame

.org 0x800F667C
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Piranhas Pursuit Minigame

.org 0x800F66C8
li.u a1, 36.0 //Fix FOV in Piranhas Pursuit

.org 0x800FAE30
li.u a2, (SCREEN_W_FLOAT/160) //X Scale of Piranha Pursuit Background
li a3, (SCREEN_W_FLOAT/145.4545) //Y Scale of Piranha Pursuit Background

.org 0x800FB4B8
li.u at, -SCREEN_W_FLOAT //Second Background Apartness in Piranha Pursuit

.org 0x800FB528
li.u at, SCREEN_W_FLOAT //Second Background Apartness in Piranha Pursuit

.org 0x801003A4
.dw (((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Fix Scissor for Rain in Piranha Pursuit

.org 0x80100870
.double SCREEN_W_FLOAT //X Position Scale of Piranha Pursuit Background
.double -SCREEN_W_FLOAT //X Position Revert Point of Piranha Pursuit Background
.double SCREEN_W_FLOAT //X Position Revert Amount of Piranha Pursuit Background

.headersize 0x800F65E0-0x22C9E0 //Tug of War Segment

.org 0x800F67B4
li a3, (SCREEN_W_FLOAT-1) //Scissor Width in Tug of War Minigame

.org 0x800F67C4
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Tug of War Minigame

.org 0x800FCB74
addiu a3, r0, (SCREEN_W/2) //X Position of Sun in Tug of War

.org 0x800FCE00
addiu a2, r0, (SCREEN_W/2) //X Position of Tug of War Background

.org 0x800FCE14
li.u a2, (SCREEN_W_FLOAT/160) //Size of Tug of War Background

.headersize (0x800F65E0-0x2341E0) //Patch Paddle Battle Overlay

.org 0x800F668C
li a3, SCREEN_W_FLOAT //Scissor Width in Paddle Battle Minigame

.org 0x800F6698
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Paddle Battle Minigame

.org 0x800FAA00
li.u at, (SCREEN_W_FLOAT/2) //X Offset of Coins in Paddle Battle

.org 0x800FC240
addiu a2, r0, (SCREEN_W/2) //X Position of Paddle Battle Background

.org 0x800FF190
.double (SCREEN_H/SCREEN_W_FLOAT) //Fix Aspect Ratio for Coins in Paddle Battle

.headersize 0x800F65E0-0x23CF40 //Patch Bumper Ball Maze Overlay

.org 0x800F66EC
li.u a3, SCREEN_W_FLOAT //Scissor Width in Bumper Ball Maze Minigame

.org 0x800F66F8
li.u at, (SCREEN_W_FLOAT*2) //Viewport Width in Bumper Ball Maze Minigame

.org 0x800F9BB0
//Fix Scale of Bumper Ball Maze Water
li.u at, ((SCREEN_W_FLOAT*715)/320)
li.l at, ((SCREEN_W_FLOAT*715)/320)

.org 0x800F9BBC
//Fix Offset of Bumper Ball Maze Water
li.u at, ((SCREEN_W_FLOAT*2145)/320)
li.l at, ((SCREEN_W_FLOAT*2145)/320)

.org 0x800F9C04
//Fix Scale of Bumper Ball Maze Water
li.u at, ((SCREEN_W_FLOAT*750)/320)
li.l at, ((SCREEN_W_FLOAT*750)/320)

.org 0x800F9C18
//Fix Offset of Bumper Ball Maze Water
li.u at, ((SCREEN_W_FLOAT*2250)/320)
li.l at, ((SCREEN_W_FLOAT*2250)/320)

.org 0x800F9CDC
//Fix Scale of Bumper Ball Maze Water
li.u at, ((SCREEN_W_FLOAT*750)/320)
li.l at, ((SCREEN_W_FLOAT*750)/320)

.org 0x800F9CF0
//Fix Offset of Bumper Ball Maze Water
li.u at, ((SCREEN_W_FLOAT*2250)/320)
li.l at, ((SCREEN_W_FLOAT*2250)/320)

.org 0x800FAB50
.dh (SCREEN_W-113) //X Position of Bumper Ball Maze 1 Timer

.org 0x800FAB54
.dh (SCREEN_W-113) //X Position of Bumper Ball Maze 2 Timer

.org 0x800FAB58
.dh (SCREEN_W-113) //X Position of Bumper Ball Maze 3 Timer

.headersize 0x800F65E0-0x2418A0 //DK Jungle Adventure Segment

.org 0x800F7B84
addiu a0, r0, ((SCREEN_W/2)-110) //Fix X Position of Whomp 1 Textbox

.org 0x800F7DD8
addiu a0, r0, ((SCREEN_W/2)-110) //Fix X Position of Whomp 2 Textbox

.org 0x800F802C
addiu a0, r0, ((SCREEN_W/2)-110) //Fix X Position of Whomp 3 Textbox

.org 0x800F8B0C
addiu a0, r0, ((SCREEN_W/2)-85) //Fix X Position of Nothing Happened Textbox

.org 0x800F9030
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of 20 Coin Door 1 Textbox

.org 0x800F921C
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of 20 Coin Door 2 Textbox

.org 0x800F94B4
addiu a0, r0, ((SCREEN_W/2)-95) //Fix X Position of Coin Bonus Textbox 1

.org 0x800F94B8
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of Coin Bonus Textbox 2

.headersize 0x800F65E0-0x2455C0 //Peach Birthday Cake Segment

.org 0x800F7508
addiu a0, r0, ((SCREEN_W/2)-95) //Fix X Position of 20 Coin Bonus Window

.org 0x800F750C
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of 10 Coin Bonus Window

.org 0x800F7860
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Happening Space Does Nothing


.org 0x800F78CC
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Happening Space Does Nothing

.org 0x800F7928
addiu a0, r0, ((SCREEN_W/2)-95) //Fix X Position of Piranha Plant Wont Bother

.headersize 0x800F65E0-0x246DF0 //Yoshi Tropical Island Segment

.org 0x800F77CC
addiu a0, r0, ((SCREEN_W/2)-82) //Fix X Position of Whomp Toll Window

.org 0x800F7C30
addiu a0, r0, ((SCREEN_W/2)-95) //Fix X Position of 20 Coin Bonus Window

.org 0x800F7C34
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of 10 Coin Bonus Window

.headersize 0x800F65E0-0x248F00 //Wario Battle Canyon Segment

.org 0x800F7E24
addiu a0, r0, ((SCREEN_W/2)-45) //Fix X Position of Set Target Window

.org 0x800F8908
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Fire Cannon Window

.org 0x800F9354
addiu a0, r0, ((SCREEN_W/2)-106) //Fix X Position of Cannon Change Direction Window

.org 0x800F9470
addiu a0, r0, ((SCREEN_W/2)-95) //Fix X Position of 20 Coin Bonus Window

.org 0x800F9474
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of 10 Coin Bonus Window

.headersize 0x800F65E0-0x24C390 //Luigi Engine Room Segment

.org 0x800F8BB0
addiu a0, r0, ((SCREEN_W/2)-95) //Fix X Position of 20 Coin Bonus Window

.org 0x800F8BB4
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of 10 Coin Bonus Window

.org 0x800F8F64
addiu a0, r0, ((SCREEN_W/2)-76) //Fix X Position of Door Too Few Coins Window

.org 0x800F90A0
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Door Open Window

.headersize 0x800F65E0-0x24FA80 //Mario Rainbow Castle Segment

.org 0x800F7C6C
addiu a0, r0, ((SCREEN_W/2)-95) //Fix X Position of 20 Coin Bonus Window

.org 0x800F7C70
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of 10 Coin Bonus Window

.headersize 0x800F65E0-0x2518D0 //Bowser Magma Mountain Segment

.org 0x800F7680
addiu a0, r0, ((SCREEN_W/2)-66) //X Position of Dont Have 10 Coins Text

.org 0x800F7A60
addiu a2, r0, (SCREEN_W/2) //X Position of Bowser Magma Mountain Red Filter

.org 0x800F7A70
li.u a2, (SCREEN_W_FLOAT/8) //Width of Bowser Magma Mountain Red Filter

.org 0x800F8090
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Blue to Red Space Window

.org 0x800F81E0
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Nothing Happened Window

.org 0x800F82D4
addiu a0, r0, ((SCREEN_W/2)-95) //Fix X Position of 20 Coin Bonus Window

.org 0x800F82D8
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of 10 Coin Bonus Window

.org 0x800F8680
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Return to Normal Window

.headersize 0x800F65E0-0x254450 //Eternal Star Segment

.org 0x800F69C8
li.u at, (SCREEN_W_FLOAT*4) //Fix Koopa Viewport Width

.org 0x800F6A04
li.u at, (((SCREEN_W_FLOAT/2)-100)*4) //Fix Koopa Viewport Offset

.org 0x800F6A64
addiu a0, r0, ((SCREEN_W/2)-85) //Fix X Position of Koopa Window

.org 0x800F8460
addiu a0, r0, ((SCREEN_W/2)-84) //Fix X Position of Warp Course Message

.headersize 0x800F65E0-0x256FF0 //Tutorial Board Segment

.org 0x800F78D0
addiu a1, r0, ((SCREEN_W/2)-60) //Fix X Position of Tutorial Blue Space Icon

.org 0x800F7954
addiu a1, r0, ((SCREEN_W/2)-60) //Fix X Position of Tutorial Red Space Icon

.org 0x800F79D8
addiu a1, r0, ((SCREEN_W/2)-60) //Fix X Position of Tutorial Minigame Space Icon

.org 0x800F7A5C
addiu a1, r0, ((SCREEN_W/2)-60) //Fix X Position of Tutorial Question Space Icon

.org 0x800F7B00
addiu a1, r0, ((SCREEN_W/2)-60) //Fix X Position of Tutorial Chance Space Icon

.org 0x800F7B84
addiu a1, r0, ((SCREEN_W/2)-60) //Fix X Position of Tutorial Bowser Space Icon

.org 0x800F7C08
addiu a1, r0, ((SCREEN_W/2)-60) //Fix X Position of Tutorial Mushrrom Space Icon

.org 0x800F828C
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Pause Screen Filter

.org 0x800F829C
li.u a2, (SCREEN_W_FLOAT/8) //Fix X Scale of Pause Screen Filter

.org 0x800F82DC
addiu a0, r0, ((SCREEN_W/2)-87) //Fix X Position of Pause Screen Window

.headersize 0x800F65E0-0x2592A0 //Board Last 5 Turns Segment

.org 0x800F6728
addiu a2, r0, 20 //Slow Down Koopa in Last 5 Turns

.org 0x800F6738
addiu a0, r0, 10 //Slow Down Koopa Wait in Last 5 Turns

.org 0x800F6774
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of 1st Koopa Textbox

.org 0x800F6988
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Koopa Ranking Textbox

.org 0x800F6E34
addiu a0, r0, ((SCREEN_W/2)-95) //Fix X Position of Koopa Last 5 Event Textbox

.org 0x800F705C
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Board Last 5 Turns

.org 0x800F7068
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Board Last 5 Turns

.org 0x800F7130
.float ((SCREEN_W_FLOAT*500)/320) //Fix Start X Position of Koopa in Last 5 Turns

.headersize 0x800F65E0-0x259EB0 //Board Results Segment

.org 0x800F88C0
addiu a0, r0, ((SCREEN_W/2)-30) //Fix X Position of Continue Window

.org 0x800F88C4
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Continue Extend Window

.org 0x800F8ED4
addiu s1, r0, SCREEN_W //Fix Blank Results Face Offset

.org 0x800F8EF4
addiu a2, a2, SCREEN_W //Fix Blank Results Header Offset

.org 0x800F8F1C
addiu a2, r0, SCREEN_W //Fix Blank Results Offset

.org 0x800F9410
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Continue Extend Window

.org 0x800F9588
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Continue Extend Window

.org 0x800FB59C
slti v0, s2, -SCREEN_W //Fix Slide End of Results

.org 0x800FB6E0
slti v0, s2, -SCREEN_W //Fix Slide End of Results

.org 0x800FB618
addiu s0, s2, (((SCREEN_W*3)/2)-110) //Fix X Offset of Bank Icons

.org 0x800FB63C
addiu s0, s2, (((SCREEN_W*3)/2)-80) //Fix X Offset of Bank Cross

.org 0x800FB670
addiu s0, s2, (((SCREEN_W*3)/2)-60) //Fix X Offset of Bank Number

.org 0x800FB6E8
addiu s0, s2, (((SCREEN_W*3)/2)-110) //Fix X Offset of Bank Icons

.org 0x800FBF48
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Board Results

.org 0x800FBF54
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Board Results

.org 0x800FC0E8
.dh ((SCREEN_W/2)-24) //Fix X Position of Board Results Cursor Column 1

.org 0x800FC0EC
.dh ((SCREEN_W/2)+19) //Fix X Position of Board Results Cursor Column 2

.org 0x800FC0F0
.dh ((SCREEN_W/2)+62) //Fix X Position of Board Results Cursor Column 3

.org 0x800FC0F4
.dh ((SCREEN_W/2)+107) //Fix X Position of Board Results Cursor Column 4

.org 0x800FC0F8
.dh ((SCREEN_W/2)-24) //Fix X Position of Board Results Column 1

.org 0x800FC0FC
.dh ((SCREEN_W/2)+19) //Fix X Position of Board Results Column 2

.org 0x800FC100
.dh ((SCREEN_W/2)+62) //Fix X Position of Board Results Column 3

.org 0x800FC104
.dh ((SCREEN_W/2)+107) //Fix X Position of Board Results Column 4

.org 0x800FC108
.dh ((SCREEN_W/2)-54) //Fix X Position of Board Results Text Column 1

.org 0x800FC10C
.dh ((SCREEN_W/2)-10) //Fix X Position of Board Results Text Column 2

.org 0x800FC110
.dh ((SCREEN_W/2)+34) //Fix X Position of Board Results Text Column 3

.org 0x800FC114
.dh ((SCREEN_W/2)+78) //Fix X Position of Board Results Text Column 4

.org 0x800FC118
.dh ((SCREEN_W/2)-84) //Fix X Position of Board Results Player 1 Name

.org 0x800FC11C
.dh ((SCREEN_W/2)-84) //Fix X Position of Board Results Player 2 Name

.org 0x800FC120
.dh ((SCREEN_W/2)-84) //Fix X Position of Board Results Player 3 Name

.org 0x800FC124
.dh ((SCREEN_W/2)-84) //Fix X Position of Board Results Player 4 Name

.org 0x800FC128
.dh ((SCREEN_W/2)-124) //Fix X Position of Board Results Player 1 Face

.org 0x800FC12C
.dh ((SCREEN_W/2)-124) //Fix X Position of Board Results Player 2 Face

.org 0x800FC130
.dh ((SCREEN_W/2)-124) //Fix X Position of Board Results Player 3 Face

.org 0x800FC134
.dh ((SCREEN_W/2)-124) //Fix X Position of Board Results Player 4 Face

.org 0x800FC138
.dh ((SCREEN_W/2)-53) //Fix X Position of Board Results Logo

.org 0x800FC13C
.dh ((SCREEN_W/2)+80) //Fix X Position of Board Results Play Mode

.org 0x800FC140
.dh ((SCREEN_W/2)-40) //Fix X Position of Board Results Left Arrow

.org 0x800FC144
.dh ((SCREEN_W/2)+120) //Fix X Position of Board Results Right Arrow

.org 0x800FC234
.dh (SCREEN_W/2) //Fix X Position of Board Results Header

.org 0x800FC238
.dh ((SCREEN_W/2)-100) //Fix X Position of Board Results P1 Rank

.org 0x800FC23C
.dh ((SCREEN_W/2)-100) //Fix X Position of Board Results P2 Rank

.org 0x800FC240
.dh ((SCREEN_W/2)-100) //Fix X Position of Board Results P3 Rank

.org 0x800FC244
.dh ((SCREEN_W/2)-100) //Fix X Position of Board Results P4 Rank

.org 0x800FC248
.dh ((SCREEN_W/2)-80) //Fix X Position of Stadium Results P1 Rank

.org 0x800FC24C
.dh ((SCREEN_W/2)-80) //Fix X Position of Stadium Results P2 Rank

.org 0x800FC250
.dh ((SCREEN_W/2)-80) //Fix X Position of Stadium Results P3 Rank

.org 0x800FC254
.dh ((SCREEN_W/2)-80) //Fix X Position of Stadium Results P4 Rank

.org 0x800FC258
.dh ((SCREEN_W/2)-50) //Fix X Position of Board Results P1 Face

.org 0x800FC25C
.dh ((SCREEN_W/2)-50) //Fix X Position of Board Results P2 Face

.org 0x800FC260
.dh ((SCREEN_W/2)-50) //Fix X Position of Board Results P3 Face

.org 0x800FC264
.dh ((SCREEN_W/2)-50) //Fix X Position of Board Results P4 Face

.org 0x800FC268
.dh ((SCREEN_W/2)-10) //Fix X Position of Stadium Results P1 Face

.org 0x800FC26C
.dh ((SCREEN_W/2)-10) //Fix X Position of Stadium Results P2 Face

.org 0x800FC270
.dh ((SCREEN_W/2)-10) //Fix X Position of Stadium Results P3 Face

.org 0x800FC274
.dh ((SCREEN_W/2)-10) //Fix X Position of Stadium Results P4 Face

.org 0x800FC278
.dh ((SCREEN_W/2)-9) //Fix X Position of Board Results P1 Star

.org 0x800FC27C
.dh ((SCREEN_W/2)-9) //Fix X Position of Board Results P2 Star

.org 0x800FC280
.dh ((SCREEN_W/2)-9) //Fix X Position of Board Results P3 Star

.org 0x800FC284
.dh ((SCREEN_W/2)-9) //Fix X Position of Board Results P4 Star

.org 0x800FC288
.dh ((SCREEN_W/2)+66) //Fix X Position of Board Results P1 Coin

.org 0x800FC28C
.dh ((SCREEN_W/2)+66) //Fix X Position of Board Results P2 Coin

.org 0x800FC290
.dh ((SCREEN_W/2)+66) //Fix X Position of Board Results P3 Coin

.org 0x800FC294
.dh ((SCREEN_W/2)+66) //Fix X Position of Board Results P4 Coin

.org 0x800FC298
.dh ((SCREEN_W/2)+46) //Fix X Position of Stadium Results P1 Coin

.org 0x800FC29C
.dh ((SCREEN_W/2)+46) //Fix X Position of Stadium Results P2 Coin

.org 0x800FC2A0
.dh ((SCREEN_W/2)+46) //Fix X Position of Stadium Results P3 Coin

.org 0x800FC2A4
.dh ((SCREEN_W/2)+46) //Fix X Position of Stadium Results P4 Coin

.org 0x800FC2A8
.dh ((SCREEN_W/2)+14) //Fix X Position of Board Results P1 Coin Number

.org 0x800FC2AC
.dh ((SCREEN_W/2)+14) //Fix X Position of Board Results P2 Coin Number

.org 0x800FC2B0
.dh ((SCREEN_W/2)+14) //Fix X Position of Board Results P3 Coin Number

.org 0x800FC2B4
.dh ((SCREEN_W/2)+14) //Fix X Position of Board Results P4 Coin Number

.org 0x800FC2B8
.dh ((SCREEN_W/2)+90) //Fix X Position of Board Results P1 Star Number

.org 0x800FC2BC
.dh ((SCREEN_W/2)+90) //Fix X Position of Board Results P2 Star Number

.org 0x800FC2C0
.dh ((SCREEN_W/2)+90) //Fix X Position of Board Results P3 Star Number

.org 0x800FC2C4
.dh ((SCREEN_W/2)+90) //Fix X Position of Board Results P4 Star Number

.org 0x800FC2C8
.dh ((SCREEN_W/2)+14) //Fix X Position of Stadium Results P1 Star Number

.org 0x800FC2CC
.dh ((SCREEN_W/2)+14) //Fix X Position of Stadium Results P2 Star Number

.org 0x800FC2D0
.dh ((SCREEN_W/2)+14) //Fix X Position of Stadium Results P3 Star Number

.org 0x800FC2D4
.dh ((SCREEN_W/2)+14) //Fix X Position of Stadium Results P4 Star Number

.org 0x800FC2D8
.dh ((SCREEN_W/2)+70) //Fix X Position of Stadium Results P1 Coin Number

.org 0x800FC2DC
.dh ((SCREEN_W/2)+70) //Fix X Position of Stadium Results P2 Coin Number

.org 0x800FC2E0
.dh ((SCREEN_W/2)+70) //Fix X Position of Stadium Results P3 Coin Number

.org 0x800FC2E4
.dh ((SCREEN_W/2)+70) //Fix X Position of Stadium Results P4 Coin Number

.headersize 0x800F65E0-0x25FC70 //Board Ending Segment

.org 0x800F6734
addiu a2, r0, ((SCREEN_W/2)-82) //X Position of You Are The Text

.org 0x800F6758
addiu a2, r0, ((SCREEN_W/2)+56) //X Position of Superstar Text

.org 0x800F6CA8
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Board Ending

.org 0x800F6CB4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Board Ending

.org 0x800F8FA0
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Background Cover in Board 2 Ending

.org 0x800FC0E4
li.u a1, ((SCREEN_W_FLOAT*600)/320) //Fix End X Position of Characters in Board 3 Ending

.org 0x800FC18C
li.u a1, ((SCREEN_W_FLOAT*600)/320) //Fix End X Position of Character Shadow in Board 3 Ending

.org 0x801005E8
addiu a0, r0, 1 //Enable Clear in Board 4 Ending Fireworks

.org 0x80100B98
addiu a0, r0, 1 //Enable Clear in Board 4 Ending Walk

.org 0x80101A1C
addiu a0, r0, 1 //Enable Clear in Board 4 Ending Cannon

.org 0x80101A38
//Fix End X Position of Cannon Shot in Board 4
li.u a1, ((SCREEN_W_FLOAT*850)/320)
li.l a1, ((SCREEN_W_FLOAT*850)/320)

.org 0x8010218C
li.u at, -((SCREEN_W_FLOAT*400)/320) //Fix Koopa Walk Distance in Board 4 Ending

.org 0x8010353C
nop //Disable Camera Wrong Centering in Board 5 Ending

.org 0x80103D24
nop //Disable Camera Wrong Centering in Board 5 Ending

.org 0x80109228
lui a1, hi(ZBUF_ADDR+0x80000000) //High Part of Z Buffer Address in Board 7 Ending
addiu a1, a1, lo(ZBUF_ADDR+0x80000000) //Low Part of Z Buffer Address in Board 7 Ending

.org 0x80109244
ori a2, a2, (SCREEN_W-1) //Fix Framebuffer Width in Board 7 Ending

.org 0x80109C1C
nop //Disable Camera Shaking in Board 7 Ending

.org 0x80109C44
nop //Disable Camera Stabilize in Board 7 Ending

.org 0x80109D28
nop //Disable Camera Shaking in Board 7 Ending

.org 0x80109D50
nop //Disable Camera Stabilize in Board 7 Ending

.org 0x8010C088
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Light in Board 8 Ending

.org 0x8010C500
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Board 8 Ending

.org 0x8010C50C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Board 8 Ending

.org 0x8010DA98
li.u at, (SCREEN_W_FLOAT/2) //Fix Center X Position of Eternal Star Pieces

.org 0x8010DE64
.float -((SCREEN_W_FLOAT*400)/320) //Fix X Position of Left Character in Board 1 Ending

.org 0x8010DE7C
.float ((SCREEN_W_FLOAT*420)/320) //Fix X Position of Right Character in Board 1 Ending

.org 0x8010EB3C
.float -((SCREEN_W_FLOAT*2200)/320) //Fix Start X Position of Star in Board 6 Ending

.org 0x8010EB54
.float ((SCREEN_W_FLOAT*2200)/320) //Fix End X Position of Star in Board 6 Ending

.org 0x8010ECE0
.float (SCREEN_W_FLOAT*2) //Fix Viewport 1 Width in Board 8 Ending

.org 0x8010ECEC
.float (SCREEN_W_FLOAT*2) //Fix Viewport 1 X Position in Board 8 Ending

.org 0x8010ECD0
.dw (0xF6000000|((SCREEN_W-1) << 14)|((SCREEN_H-1) << 2)) //Upper Half of Z Clear Command

.org 0x8010EE40
.float ((SCREEN_W_FLOAT/2)-63) //Fix X Position of Piece 1 Sprite in Board 8 Ending

.org 0x8010EE48
.float ((SCREEN_W_FLOAT/2)+7) //Fix X Position of Piece 2 Sprite in Board 8 Ending

.org 0x8010EE50
.float ((SCREEN_W_FLOAT/2)+75) //Fix X Position of Piece 3 Sprite in Board 8 Ending

.org 0x8010EE58
.float ((SCREEN_W_FLOAT/2)-83) //Fix X Position of Piece 4 Sprite in Board 8 Ending

.org 0x8010EE60
.float ((SCREEN_W_FLOAT/2)+3) //Fix X Position of Piece 5 Sprite in Board 8 Ending

.org 0x8010EE68
.float ((SCREEN_W_FLOAT/2)+68) //Fix X Position of Piece 6 Sprite in Board 8 Ending

.org 0x8010EFE8
.float -((SCREEN_W_FLOAT*1200)/320) //Fix Start X Position of Cheep Cheep in Board 3 Ending

.org 0x8010EFF4
.float ((SCREEN_W_FLOAT*1350)/320) //Fix End X Position of Cheep Cheep in Board 3 Ending

.org 0x8010F1C0
.float ((SCREEN_W_FLOAT/2)-144) //Fix X Position of Board 4 Sprite 1

.org 0x8010F1C8
.float ((SCREEN_W_FLOAT/2)-92) //Fix X Position of Board 4 Sprite 2

.org 0x8010F1D0
.float (SCREEN_W_FLOAT/2) //Fix X Position of Board 4 Sprite 3

.org 0x8010F1D8
.float ((SCREEN_W_FLOAT/2)+92) //Fix X Position of Board 4 Sprite 4

.org 0x8010F1E0
.float ((SCREEN_W_FLOAT/2)+144) //Fix X Position of Board 4 Sprite 5

.org 0x8010F420
.float -((SCREEN_W_FLOAT*1090)/320) //Fix Start X Position of Cloud in Board 6 Ending

.org 0x8010F448
.float -((SCREEN_W_FLOAT*1090)/320) //Fix Start X Position of Lakitu in Board 6 Ending

.org 0x8010F4D4
.float ((SCREEN_W_FLOAT*1030)/320) //Fix End X Position of Lakitu in Board 6 Ending

.org 0x8010F694
.float -((SCREEN_W_FLOAT*600)/320) //Fix X Position of Toad in Board 7 Ending

.org 0x8010F6A8
.float -((SCREEN_W_FLOAT*700)/320) //Fix X Position of Koopa in Board 7 Ending

.org 0x8010F6BC
.float ((SCREEN_W_FLOAT*790)/320) //Fix X Position of Boo in Board 7 Ending

.headersize 0x800F65E0-0x278ED0 //Board Ending Scene Segment

.org 0x800F7C94
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Star Announcment

.org 0x800F7FF0
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Coin Announcment

.org 0x800F81C0
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Bonus Star Announcment

.org 0x800F821C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Game Star Announcment

.org 0x800F835C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Game Star Winner Announcment

.org 0x800F85CC
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Coin Star Announcment

.org 0x800F8718
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Coin Star Winner Announcment

.org 0x800F8988
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Happening Star Announcment

.org 0x800F8AD4
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Happening Star Winner Announcment

.org 0x800F8EC0
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Ending Tie Announcment

.org 0x800F9300
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board True Winner Announcment

.org 0x800F9560
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Final Winner Announcment

.org 0x800F96C8
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Final Winner Name Announcment

.org 0x800F97D8
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Star Collected Announcment

.org 0x800F9E20
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Board Ending

.org 0x800F9E2C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Board Ending

.headersize 0x800F65E0-0x27CB30 //Board Ending 2 Scene Segment

.org 0x800F7E5C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Star Announcment

.org 0x800F81B8
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Coin Announcment

.org 0x800F8388
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Bonus Star Announcment

.org 0x800F83E4
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Game Star Announcment

.org 0x800F8524
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Game Star Winner Announcment

.org 0x800F8764
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Coin Star Announcment

.org 0x800F88B0
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Coin Star Winner Announcment

.org 0x800F8AF0
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Happening Star Announcment

.org 0x800F8C3C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Happening Star Winner Announcment

.org 0x800F8FD0
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Ending Tie Announcment

.org 0x800F9410
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board True Winner Announcment

.org 0x800F967C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Final Winner Announcment

.org 0x800F982C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Board Final Winner Name Announcment

.org 0x800FA3E8
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Board Ending

.org 0x800FA3F4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Board Ending

.org 0x800FA65C
.dh (SCREEN_W/2) //Fix X Position of You Are The Winner Text

.headersize 0x800F65E0-0x280C80 //Star Scene Segment

.org 0x800F6D10
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Too Many Stars Textbox

.org 0x800F6D90
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Star Choice Textbox

.org 0x800F6DDC
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Star Choice Face Texbox

.org 0x800F6E88
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Star Cancel Texbox

.org 0x800F6EA4
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Star Give Texbox

.org 0x800F6F18
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Star Give End Texbox

.org 0x800F739C
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Star Scene

.org 0x800F73A8
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Star Scene

.headersize 0x800F65E0-0x281D40 //Bowser Pass Scene Segment

.org 0x800F6864
addiu a0, r0, ((SCREEN_W/2)-110) //Fix No Coins Textbox in Bowser Pass Scene

.org 0x800F6900
addiu a0, r0, ((SCREEN_W/2)-110) //Fix Too Few Coins Textbox in Bowser Pass Scene

.org 0x800F698C
addiu a0, r0, ((SCREEN_W/2)-110) //Fix 20 Coins Textbox in Bowser Pass Scene

.org 0x800F6A70
addiu a0, r0, ((SCREEN_W/2)-110) //Fix Final Done Textbox in Bowser Pass Scene

.org 0x800F6E10
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Bowser Pass Scene

.org 0x800F6E1C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Bowser Pass Scene

.headersize 0x800F65E0-0x282820 //Bowser Scene Segment

.org 0x800F67B8
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Bowser Coin Take Textbox

.org 0x800F6974
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Coin Take Wait Textbox

.org 0x800F6A00
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Bowser Chance Time Textbox

.org 0x800F6B18
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Bowser Revolution First Textbox

.org 0x800F6EE0
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Revolution End Textbox

.org 0x800F7060
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Bowser Bash And Cash Textbox

.org 0x800F7174
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Bash And Cash Steal Textbox

.org 0x800F7394
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Bash And Cash End Textbox

.org 0x800F7440
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Bowser Face Lift Textbox

.org 0x800F757C
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Face Lift Steal Textbox

.org 0x800F7584
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Bowser Face Lift Steal Textbox

.org 0x800F7598
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Bowser Face Lift Steal Textbox

.org 0x800F75EC
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Bowser Face Lift Steal Textbox

.org 0x800F76B4
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Bowser Face Lift Steal Textbox

.org 0x800F7B70
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Face Lift End Textbox

.org 0x800F7C18
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Bowser Tug of War Textbox

.org 0x800F7D50
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Bowser Tug of War Steal Textbox

.org 0x800F8070
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Tug of War End Textbox

.org 0x800F8118
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Bowser Balloon Burst Textbox

.org 0x800F8264
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Bowser Balloon Burst Steal Textbox

.org 0x800F8580
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Balloon Burst End Textbox

.org 0x800F8678
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of 1st Bowser Textbox

.org 0x800F8728
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Wait Textbox

.org 0x800F8874
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Star Textbox

.org 0x800F8E1C
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Bowser Scene

.org 0x800F8E28
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Bowser Scene


.headersize 0x800F65E0-0x285230 //Whomp Scene Segment

.org 0x800F6968
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Whomp Path Textbox

.org 0x800F6A7C
addiu a0, r0, ((SCREEN_W/2)-20) //Fix X Position of Whomp Dont Move Textbox

.org 0x800F6AB8
addiu a0, r0, ((SCREEN_W/2)-30) //Fix X Position of Whomp Move Textbox

.org 0x800F6E3C
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Whomp Scene

.org 0x800F6E48
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Whomp Scene

.headersize 0x800F65E0-0x285B70 //Bowser Statue Scene Segment

.org 0x800F6710
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Looking For Treasure Textbox

.org 0x800F6770
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of No Coins Textbox

.org 0x800F67E8
addiu a0, r0, ((SCREEN_W/2)-105) //Fix X Position of Looking For Treasure Textbox

.org 0x800F67EC
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Looking For Treasure Textbox

.org 0x800F684C
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Too Few Coins Textbox

.org 0x800F6938
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Exit Textbox

.org 0x800F6A9C
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of 10 Coin Cost Textbox

.org 0x800F6B70
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Useless Bowser Statue Textbox

.org 0x800F7020
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Whomp Scene

.org 0x800F702C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Whomp Scene

.headersize 0x800F65E0-0x286700 //Bowser Cake Scene Segment

.org 0x800F6710
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Looking For Sweets Textbox

.org 0x800F6770
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of No Coins Textbox

.org 0x800F67E8
addiu a0, r0, ((SCREEN_W/2)-105) //Fix X Position of Looking For Sweets Textbox

.org 0x800F6848
addiu a0, r0, ((SCREEN_W/2)-105) //Fix X Position of Too Few Coins Textbox

.org 0x800F6934
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Exit Textbox

.org 0x800F6A98
addiu a0, r0, ((SCREEN_W/2)-105) //Fix X Position of 20 Coin Cost Textbox

.org 0x800F6B6C
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Useless Bowser Cake Textbox

.org 0x800F7030
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Bowser Cake Scene

.org 0x800F703C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Bowser Cake Scene

.headersize 0x800F65E0-0x2872A0 //Goomba Seed Scene Segment

.org 0x800F6E40
addiu a0, r0, ((SCREEN_W/2)-80) //Fix Goomba Seed Too Few Coins Window

.org 0x800F6E94
addiu a0, r0, ((SCREEN_W/2)-45) //Fix Goomba Seed Question Window

.org 0x800F6F44
addiu a0, r0, ((SCREEN_W/2)-45) //Fix Goomba Seed Cancel Window

.org 0x800F72D0
addiu a2, r0, ((SCREEN_W/2)-60) //Fix X Position of Explode Effect in Goomba Seed

.org 0x800F7418
addiu a0, r0, ((SCREEN_W/2)-5) //Fix Goomba Seed Pretty Flower Window

.org 0x800F74A0
addiu a0, r0, ((SCREEN_W/2)-5) //Fix Goomba Seed Flower Steal Window

.org 0x800F7788
addiu a2, r0, (SCREEN_W/2) //Fix X Poison of Cake Cover

.org 0x800F7A28
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Goomba Seed Scene

.org 0x800F7A34
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Goomba Seed Scene

.org 0x800F7B04
.float ((SCREEN_W_FLOAT*415)/320) //Fix Rest X Position of Goomba

.headersize 0x800F65E0-0x2888A0 //Flower Lottery Scene Segment

.org 0x800F6AA4
addiu a0, r0, ((SCREEN_W/2)-125) //Fix X Position of No Coins Flower Lottery

.org 0x800F6B08
addiu a0, r0, ((SCREEN_W/2)-125) //Fix X Position of Too Few Coins Flower Lottery

.org 0x800F6B84
addiu a0, r0, ((SCREEN_W/2)-125) //Fix X Position of 10 Coinb Fee Flower Lottery

.org 0x800F6BF0
addiu a0, r0, ((SCREEN_W/2)-20) //Fix X Position of Seed Pick Window Flower Lottery

.org 0x800F6C0C
addiu a0, r0, ((SCREEN_W/2)-20) //Fix X Position of Seed Pick Window Flower Lottery

.org 0x800F6E70
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Seed Result Wait Flower Lottery

.org 0x800F7034
addiu a2, r0, ((SCREEN_W/2)-60) //Fix X Position of Explode Effect in Flower Lottery

.org 0x800F7124
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Seed Star Lottery

.org 0x800F7128
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Seed Bowser Lottery

.org 0x800F7218
addiu a0, r0, ((SCREEN_W/2)-110) //Fix X Position of Seed Toad Lottery

.org 0x800F7404
addiu a2, r0, (SCREEN_W/2) //Fix X Poison of Cake Cover

.org 0x800F7714
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Flower Lottery Scene

.org 0x800F7720
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Flower Lottery Scene

.headersize 0x800F65E0-0x289BA0 //Piranha Plant Scene Segment

.org 0x800F6844
addiu a0, r0, ((SCREEN_W/2)-50) //Fix X Position of No Star Textbox

.org 0x800F7104
addiu a2, r0, (SCREEN_W/2) //Fix X Poison of Cake Cover

.org 0x800F7444
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Piranha Plant Scene

.org 0x800F7450
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Piranha Plant Scene

.org 0x800F7544
.float ((SCREEN_W_FLOAT*450)/320) //Fix Resting X Position of Goomba

.headersize 0x800F65E0-0x28ABA0 //Thwomp Toll Scene Segment

.org 0x800F6B74
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Cant Afford Toll Textbox

.org 0x800F6B78
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Blocked Toll Textbox

.org 0x800F6C34
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Toll Question Textbox

.org 0x800F6D48
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Toll Window

.org 0x800F6D4C
addiu a0, r0, ((SCREEN_W/2)-20) //Fix X Position of No Toll Window

.org 0x800F7254
addiu a0, r0, ((SCREEN_W/2)-20) //Fix X Position of Toll Can Pass Window

.org 0x800F7578
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Thwomp Toll Scene

.org 0x800F7584
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Thwomp Toll Scene

.headersize 0x800F65E0-0x28BC70 //Toad Steal Scene Segment

.org 0x800F727C
addiu a0, r0, ((SCREEN_W/2)-64) //Fix X Position of Star Switch Textbox

.org 0x800F778C
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Toad Steal Scene

.org 0x800F7798
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Toad Steal Scene

.org 0x800F789C
.float -((SCREEN_W_FLOAT*1500)/320) //Fix Start X Position of Fish in Toad Steal

.headersize 0x800F65E0-0x28CFF0 //Bowser Swim Scene Segment

.org 0x800F685C
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Yoshi Help Textbox

.org 0x800F68BC
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of No Coins Textbox

.org 0x800F6944
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Yoshi Help Textbox

.org 0x800F6948
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Yoshi Help Textbox

.org 0x800F69A8
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of No Coins Textbox

.org 0x800F6A94
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of See You Textbox

.org 0x800F6C00
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Tube Textbox

.org 0x800F6F28
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Bowser Tube Broke Textbox

.org 0x800F7474
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Bowser Swim Scene

.org 0x800F7480
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Bowser Swim Scene

.headersize 0x800F65E0-0x28E030 //Load Cannon Scene Segment

.org 0x800F66E0
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Load Cannon Textbox

.org 0x800F6A7C
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Load Cannon Scene

.org 0x800F6A88
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Load Cannon Scene

.headersize 0x800F65E0-0x28E630 //Move Cannon Scene Segment

.org 0x800F66E0
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Move Cannon Textbox

.org 0x800F6820
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Move Cannon Order Textbox

.org 0x800F6B58
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Move Cannon Scene

.org 0x800F6B64
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Move Cannon Scene

.headersize 0x800F65E0-0x28ECA0 //Fly Guy Scene Segment

.org 0x800F74B8
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Bring Character Textbox

.org 0x800F74BC
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Fly Guy Choice Textbox

.org 0x800F7600
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of See You Later Textbox

.org 0x800F7678
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Fly Guy Bring Textbox

.org 0x800F769C
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Fly Guy Get Ready Textbox

.org 0x800F79E8
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Just A Second Textbox

.org 0x800F7FCC
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Fly Guy Scene

.org 0x800F7FD8
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Fly Guy Scene

.headersize 0x800F65E0-0x2908F0 //Bowser Cannon Segment

.org 0x800F670C
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of No Coins Bowser Cannon Textbox

.org 0x800F6770
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Bowser Cannon Look Behind Textbox

.org 0x800F6914
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Bowser Cannon Look Behind Textbox

.org 0x800F69C0
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Cannon Almost Ready Textbox

.org 0x800F6BB4
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Cannon Blastoff Textbox

.org 0x800F6EC8
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Bowser Cannon

.org 0x800F6ED4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Bowser Cannon

.headersize 0x800F65E0-0x291360 //Bowser Coin Machine Segment

.org 0x800F6730
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of No Coin Textbox

.org 0x800F67C0
addiu a0, r0, ((SCREEN_W/2)-110) //Fix X Position of Take Coins Textbox

.org 0x800F6B20
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Coin For You Textbox

.org 0x800F6C94
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of 20 Coin Cost Textbox

.org 0x800F70E8
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Bowser Coin Machine

.org 0x800F70F4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Bowser Coin Machine

.headersize 0x800F65E0-0x292020 //Door Robot Segment

.org 0x800F71DC
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Door Robot Choice Window

.org 0x800F72F4
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Door Robot Cancel Window

.org 0x800F7388
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Door Robot Move Window

.org 0x800F7684
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Door Robot

.org 0x800F7690
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Door Robot

.headersize 0x800F65E0-0x293260 //Board 6 Star Switch Segment

.org 0x800F6D10
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Board 6 Star Switch

.org 0x800F6D1C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Board 6 Star Switch

.headersize 0x800F65E0-0x293A70 //Board 6 Star Get Segment

.org 0x800F6C10
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Too Many Stars in Board 6 Star Get

.org 0x800F6C6C
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Cant Buy Star in Board 6 Star Get

.org 0x800F6D58
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Star Buy Window in Board 6 Star Get

.org 0x800F6E00
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Star Cancel Window in Board 6 Star Get

.org 0x800F6E1C
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Star Get Window in Board 6 Star Get

.org 0x800F6E90
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Toad Star Window in Board 6 Star Get

.org 0x800F7228
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of No Coins Textbox in Board 6 Ztar Get

.org 0x800F7310
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Take All Coins Textbox in Board 6 Ztar Get

.org 0x800F73FC
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Fake Star Textbox in Board 6 Ztar Get

.org 0x800F7E1C
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Board 6 Star Get

.org 0x800F7E28
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Board 6 Star Get

.headersize 0x800F65E0-0x295450 //Bowser Junction Segment

.org 0x800F670C
addiu a0, r0, ((SCREEN_W/2)-60) //Fix Bowser Junction Warning Textbox

.org 0x800F6A28
addiu a0, r0, ((SCREEN_W/2)-80) //Fix Bowser Junction Star Path Textbox

.org 0x800F6A2C
addiu a0, r0, ((SCREEN_W/2)-60) //Fix Bowser Junction Bowser Path Textbox

.org 0x800F6E30
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Bowser Junction

.org 0x800F6E3C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Bowser Junction

.headersize 0x800F65E0-0x295E40 //Bowser Shortcut Segment

.org 0x800F6904
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Try Shortcut Window

.org 0x800F6C68
addiu a0, r0, ((SCREEN_W/2)-64) //Fix X Position of Shortcut Success Window

.org 0x800F6C6C
addiu a0, r0, ((SCREEN_W/2)-70) //Fix X Position of Shortcut Fail Window

.org 0x800F6DA4
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Cancel Shortcut Window

.org 0x800F7144
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Bowser Shortcut

.org 0x800F7150
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Bowser Shortcut

.headersize 0x800F65E0-0x296B70 //Board 7 Bowser Steal Segment

.org 0x800F674C
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Star Steal Window

.org 0x800F6B04
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Coin Steal Window

.org 0x800F6C4C
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of See You Window

.org 0x800F6C74
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Choose Steal Window

.org 0x800F6C8C
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of No Steal Window

.org 0x800F6E60
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Star Steal Choice Window

.org 0x800F6E64
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Coin Steal Choice Window

.org 0x800F74E8
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Board 7 Bowser Steal

.org 0x800F74F4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Board 7 Bowser Steal

.headersize 0x800F65E0-0x297BE0 //Bowser Return to Start Segment

.org 0x800F66E0
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Bowser Return to Start Window

.org 0x800F68E8
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Bowser Return to Start

.org 0x800F68F4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Bowser Return to Start

.headersize 0x800F65E0-0x297FB0 //Board 8 Bowser Steal Segment

.org 0x800F6720
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Star Steal Window

.org 0x800F6AC4
addiu a0, r0, ((SCREEN_W/2)-120) //Fix X Position of Coin Steal Window

.org 0x800F6AC8
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of No Steal Window

.org 0x800F6C70
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Back to Start Window

.org 0x800F6FB8
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Board 8 Bowser Steal

.org 0x800F6FC4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Board 8 Bowser Steal

.headersize 0x800F65E0-0x298AE0 //Board 8 Star Get Segment

.org 0x800F6F58
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Star Battle Win Window

.org 0x800F7308
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Star Battle Lose Window

.org 0x800F7740
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Too Many Stars Window

.org 0x800F7798
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Cant Afford Star Window

.org 0x800F77C0
addiu a0, r0, ((SCREEN_W/2)-50) //Fix X Position of Star Buy Window

.org 0x800F7864
addiu a0, r0, ((SCREEN_W/2)-40) //Fix X Position of Star Cancel Window

.org 0x800F78E0
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Star Battle Window

.org 0x800F7D20
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Board 8 Star Get

.org 0x800F7D2C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Board 8 Star Get

.headersize 0x800F65E0-0x29A400 //Koopa 10 Coins Segment

.org 0x800F67A0
addiu a0, r0, ((SCREEN_W/2)-80) //Fix 10 Coin Bonus Window

.org 0x800F67A4
addiu a0, r0, ((SCREEN_W/2)-110) //Fix 10 Coin Player Bonus Window

.org 0x800F6BA8
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Koopa 10 Coins

.org 0x800F6BB4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Koopa 10 Coins

.headersize 0x800F65E0-0x29AB30 //Koopa 20 Coins Segment

.org 0x800F670C
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of 20 Coin Bonus Window

.org 0x800F6830
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Koopa Relax Window

.org 0x800F6BB4
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Koopa 20 Coins

.org 0x800F6BC0
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Koopa 20 Coins

.org 0x800F6E10
.float -((SCREEN_W_FLOAT*500)/320) //Fix End X Position of Koopa Walk

.headersize 0x800F65E0-0x29B410 //Opening Segment

.org 0x800F6C18
addiu v0, r0, SCREEN_W //Fix Background Width in Opening

.org 0x800FAB20
addiu v0, r0, SCREEN_W //Fix Background Width in Opening

.org 0x800FC3E8
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Opening

.org 0x800FC3F4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Opening

.org 0x800FC430
li.u a3, SCREEN_W_FLOAT //Fix Scissor Width in Opening

.org 0x800FC434
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport X Position in Opening

.org 0x800FC468
li.u a1, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Opening

.org 0x800FCE88
li v0, (0xF6000000|(SCREEN_W << 14)|(SCREEN_H << 2)) //Fix Opening Color Fades

.headersize 0x800F65E0-0x2A2500 //Board Opening Segment

.org 0x800F6A44
slti v0, s0, (SCREEN_W/2) //Fix Minimum X Position of Board 2 Logo

.org 0x800F6A7C
slti v0, s0, (SCREEN_W/2) //Fix Center X Position of Board 2 Logo

.org 0x800F6E84
slti v0, s0, ((SCREEN_W/2)+6) //Fix Minimum X Position of Board 5 Logo

.org 0x800F6EC0
slti v0, s0, ((SCREEN_W/2)+6) //Fix Center X Position of Board 5 Logo

.org 0x800F74CC
slti v0, s1, ((SCREEN_W/2)+11) //Fix Center X Position of Board 8 Logo

.org 0x800F74E8
slti v0, s1, ((SCREEN_W/2)+11) //Fix Center X Position of Board 8 Logo

.org 0x800F818C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Host Message

.org 0x800F8268
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Host Message 2

.org 0x800F8608
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Turn Order Eternal Star Jump Message

.org 0x800F860C
addiu a0, r0, ((SCREEN_W/2)-84) //Fix X Position of Turn Order Jump Message

.org 0x800F8A18
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Turn Order Message

.org 0x800F8BA0
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Turn Order Done Message

.org 0x800F8CDC
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Turn Order End Message

.org 0x800F9474
addiu a2, r0, ((((SCREEN_W*590)/320)-345)/24) //Fix Walk Speed for Host

.org 0x800F947C
addiu a0, r0, ((((SCREEN_W*590)/320)-345)/24) //Fix Walk Wait for Host

.org 0x800F97FC
li.u at, 20.0 //Fix Speed of Spoon in Peach Birthday Cake Board

.org 0x800FA284
addiu a2, r0, ((SCREEN_W/2)-100) //Fix X Position of Warios Battle Canyon Explode Effect

.org 0x800FB734
addiu a2, r0, ((((SCREEN_W*590)/320)-345)/24) //Fix Walk Speed for Host

.org 0x800FB73C
addiu a0, r0, ((((SCREEN_W*590)/320)-345)/24) //Fix Walk Wait for Host

.org 0x800FBDC4
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Eternal Star Bowser Message

.org 0x800FBEAC
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Eternal Star Baby Bowser Message

.org 0x800FBF94
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Eternal Star Baby Bowser Turn Order Message

.org 0x800FC628
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Tutorial Window

.org 0x800F9228
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Board Opening

.org 0x800F9234
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Board Opening

.org 0x800FD3CC
.float -((SCREEN_W_FLOAT*590)/320) //Fix Start X Position of Host in Board 1 Opening

.org 0x800FD414
.float -((SCREEN_W_FLOAT*590)/320) //Fix Start X Position of Host in Board 7 Opening

.org 0x800FD554
.dh (SCREEN_W/2) //Fix Start X Position of Board 1 Logo

.org 0x800FD558
.dh (SCREEN_W/2) //Fix End X Position of Board 1 Logo

.org 0x800FD560
.dh ((SCREEN_W/2)+2) //Fix End X Position of Board 2 Logo

.org 0x800FD564
.dh (SCREEN_W/2) //Fix Start X Position of Board 3 Logo

.org 0x800FD568
.dh ((SCREEN_W/2)+1) //Fix End X Position of Board 3 Logo

.org 0x800FD56C
.dh ((SCREEN_W/2)-4) //Fix Start X Position of Board 4 Logo

.org 0x800FD570
.dh ((SCREEN_W/2)+1) //Fix End X Position of Board 4 Logo

.org 0x800FD574
.dh ((SCREEN_W/2)+5) //Fix Start X Position of Board 5 Logo

.org 0x800FD578
.dh (SCREEN_W+165) //Fix End X Position of Board 5 Logo

.org 0x800FD57C
.dh (SCREEN_W/2) //Fix Start X Position of Board 6 Logo

.org 0x800FD580
.dh (SCREEN_W/2) //Fix End X Position of Board 6 Logo

.org 0x800FD584
.dh (SCREEN_W/2) //Fix Start X Position of Board 7 Logo

.org 0x800FD588
.dh ((SCREEN_W/2)+1) //Fix End X Position of Board 7 Logo

.org 0x800FD58C
.dh (SCREEN_W/2) //Fix Start X Position of Board 8 Logo

.org 0x800FD590
.dh (SCREEN_W+491) //Fix End X Position of Board 8 Logo

.org 0x800FD8B0
.float ((SCREEN_W_FLOAT*865)/320) //Fix End X Position of Flying Koopa

.org 0x800FD8F8
.float ((SCREEN_W_FLOAT*752)/320) //Fix End X Position of Koopa

.headersize 0x800F65E0-0x2A9970 //Credits Segment

.org 0x800F6970
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Staff Text

.org 0x800F6CEC
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Superstar Text

.org 0x800F6F84
addiu s7, r0, 160 //Fix X Offset of Credits Background Sprites

.org 0x800F7044
addiu s7, s7, 320 //Fix X Spacing of Credits Background Sprites

.org 0x800F7214
addiu a2, r0, ((SCREEN_W/2)-64) //Fix X Position of Star Effect

.org 0x800F734C
addiu a2, r0, (SCREEN_W/2) //Fix X Position of THE END Text

.org 0x800F8198
addiu s5, r0, 160 //Fix X Offset of Credits Background Sprites

.org 0x800F8274
addiu s5, s5, 320 //Fix X Spacing of Credits Background Sprites

.org 0x800F841C
addiu a2, r0, (SCREEN_W+80) //Fix X Position of Hidden Name Star

.org 0x800F857C
addiu a2, r0, SCREEN_W //Fix X Position of Hidden Names

.org 0x800F85C8
addiu v0, r0, (SCREEN_W-8) //Fix X Position of Right Names

.org 0x800F85EC
addiu s4, r0, (SCREEN_W+32) //Fix X Position of Right Slide In Names

.org 0x800F8638
addiu v0, r0, (SCREEN_W-8) //Fix X Position of Left Slide In Names

.org 0x800F867C
addiu s7, r0, (SCREEN_W+32) //Fix X Position of Right Slide In Names

.org 0x800F8800
addiu a2, r0, (SCREEN_W+80) //Fix X Position of Hidden Stars

.org 0x800F8948
addiu a2, r0, (SCREEN_W+80) //Fix Initial X Position of Credits Stars

.org 0x800F8974
addiu a0, r0, SCREEN_W //Fix Initial X Position of Credits Windows

.org 0x800F8B8C
addiu a2, r0, SCREEN_W //Fix Initial X Position of Credits Windows

.org 0x800F8CB8
addiu a2, r0, (SCREEN_W+80) //Fix Initial X Position of Credits Stars

.org 0x800F8D28
addiu s6, r0, (SCREEN_W+32) //Fix Start X Position of Name Slide In

.org 0x800F8D58
addiu v1, r0, (SCREEN_W-12) //Fix Start X Position of Name Slide Up

.org 0x800F8DB0
addiu v1, r0, (SCREEN_W-12) //Fix Start X Position of Name Slide Right

.org 0x800F90E8
addiu t0, r0, (SCREEN_W+32) //Fix Start X Position of Name Slide Out

.org 0x800F97A4
li.u at, -((SCREEN_W_FLOAT*1100)/320) //Load Upper Half of Character Start X Position
li.l at, -((SCREEN_W_FLOAT*1100)/320) //Load Lower Half of Character Start X Position

.org 0x800F97C8
li.u at, ((SCREEN_W_FLOAT*400)/320) //Load Upper Half of Character End X Position

.org 0x800F97DC
li.u at, -((SCREEN_W_FLOAT*1100)/320) //Load Upper Half of Character Start X Position
li.l at, -((SCREEN_W_FLOAT*1100)/320) //Load Lower Half of Character Start X Position

.org 0x800F9804
li.u at, ((SCREEN_W_FLOAT*400)/320) //Load Upper Half of Character End X Position

.org 0x800F9828
li.u at, ((SCREEN_W_FLOAT*1100)/320) //Load Upper Half of Character Start X Position
li.l at, ((SCREEN_W_FLOAT*1100)/320) //Load Lower Half of Character Start X Position

.org 0x800F9850
li.u at, -((SCREEN_W_FLOAT*400)/320) //Load Upper Half of Character End X Position

.org 0x800F9874
li.u at, ((SCREEN_W_FLOAT*1100)/320) //Load Upper Half of Character Start X Position
li.l at, ((SCREEN_W_FLOAT*1100)/320) //Load Lower Half of Character Start X Position

.org 0x800F989C
li.u at, -((SCREEN_W_FLOAT*400)/320) //Load Upper Half of Character End X Position

.org 0x800FAB98
li.u at, SCREEN_W_FLOAT //Fix Maximum X Position of

.org 0x800FC4A8
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Credits

.org 0x800FC4B4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Credits

.org 0x800FD994
.dh -160 //Fix X Offset of Background Sprite 1

.org 0x800FD998
.dh 160 //Fix X Offset of Background Sprite 2

.org 0x800FD99C
.dh -160 //Fix X Offset of Background Sprite 3

.org 0x800FD9A0
.dh 160 //Fix X Offset of Background Sprite 4

.org 0x800FD9A4
.dh -160 //Fix X Offset of Background Sprite 5

.org 0x800FD9A8
.dh 160 //Fix X Offset of Background Sprite 6

.org 0x800FD9AC
.dh -160 //Fix X Offset of Background Sprite 7

.org 0x800FD9B0
.dh 160 //Fix X Offset of Background Sprite 8

.org 0x800FE2B0
.double (SCREEN_W_FLOAT/240) //Fix Aspect Ratio for 3D to 2D in Credits

.headersize 0x800F65E0-0x2B1670 //Results Segment

.org 0x800F88C0
addiu a0, r0, ((SCREEN_W/2)-30) //Fix X Position of Continue Window

.org 0x800F88C4
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Continue Extend Window

.org 0x800F8ED4
addiu s1, r0, SCREEN_W //Fix Detailed Results Face Offset

.org 0x800F8EF4
addiu a2, a2, SCREEN_W //Fix Detailed Results Header Offset

.org 0x800F8F1C
addiu a2, r0, SCREEN_W //Fix Detailed Results Offset

.org 0x800F9410
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Continue Extend Window

.org 0x800F9588
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Continue Extend Window

.org 0x800FB5EC
slti v0, s2, -SCREEN_W //Fix Slide End of Results

.org 0x800FB668
addiu s0, s2, (((SCREEN_W*3)/2)-110) //Fix X Offset of Bank Icons

.org 0x800FB68C
addiu s0, s2, (((SCREEN_W*3)/2)-80) //Fix X Offset of Bank Cross

.org 0x800FB6C0
addiu s0, s2, (((SCREEN_W*3)/2)-60) //Fix X Offset of Bank Number

.org 0x800FB730
slti v0, s2, -SCREEN_W //Fix Slide End of Results

.org 0x800FB738
addiu s0, s2, (((SCREEN_W*3)/2)-110) //Fix X Offset of Bank Icons

.org 0x800FBFB0
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Results

.org 0x800FBFBC
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Results

.org 0x800FC158
.dh ((SCREEN_W/2)-24) //Fix X Position of Board Results Cursor Column 1

.org 0x800FC15C
.dh ((SCREEN_W/2)+19) //Fix X Position of Board Results Cursor Column 2

.org 0x800FC160
.dh ((SCREEN_W/2)+62) //Fix X Position of Board Results Cursor Column 3

.org 0x800FC164
.dh ((SCREEN_W/2)+107) //Fix X Position of Board Results Cursor Column 4

.org 0x800FC168
.dh ((SCREEN_W/2)-24) //Fix X Position of Board Results Column 1

.org 0x800FC16C
.dh ((SCREEN_W/2)+19) //Fix X Position of Board Results Column 2

.org 0x800FC170
.dh ((SCREEN_W/2)+62) //Fix X Position of Board Results Column 3

.org 0x800FC174
.dh ((SCREEN_W/2)+107) //Fix X Position of Board Results Column 4

.org 0x800FC178
.dh ((SCREEN_W/2)-54) //Fix X Position of Board Results Text Column 1

.org 0x800FC17C
.dh ((SCREEN_W/2)-10) //Fix X Position of Board Results Text Column 2

.org 0x800FC180
.dh ((SCREEN_W/2)+34) //Fix X Position of Board Results Text Column 3

.org 0x800FC184
.dh ((SCREEN_W/2)+78) //Fix X Position of Board Results Text Column 4

.org 0x800FC188
.dh ((SCREEN_W/2)-84) //Fix X Position of Board Results Player 1 Name

.org 0x800FC18C
.dh ((SCREEN_W/2)-84) //Fix X Position of Board Results Player 2 Name

.org 0x800FC190
.dh ((SCREEN_W/2)-84) //Fix X Position of Board Results Player 3 Name

.org 0x800FC194
.dh ((SCREEN_W/2)-84) //Fix X Position of Board Results Player 4 Name

.org 0x800FC198
.dh ((SCREEN_W/2)-124) //Fix X Position of Board Results Player 1 Face

.org 0x800FC19C
.dh ((SCREEN_W/2)-124) //Fix X Position of Board Results Player 2 Face

.org 0x800FC1A0
.dh ((SCREEN_W/2)-124) //Fix X Position of Board Results Player 3 Face

.org 0x800FC1A4
.dh ((SCREEN_W/2)-124) //Fix X Position of Board Results Player 4 Face

.org 0x800FC1A8
.dh ((SCREEN_W/2)-53) //Fix X Position of Board Results Logo

.org 0x800FC1AC
.dh ((SCREEN_W/2)+80) //Fix X Position of Board Results Play Mode

.org 0x800FC1B0
.dh ((SCREEN_W/2)-40) //Fix X Position of Board Results Left Arrow

.org 0x800FC1B4
.dh ((SCREEN_W/2)+120) //Fix X Position of Board Results Right Arrow

.org 0x800FC2A4
.dh (SCREEN_W/2) //Fix X Position of Board Results Header

.org 0x800FC2A8
.dh ((SCREEN_W/2)-100) //Fix X Position of Board Results P1 Rank

.org 0x800FC2AC
.dh ((SCREEN_W/2)-100) //Fix X Position of Board Results P2 Rank

.org 0x800FC2B0
.dh ((SCREEN_W/2)-100) //Fix X Position of Board Results P3 Rank

.org 0x800FC2B4
.dh ((SCREEN_W/2)-100) //Fix X Position of Board Results P4 Rank

.org 0x800FC2B8
.dh ((SCREEN_W/2)-80) //Fix X Position of Stadium Results P1 Rank

.org 0x800FC2BC
.dh ((SCREEN_W/2)-80) //Fix X Position of Stadium Results P2 Rank

.org 0x800FC2C0
.dh ((SCREEN_W/2)-80) //Fix X Position of Stadium Results P3 Rank

.org 0x800FC2C4
.dh ((SCREEN_W/2)-80) //Fix X Position of Stadium Results P4 Rank

.org 0x800FC2C8
.dh ((SCREEN_W/2)-50) //Fix X Position of Board Results P1 Face

.org 0x800FC2CC
.dh ((SCREEN_W/2)-50) //Fix X Position of Board Results P2 Face

.org 0x800FC2D0
.dh ((SCREEN_W/2)-50) //Fix X Position of Board Results P3 Face

.org 0x800FC2D4
.dh ((SCREEN_W/2)-50) //Fix X Position of Board Results P4 Face

.org 0x800FC2D8
.dh ((SCREEN_W/2)-10) //Fix X Position of Stadium Results P1 Face

.org 0x800FC2DC
.dh ((SCREEN_W/2)-10) //Fix X Position of Stadium Results P2 Face

.org 0x800FC2E0
.dh ((SCREEN_W/2)-10) //Fix X Position of Stadium Results P3 Face

.org 0x800FC2E4
.dh ((SCREEN_W/2)-10) //Fix X Position of Stadium Results P4 Face

.org 0x800FC2E8
.dh ((SCREEN_W/2)-9) //Fix X Position of Board Results P1 Star

.org 0x800FC2EC
.dh ((SCREEN_W/2)-9) //Fix X Position of Board Results P2 Star

.org 0x800FC2F0
.dh ((SCREEN_W/2)-9) //Fix X Position of Board Results P3 Star

.org 0x800FC2F4
.dh ((SCREEN_W/2)-9) //Fix X Position of Board Results P4 Star

.org 0x800FC2F8
.dh ((SCREEN_W/2)+66) //Fix X Position of Board Results P1 Coin

.org 0x800FC2FC
.dh ((SCREEN_W/2)+66) //Fix X Position of Board Results P2 Coin

.org 0x800FC300
.dh ((SCREEN_W/2)+66) //Fix X Position of Board Results P3 Coin

.org 0x800FC304
.dh ((SCREEN_W/2)+66) //Fix X Position of Board Results P4 Coin

.org 0x800FC308
.dh ((SCREEN_W/2)+46) //Fix X Position of Stadium Results P1 Coin

.org 0x800FC30C
.dh ((SCREEN_W/2)+46) //Fix X Position of Stadium Results P2 Coin

.org 0x800FC310
.dh ((SCREEN_W/2)+46) //Fix X Position of Stadium Results P3 Coin

.org 0x800FC314
.dh ((SCREEN_W/2)+46) //Fix X Position of Stadium Results P4 Coin

.org 0x800FC318
.dh ((SCREEN_W/2)+14) //Fix X Position of Board Results P1 Coin Number

.org 0x800FC31C
.dh ((SCREEN_W/2)+14) //Fix X Position of Board Results P2 Coin Number

.org 0x800FC320
.dh ((SCREEN_W/2)+14) //Fix X Position of Board Results P3 Coin Number

.org 0x800FC324
.dh ((SCREEN_W/2)+14) //Fix X Position of Board Results P4 Coin Number

.org 0x800FC328
.dh ((SCREEN_W/2)+90) //Fix X Position of Board Results P1 Star Number

.org 0x800FC32C
.dh ((SCREEN_W/2)+90) //Fix X Position of Board Results P2 Star Number

.org 0x800FC330
.dh ((SCREEN_W/2)+90) //Fix X Position of Board Results P3 Star Number

.org 0x800FC334
.dh ((SCREEN_W/2)+90) //Fix X Position of Board Results P4 Star Number

.org 0x800FC338
.dh ((SCREEN_W/2)+14) //Fix X Position of Stadium Results P1 Star Number

.org 0x800FC33C
.dh ((SCREEN_W/2)+14) //Fix X Position of Stadium Results P2 Star Number

.org 0x800FC340
.dh ((SCREEN_W/2)+14) //Fix X Position of Stadium Results P3 Star Number

.org 0x800FC344
.dh ((SCREEN_W/2)+14) //Fix X Position of Stadium Results P4 Star Number

.org 0x800FC348
.dh ((SCREEN_W/2)+70) //Fix X Position of Stadium Results P1 Coin Number

.org 0x800FC34C
.dh ((SCREEN_W/2)+70) //Fix X Position of Stadium Results P2 Coin Number

.org 0x800FC350
.dh ((SCREEN_W/2)+70) //Fix X Position of Stadium Results P3 Coin Number

.org 0x800FC354
.dh ((SCREEN_W/2)+70) //Fix X Position of Stadium Results P4 Coin Number

.headersize 0x800F65E0-0x2B74A0 //Boo Steal Segment

.org 0x800F88D0
addiu a0, r0, ((SCREEN_W/2)-104) //Fix X Position of Steal Type Window

.org 0x800F8AC4
addiu a0, r0, (SCREEN_W/2) //Fix X Position of Steal Player Window

.org 0x800F8D40
addiu a0, r0, ((SCREEN_W/2)-20) //Fix X Position of Steal Cancel Window

.org 0x800F8DCC
addiu a0, r0, ((SCREEN_W/2)-20) //Fix X Position of Steal Start Window

.org 0x800F9254
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Boo Steal

.org 0x800F9260
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Boo Steal

.org 0x800F94D4
.float (SCREEN_W_FLOAT-76) //Fix X Position of P2 Boo in Boo Steal

.org 0x800F94E4
.float (SCREEN_W_FLOAT-76) //Fix X Position of P4 Boo in Boo Steal

.headersize 0x800F65E0-0x2BA4C0 //Logo Segment

.org 0x800F68B0
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Nintendo 64 Logo

.org 0x800F697C
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Nintendo Logo

.org 0x800F6A40
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Hudson Logo

.headersize 0x800F65E0-0x2BA9E0 //64DD Segment

.org 0x800F6884
addiu a2, r0, (SCREEN_W/2) //Fix X Position of 64DD Error Message

.org 0x800F6914
addiu a2, r0, (SCREEN_W/2) //Fix X Position of 64DD Error Book Message

.org 0x800F69B4
addiu a2, r0, (SCREEN_W/2) //Fix X Position of 64DD Error Reset Message

.org 0x800F6A54
addiu a2, r0, (SCREEN_W/2) //Fix X Position of 64DD Error Number Message

.org 0x800F6AA4
addiu a3, r0, ((SCREEN_W/2)+16) //Fix X Position of 64DD Error Number

.headersize 0x800F65E0-0x2BB390 //Save Corrupted Segment

.org 0x800F6630
addiu a0, r0, ((SCREEN_W/2)-108) //Fix X Position of Save Corrupt Window

.org 0x800F668C
addiu a0, r0, ((SCREEN_W/2)-108) //Fix X Position of Press Button Window

.headersize 0x800F65E0-0x2BB5C0 //Main Menu Segment

.org 0x800F735C
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Main Menu Window

.org 0x800F739C
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Main Menu Big Window

.headersize 0x800F65E0-0x2BF1A0 //Setup Menu Segment

.org 0x800F6750
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Setup Menu

.org 0x800F675C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Setup Menu

.org 0x800F73A0
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of Setup Menu Window

.headersize 0x800F65E0-0x2CAA00 //Minigame Menu Segment

.org 0x800F88B8
addiu a0, r0, (SCREEN_W-120) //Fix X Position of Fly Guy Record Window

.org 0x800F8F2C
addiu a0, r0, (SCREEN_W-80) //Fix X Position of Fly Guy Timer

.org 0x800F969C
addiu s1, s1, ((SCREEN_W/2)-20) //Fix X Position of Fly Guy Time Window Background

.org 0x800F976C
addiu a0, r0, ((SCREEN_W/2)-82) //Fix X Position of Fly Guy Time Window

.org 0x800F9B1C
addiu s1, s1, ((SCREEN_W/2)-20) //Fix X Position of Fly Guy Time Window Background

.org 0x800FA2F8
addiu a0, r0, ((SCREEN_W/2)-30) //Fix X Position of Minigame List Window

.org 0x800FAB74
addiu a1, r0, ((SCREEN_W/2)-30) //Fix X Position of Minigame List Arrow
addiu a1, r0, ((SCREEN_W/2)-8) //Fix X Position of Minigame List Right Arrow

.org 0x800FAE30
addiu v1, v1, ((SCREEN_W/2)+40) //Fix X Position of Player Portraits

.org 0x800FB324
addiu a0, r0, (SCREEN_W-131) //Fix X Position of Minigame Find Window

.org 0x800FB368
addiu a2, r0, SCREEN_W //Fix X Position of Initial Minigame Find Window

.org 0x800FB3B8
addiu a2, r0, SCREEN_W //Fix X Position of Initial Minigame Buy Window

.org 0x800FB5EC
addiu a2, r0, SCREEN_W //Fix X Position of Initial Minigame List Window

.org 0x800FC270
addiu v0, v0, ((SCREEN_W/2)+23) //Fix X Position of Minigame Team 1 vs 3 Players

.org 0x800FC344
addiu v0, v0, ((SCREEN_W/2)+23) //Fix X Position of Minigame Team 2 vs 2 Players

.org 0x800FC490
addiu a1, r0, ((SCREEN_W/2)+72) //Fix X Position of Minigame Team VS

.org 0x800FCDDC
addiu v1, r0, ((SCREEN_W/2)-30) //Fix X Position of Left Minigame List Window

.org 0x800FD704
addiu a2, r0, SCREEN_W //Fix X Position of Initial Minigame List Window

.org 0x800FE2BC
addiu a0, r0, ((SCREEN_W/2)+29) //Fix X Position of Minigame Difficulty Window

.org 0x800FE304
addiu a2, r0, SCREEN_W //Fix X Position of Initial Minigame Difficulty Window

.org 0x800FE5F0
addiu a1, r0, ((SCREEN_W/2)+33) //Fix X Position of Minigame Difficulty Arrows

.org 0x800FE6EC
addiu a0, r0, ((SCREEN_W/2)-20) //Fix X Position of Minigame Config Window

.org 0x800FE734
addiu a2, r0, SCREEN_W //Fix X Position of Initial Minigame Config Window

.org 0x800FEB34
addiu a1, r0, ((SCREEN_W/2)-16) //Fix X Position of Minigame Config Arrows

.org 0x800FED94
addiu v1, r0, ((SCREEN_W/2)+2) //Fix X Position of Right Minigame List Window

.org 0x800FEEE4
addiu v1, r0, ((SCREEN_W/2)-30) //Fix X Position of Left Minigame List Window

.org 0x800FF624
addiu a0, r0, ((SCREEN_W/2)-48) //Fix X Position of Minigame Press Start Set

.org 0x800FFB0C
addiu a2, r0, SCREEN_W //Fix X Position of Initial Minigame Difficulty Window

.org 0x800FFE30
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Minigame Press Start Text

.headersize 0x800F65E0-0x2D4830 //Shop Segment

.org 0x800F7964
addiu a0, r0, ((SCREEN_W/2)-50) //Fix X Position of Shop Price Window

.org 0x800F7D70
addiu a2, r0, SCREEN_W //Fix X Position of Shop Price Slide Begin

.org 0x800F7E34
li.u at, SCREEN_W_FLOAT //Fix X Position of Shop Price Slide Begin

.org 0x800F7E40
li.u at, (((SCREEN_W_FLOAT/2)-20)/10) //Fix X Speed of Shop Price Slide Begin

.headersize 0x800F65E0-0x2D6FC0 //Bank Segment

.org 0x800F7F10
addiu a0, r0, ((SCREEN_W/2)-50) //Fix X Position of Item Name Window

.headersize 0x800F65E0-0x2D9570 //Options Segment

.org 0x800F7234
addiu a0, r0, ((SCREEN_W/2)-103) //Fix X Position of Save Warning Window

.org 0x800F7B28
addiu a0, r0, ((SCREEN_W/2)-81) //Fix X Position of Audio Setting Window

.headersize 0x800F65E0-0x2DB2A0 //Instructions Segment

.org 0x800F6D44
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Instructions Background

.org 0x800F6D58
li.u a1, (SCREEN_W_FLOAT/160) //Fix Scale of Instructions Background

.org 0x800F6D88
li.u at, (SCREEN_W_FLOAT/2) //Fix X Position of Instructions Models

.org 0x800F6DF4
jal HmfModelScaleSetWide //Fix Instructions Cloud 1 Scale

.org 0x800F6E7C
jal HmfModelScaleSetWide //Fix Instructions Cloud 2 Scale

.org 0x800F7194
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Minigame Incomplete Warning

.org 0x800F7428
li.u at, (SCREEN_W_FLOAT-30) //Fix X Position of Minigame Icon

.org 0x800F76E8
li.u at, -((SCREEN_W_FLOAT/2)-30) //Fix X Speed of Minigame Icon

.org 0x800F76F8
li.u at, (SCREEN_W_FLOAT-30) //Fix X Position of Minigame Icon

.org 0x800F8F18
li.u at, (SCREEN_W_FLOAT-160) //Fix X Position of Start Icon

.org 0x800F8FE0
li.u at, (SCREEN_W_FLOAT-160) //Fix X Position of Moving Start Icon

.org 0x800F8FF0
li.u at, (SCREEN_W_FLOAT-135) //Fix End X Position of Moving Start Icon

.headersize 0x800F65E0-0x2F40C0 //Test Map Segment

.org 0x800F6654
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Test Map

.org 0x800F6660
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Test Map

.headersize 0x800F65E0-0x2FADB0 //Minigame Island Ending Segment

.org 0x800F6778
addiu v1, r0, ((SCREEN_W/2)-98) //Fix X Position of Save Status Window Icon

.org 0x800F6790
addiu a0, r0, ((SCREEN_W/2)-136) //Fix X Position of Save Status Window

.org 0x800F69C0
addiu v1, r0, ((SCREEN_W/2)-98) //Fix X Position of Save Status Window Icon

.org 0x800F6E98
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Ending Goal Window

.org 0x800F6F84
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Ending Unknown Window

.org 0x800F7144
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Ending Toad Window

.org 0x800F7210
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Compete Window

.org 0x800F72C0
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Clear All and Try Again Window

.org 0x800F7370
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Try Harder Window

.org 0x800F7448
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Super Star Window

.org 0x800F7504
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Ending Win Window

.org 0x800F75B4
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Ending Return Window

.org 0x800F7DD4
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Minigame Replay Window

.org 0x800F7F68
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending All Clear Window

.org 0x800F8028
addiu a2, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Minigame Name

.org 0x800F87B4
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Minigame Source Window

.org 0x800F8810
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Save Question Window

.org 0x800F889C
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Save Question Window

.org 0x800F891C
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Save Question Repeat Window

.org 0x800F8954
addiu a0, r0, ((SCREEN_W/2)-60) //Fix X Position of Ending Toad Saved Window

.org 0x800F89C0
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Return Window

.org 0x800F8A60
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Try Harder Window

.org 0x800F8AD0
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Ending Toad Try Harder Window
addiu a0, r0, ((SCREEN_W/2)-70) //Fix X Position of Ending Toad Cancel Window

.org 0x800F8F70
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Minigame Island Ending

.org 0x800F8F7C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Minigame Island Ending


.headersize 0x800F65E0-0x2FD940 //Minigame Island Opening Segment

.org 0x800F6D74
addiu a0, r0, ((SCREEN_W/2)-114) //Fix X Position of Minigame Island Opening Player Select

.org 0x800F6DA0
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Minigame Island Opening Bottom Window

.org 0x800F6E58
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Minigame Island Player Select Text

.org 0x800F7B20
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island 1st Character Name Question

.org 0x800F7BE0
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island Leave Window

.org 0x800F7D28
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island 1st Character Name

.org 0x800F7E2C
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island 2nd Character Name Question

.org 0x800F7F10
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island Leave Window

.org 0x800F80B8
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island 2nd Character Name

.org 0x800F8464
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island Opening Text

.org 0x800F8540
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island Goal Text

.org 0x800F85AC
addiu a2, r0, ((SCREEN_W/2)-60) //Fix X Position of Minigame Island Space Window

.org 0x800F85C8
addiu a2, r0, ((SCREEN_W/2)-60) //Fix X Position of Minigame Island Space Border

.org 0x800F8610
addiu a2, r0, ((SCREEN_W/2)-60) //Fix X Position of Minigame Island Space Icon

.org 0x800F8620
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island Space Tutorial

.org 0x800F86A4
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island Life Tutorial

.org 0x800F8714
addiu a0, r0, ((SCREEN_W/2)-90) //Fix X Position of Minigame Island Coin Tutorial

.org 0x800F8788
addiu a2, r0, ((SCREEN_W/2)-60) //Fix X Position of Minigame Island Koopa Troopa Window

.org 0x800F87A4
addiu a2, r0, ((SCREEN_W/2)-60) //Fix X Position of Minigame Island Koopa Troopa Border

.org 0x800F87EC
addiu a2, r0, ((SCREEN_W/2)-60) //Fix X Position of Minigame Island Koopa Troopa Icon

.org 0x800F87FC
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island Save Tutorial

.org 0x800F8878
addiu a0, r0, ((SCREEN_W/2)-80) //Fix X Position of Minigame Island Goal Tutorial

.org 0x800F8EFC
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Minigame Island Opening

.org 0x800F8F08
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Minigame Island Opening

.org 0x800F91E4
.dh ((SCREEN_W/2)-70) //Fix X Position of Character 1 Icon in Minigame Island Opening

.org 0x800F91E8
.dh (SCREEN_W/2) //Fix X Position of Character 2 Icon in Minigame Island Opening

.org 0x800F91EC
.dh ((SCREEN_W/2)+70) //Fix X Position of Character 3 Icon in Minigame Island Opening

.org 0x800F91F0
.dh ((SCREEN_W/2)-70) //Fix X Position of Character 4 Icon in Minigame Island Opening

.org 0x800F91F4
.dh (SCREEN_W/2) //Fix X Position of Character 5 Icon in Minigame Island Opening

.org 0x800F91F8
.dh ((SCREEN_W/2)+70) //Fix X Position of Character 6 Icon in Minigame Island Opening

.org 0x800F91FC
.dh ((SCREEN_W/2)-94) //Fix X Position of Left Cursor in Minigame Island Opening

.org 0x800F9200
.dh ((SCREEN_W/2)-64) //Fix X Position of Right Cursor in Minigame Island Opening

.headersize 0x800F65E0-0x3005B0 //Minigame Island Save Segment

.org 0x800F68B0
addiu v1, r0, ((SCREEN_W/2)-98) //Fix X Position of Save Status Window Icon

.org 0x800F68C8
addiu a0, r0, ((SCREEN_W/2)-136) //Fix X Position of Save Status Window

.org 0x800F6B44
addiu v1, r0, ((SCREEN_W/2)-98) //Fix X Position of Save Status Window Icon

.org 0x800F6D6C
addiu a0, r0, ((SCREEN_W/2)-86) //Fix X Position of Save Question Window

.org 0x800F6DC0
addiu a0, r0, ((SCREEN_W/2)-100) //Fix X Position of Save Question Choice Window

.org 0x800F6FBC
addiu a0, r0, ((SCREEN_W/2)-110) //Fix X Position of Save Clear Window

.org 0x800F7384
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Minigame Island Save

.org 0x800F7390
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Minigame Island Save

.headersize 0x800F65E0-0x3014C0 //Random Play Segment

.org 0x800F66AC
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Random Play

.org 0x800F66B8
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Random Play

.org 0x800F6FBC
addiu a0, r0, ((SCREEN_W/2)-64) //Fix X Position of Random Play Window

.org 0x800F6FE0
addiu a0, r0, ((SCREEN_W/2)-128) //Fix X Position of Random Play Name Window

.org 0x800F88F0
.dw ((SCREEN_W/2)-136) //Fix X Position of P1 in Random Play
.dw ((SCREEN_W/2)+2) //Fix X Position of P2 in Random Play
.dw ((SCREEN_W/2)-136) //Fix X Position of P3 in Random Play
.dw ((SCREEN_W/2)+2) //Fix X Position of P4 in Random Play

.headersize 0x800F65E0-0x303E70 //Minigame Stadium Results Segment

.org 0x800F7F50
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Minigame Stadium Results

.org 0x800F7F5C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Minigame Stadium Results

.headersize 0x800F65E0-0x308A50 //Minigame Results Segment

.org 0x800F676C
addiu a2, r0, SCREEN_W //Fix Width of Minigame Results Filter

.org 0x800F7AC4
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Minigame Results

.org 0x800F7AD0
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Minigame Results

.org 0x800F9FF0
.dh (SCREEN_W/2) //Fix X Position of Results Text

.org 0x800F9FF4
.dh ((SCREEN_W/2)-100) //Fix X Position of P1 Rank

.org 0x800F9FF8
.dh ((SCREEN_W/2)-100) //Fix X Position of P2 Rank

.org 0x800F9FFC
.dh ((SCREEN_W/2)-100) //Fix X Position of P3 Rank

.org 0x800FA000
.dh ((SCREEN_W/2)-100) //Fix X Position of P4 Rank

.org 0x800FA004
.dh ((SCREEN_W/2)-50) //Fix X Position of P1 Face

.org 0x800FA008
.dh ((SCREEN_W/2)-50) //Fix X Position of P2 Face

.org 0x800FA00C
.dh ((SCREEN_W/2)-50) //Fix X Position of P3 Face

.org 0x800FA010
.dh ((SCREEN_W/2)-50) //Fix X Position of P4 Face

.org 0x800FA014
.dh ((SCREEN_W/2)-9) //Fix X Position of P1 Star

.org 0x800FA018
.dh ((SCREEN_W/2)-9) //Fix X Position of P2 Star

.org 0x800FA01C
.dh ((SCREEN_W/2)-9) //Fix X Position of P3 Star

.org 0x800FA020
.dh ((SCREEN_W/2)-9) //Fix X Position of P4 Star

.org 0x800FA024
.dh ((SCREEN_W/2)+66) //Fix X Position of P1 Coin

.org 0x800FA028
.dh ((SCREEN_W/2)+66) //Fix X Position of P2 Coin

.org 0x800FA02C
.dh ((SCREEN_W/2)+66) //Fix X Position of P3 Coin

.org 0x800FA030
.dh ((SCREEN_W/2)+66) //Fix X Position of P4 Coin

.org 0x800FA034
.dh ((SCREEN_W/2)+14) //Fix X Position of P1 Star Number

.org 0x800FA038
.dh ((SCREEN_W/2)+14) //Fix X Position of P2 Star Number

.org 0x800FA03C
.dh ((SCREEN_W/2)+14) //Fix X Position of P3 Star Number

.org 0x800FA040
.dh ((SCREEN_W/2)+14) //Fix X Position of P4 Star Number

.org 0x800FA044
.dh ((SCREEN_W/2)+90) //Fix X Position of P1 Coin Number

.org 0x800FA048
.dh ((SCREEN_W/2)+90) //Fix X Position of P2 Coin Number

.org 0x800FA04C
.dh ((SCREEN_W/2)+90) //Fix X Position of P3 Coin Number

.org 0x800FA050
.dh ((SCREEN_W/2)+90) //Fix X Position of P4 Coin Number

.org 0x800FA05A
.dh ((SCREEN_W/2)+90) //Fix X Position of X in Coin Number

.org 0x800FA062
.dh ((SCREEN_W/2)+90) //Fix X Position of X in Coin Number

.headersize 0x800F65E0-0x30C540 //Minigame Island Clear Segment

.org 0x800F67EC
addiu a2, r0, SCREEN_W //Fix Width of Background Color

.org 0x800F688C
addiu v0, r0, (SCREEN_W/2) //Fix X Position of Character Face

.org 0x800F695C
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Character Face Border

.org 0x800F6A44
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Minigame Island Clear Sprite

.org 0x800F6B18
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Minigame Island Game Over Sprite

.org 0x800F7870
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Minigame Island Clear

.org 0x800F787C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Minigame Island Clear

.org 0x800F9148
.dh (SCREEN_W-56) //Fix X Position of Minigame Island Clear Coin Window

.headersize 0x800F65E0-0x30F1B0 //Sequential Play Segment

.org 0x800F66AC
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Sequential Play

.org 0x800F66B8
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Sequential Play

.org 0x800F72EC
addiu a0, r0, ((SCREEN_W/2)-88) //Fix X Position of Sequential Play Window

.org 0x800F7310
addiu a0, r0, ((SCREEN_W/2)-128) //Fix X Position of Sequential Play Name Window

.org 0x800F8C10
.dw ((SCREEN_W/2)-136) //Fix X Position of P1 in Sequential Play
.dw ((SCREEN_W/2)+2) //Fix X Position of P2 in Sequential Play
.dw ((SCREEN_W/2)-136) //Fix X Position of P3 in Sequential Play
.dw ((SCREEN_W/2)+2) //Fix X Position of P4 in Sequential Play

.headersize 0x800F65E0-0x312850 //Minigame Stadium Ending Segment

.org 0x800F70E4
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Ending Window 1

.org 0x800F7264
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Ending Tie Window

.org 0x800F769C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Winner Window

.org 0x800F78E0
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Final Winner Window

.org 0x800F7A7C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Final Winner Name Window

.org 0x800F7BAC
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Winner Congratulations Window

.org 0x800F8420
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Minigame Island Clear

.org 0x800F842C
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Minigame Island Clear

.org 0x800F864C
.dh (SCREEN_W/2) //Fix X Position of Winner Text

.headersize 0x800F65E0-0x314950 //Title Segment

.org 0x800F7798
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Moving Title Logo

.org 0x800F7B08
addiu a2, r0, ((SCREEN_W/2)+105) //Fix X Position of Title Trademark

.org 0x800F7CAC
addiu a2, r0, (SCREEN_W/2) //Fix X Position of Title Logo

.org 0x800F7D6C
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Title Copyright

.org 0x800F7DC8
addiu a1, r0, ((SCREEN_W/2)-1) //Fix X Position of Title Copyright Shadow

.org 0x800F7E74
addiu a1, r0, (SCREEN_W/2) //Fix X Position of Title Press Start

.headersize 0x800F65E0-0x316440 //Minigame Stadium Segment

.org 0x800F67F8
addiu a2, r0, ((((SCREEN_W*590)/320)-345)/24) //Fix Walk Speed for Host

.org 0x800F6800
addiu a0, r0, ((((SCREEN_W*590)/320)-345)/24) //Fix Walk Wait for Host

.org 0x800F6E7C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Host Window

.org 0x800F7074
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Dice Window

.org 0x800F7430
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Player Order Window

.org 0x800F756C
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Player Order Done Window

.org 0x800F7648
addiu a0, r0, ((SCREEN_W/2)-130) //Fix X Position of Player Start Window

.org 0x800F78A8
li.u a3, (SCREEN_W_FLOAT) //Fix Scissor Width in Minigame Stadium Opening

.org 0x800F78B4
li.u at, (SCREEN_W_FLOAT*2) //Fix Viewport Width in Minigame Stadium Opening

.org 0x800F79E8
.float -((SCREEN_W_FLOAT*590)/320) //Fix Start X Position of Host in Minigame Stadium Opening

.headersize 0x800F65E0-0x317980 //Debug Menu Segment

.org 0x800F6990
addiu t0, r0, ((SCREEN_W+47)/48) //Number of Tiles in Row
divu s2, t0 //Execute Divide Instruction
nop //Two Instruction
nop //Delay for mflo/mfhi
mflo v1 //Get result
mfhi v0 //Get remainder
nop //Two Instructions
nop //Of Padding

.org 0x800F69DC
slti v0, s2, (5*((SCREEN_W+47)/48)) //Number of Tiles to Render

.org 0x800F7660
addiu a0, r0, ((SCREEN_W/2)-96) //Fix X Position of Debug Menu List

.org 0x800F76F0
addiu a0, r0, ((SCREEN_W/2)-32) //Fix X Position of Debug Menu Page

.org 0x800F7740
addiu a0, r0, ((SCREEN_W/2)-32) //Fix X Position of Debug Menu Mode

.org 0x800F777C
addiu a1, r0, ((SCREEN_W/2)-100) //Fix X Position of Debug Menu Cursor

.org 0x800F7A24
addiu a0, r0, ((SCREEN_W/2)-64) //Fix X Position of Save Clear Header

.org 0x800F7A54
addiu a0, r0, ((SCREEN_W/2)-48) //Fix X Position of Save Clear Yes

.org 0x800F7A84
addiu a0, r0, ((SCREEN_W/2)-48) //Fix X Position of Save Clear No

.org 0x800F7C28
addiu a0, r0, ((SCREEN_W/2)-48) //Fix X Position of Option Text

.org 0x800F7C94
addiu s2, v0, ((SCREEN_W/2)-120) //Fix X Position of Option List

.org 0x800F850C
addiu a1, s2, ((SCREEN_W/2)-124) //Fix X Position of Option List Cursor

.org 0x800F85D4
addiu v1, r0, SCREEN_W //Fix X Position of Debug Menu Name Shadow

.org 0x800F8994
addiu v1, r0, SCREEN_W //Fix X Position of Debug Menu Name

.org 0x800F9080
addiu a0, a0, ((SCREEN_W/2)-104) //Fix X Position of Debug Menu Player Name

.org 0x800F93A8
addiu a0, a0, ((SCREEN_W/2)-104) //Fix X Position of Debug Menu Blank Player Name

.close