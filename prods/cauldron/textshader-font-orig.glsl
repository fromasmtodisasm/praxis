// --------------------------------------------------------------
//
//  This Shader generates a font-texture
//
// --------------------------------------------------------------
//
//  The ascii table is split into 32x8 characters each 8 pixels
//  wide and 12 pixels high. This gives a block of 256x96 pixels
//  starting at the top left (0, iResolution.y)
//
// --------------------------------------------------------------

//  Created by Bart Verheijen 2016
//  License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.




// font data was inspired by the work of Flyguy:
// https://www.shadertoy.com/view/Mt2GWD


#define CHAR_SIZE vec2(8, 12)



vec4 asciiToSprite(float a)
{
    if (a<0.5) return vec4(0x000000, 0x000000, 0x000000, 0x000000);
    if (a<1.5) return vec4(0x007ec3, 0x81a581, 0xbd99c3, 0x7e0000);
    if (a<2.5) return vec4(0x007eff, 0xffdbff, 0xc3e7ff, 0x7e0000);
    if (a<3.5) return vec4(0x000044, 0xeefefe, 0xfe7c38, 0x100000);
    if (a<4.5) return vec4(0x001038, 0x7cfefe, 0x7c3810, 0x000000);
    if (a<5.5) return vec4(0x00183c, 0x3cffe7, 0xe71818, 0x7e0000);
    if (a<6.5) return vec4(0x00183c, 0x7effff, 0x7e1818, 0x7e0000);
    if (a<7.5) return vec4(0x000000, 0x003c7e, 0x7e3c00, 0x000000);
    if (a<8.5) return vec4(0xffffff, 0xffc381, 0x81c3ff, 0xffffff);
    if (a<9.5) return vec4(0x00003c, 0x7e6642, 0x42667e, 0x3c0000);
    if (a<10.5) return vec4(0xffffc3, 0x8199bd, 0xbd9981, 0xc3ffff);
    if (a<11.5) return vec4(0x003e0e, 0x3a72f8, 0xcccccc, 0x780000);
    if (a<12.5) return vec4(0x003c66, 0x66663c, 0x187e18, 0x180000);
    if (a<13.5) return vec4(0x001f19, 0x191f18, 0x1878f8, 0x700000);
    if (a<14.5) return vec4(0x007f63, 0x7f6363, 0x6367e7, 0xe6c000);
    if (a<15.5) return vec4(0x000018, 0xdb7ee7, 0xe77edb, 0x180000);
    if (a<16.5) return vec4(0x0080c0, 0xe0f8fe, 0xf8e0c0, 0x800000);
    if (a<17.5) return vec4(0x000206, 0x0e3efe, 0x3e0e06, 0x020000);
    if (a<18.5) return vec4(0x00183c, 0x7e1818, 0x187e3c, 0x180000);
    if (a<19.5) return vec4(0x006666, 0x666666, 0x000066, 0x660000);
    if (a<20.5) return vec4(0x007fdb, 0xdbdb7b, 0x1b1b1b, 0x1b0000);
    if (a<21.5) return vec4(0x007e63, 0x303c66, 0x663c0c, 0xc67e00);
    if (a<22.5) return vec4(0x000000, 0x000000, 0x00fefe, 0xfe0000);
    if (a<23.5) return vec4(0x00183c, 0x7e1818, 0x187e3c, 0x187e00);
    if (a<24.5) return vec4(0x00183c, 0x7e1818, 0x181818, 0x180000);
    if (a<25.5) return vec4(0x001818, 0x181818, 0x187e3c, 0x180000);
    if (a<26.5) return vec4(0x000000, 0x180cfe, 0x0c1800, 0x000000);
    if (a<27.5) return vec4(0x000000, 0x3060fe, 0x603000, 0x000000);
    if (a<28.5) return vec4(0x000000, 0x00c0c0, 0xc0fe00, 0x000000);
    if (a<29.5) return vec4(0x000000, 0x2466ff, 0x662400, 0x000000);
    if (a<30.5) return vec4(0x000010, 0x103838, 0x7c7cfe, 0xfe0000);
    if (a<31.5) return vec4(0x0000fe, 0xfe7c7c, 0x383810, 0x100000);
    if (a<32.5) return vec4(0x000000, 0x000000, 0x000000, 0x000000);
    if (a<33.5) return vec4(0x003078, 0x787830, 0x300030, 0x300000);
    if (a<34.5) return vec4(0x006666, 0x662400, 0x000000, 0x000000);
    if (a<35.5) return vec4(0x006c6c, 0xfe6c6c, 0x6cfe6c, 0x6c0000);
    if (a<36.5) return vec4(0x30307c, 0xc0c078, 0x0c0cf8, 0x303000);
    if (a<37.5) return vec4(0x000000, 0xc4cc18, 0x3060cc, 0x8c0000);
    if (a<38.5) return vec4(0x0070d8, 0xd870fa, 0xdeccdc, 0x760000);
    if (a<39.5) return vec4(0x003030, 0x306000, 0x000000, 0x000000);
    if (a<40.5) return vec4(0x000c18, 0x306060, 0x603018, 0x0c0000);
    if (a<41.5) return vec4(0x006030, 0x180c0c, 0x0c1830, 0x600000);
    if (a<42.5) return vec4(0x000000, 0x663cff, 0x3c6600, 0x000000);
    if (a<43.5) return vec4(0x000000, 0x18187e, 0x181800, 0x000000);
    if (a<44.5) return vec4(0x000000, 0x000000, 0x000038, 0x386000);
    if (a<45.5) return vec4(0x000000, 0x0000fe, 0x000000, 0x000000);
    if (a<46.5) return vec4(0x000000, 0x000000, 0x000038, 0x380000);
    if (a<47.5) return vec4(0x000002, 0x060c18, 0x3060c0, 0x800000);
    if (a<48.5) return vec4(0x007cc6, 0xceded6, 0xf6e6c6, 0x7c0000);
    if (a<49.5) return vec4(0x001030, 0xf03030, 0x303030, 0xfc0000);
    if (a<50.5) return vec4(0x0078cc, 0xcc0c18, 0x3060cc, 0xfc0000);
    if (a<51.5) return vec4(0x0078cc, 0x0c0c38, 0x0c0ccc, 0x780000);
    if (a<52.5) return vec4(0x000c1c, 0x3c6ccc, 0xfe0c0c, 0x1e0000);
    if (a<53.5) return vec4(0x00fcc0, 0xc0c0f8, 0x0c0ccc, 0x780000);
    if (a<54.5) return vec4(0x003860, 0xc0c0f8, 0xcccccc, 0x780000);
    if (a<55.5) return vec4(0x00fec6, 0xc6060c, 0x183030, 0x300000);
    if (a<56.5) return vec4(0x0078cc, 0xcccc78, 0xcccccc, 0x780000);
    if (a<57.5) return vec4(0x0078cc, 0xcccc7c, 0x181830, 0x700000);
    if (a<58.5) return vec4(0x000000, 0x383800, 0x003838, 0x000000);
    if (a<59.5) return vec4(0x000000, 0x383800, 0x003838, 0x183000);
    if (a<60.5) return vec4(0x000c18, 0x3060c0, 0x603018, 0x0c0000);
    if (a<61.5) return vec4(0x000000, 0x007e00, 0x7e0000, 0x000000);
    if (a<62.5) return vec4(0x006030, 0x180c06, 0x0c1830, 0x600000);
    if (a<63.5) return vec4(0x0078cc, 0x0c1830, 0x300030, 0x300000);
    if (a<64.5) return vec4(0x007cc6, 0xc6dede, 0xdec0c0, 0x7c0000);
    if (a<65.5) return vec4(0x003078, 0xcccccc, 0xfccccc, 0xcc0000);
    if (a<66.5) return vec4(0x00fc66, 0x66667c, 0x666666, 0xfc0000);
    if (a<67.5) return vec4(0x003c66, 0xc6c0c0, 0xc0c666, 0x3c0000);
    if (a<68.5) return vec4(0x00f86c, 0x666666, 0x66666c, 0xf80000);
    if (a<69.5) return vec4(0x00fe62, 0x60647c, 0x646062, 0xfe0000);
    if (a<70.5) return vec4(0x00fe66, 0x62647c, 0x646060, 0xf00000);
    if (a<71.5) return vec4(0x003c66, 0xc6c0c0, 0xcec666, 0x3e0000);
    if (a<72.5) return vec4(0x00cccc, 0xccccfc, 0xcccccc, 0xcc0000);
    if (a<73.5) return vec4(0x007830, 0x303030, 0x303030, 0x780000);
    if (a<74.5) return vec4(0x001e0c, 0x0c0c0c, 0xcccccc, 0x780000);
    if (a<75.5) return vec4(0x00e666, 0x6c6c78, 0x6c6c66, 0xe60000);
    if (a<76.5) return vec4(0x00f060, 0x606060, 0x626666, 0xfe0000);
    if (a<77.5) return vec4(0x00c6ee, 0xfefed6, 0xc6c6c6, 0xc60000);
    if (a<78.5) return vec4(0x00c6c6, 0xe6f6fe, 0xdecec6, 0xc60000);
    if (a<79.5) return vec4(0x00386c, 0xc6c6c6, 0xc6c66c, 0x380000);
    if (a<80.5) return vec4(0x00fc66, 0x66667c, 0x606060, 0xf00000);
    if (a<81.5) return vec4(0x00386c, 0xc6c6c6, 0xcede7c, 0x0c1e00);
    if (a<82.5) return vec4(0x00fc66, 0x66667c, 0x6c6666, 0xe60000);
    if (a<83.5) return vec4(0x0078cc, 0xccc070, 0x18cccc, 0x780000);
    if (a<84.5) return vec4(0x00fcb4, 0x303030, 0x303030, 0x780000);
    if (a<85.5) return vec4(0x00cccc, 0xcccccc, 0xcccccc, 0x780000);
    if (a<86.5) return vec4(0x00cccc, 0xcccccc, 0xcccc78, 0x300000);
    if (a<87.5) return vec4(0x00c6c6, 0xc6c6d6, 0xd66c6c, 0x6c0000);
    if (a<88.5) return vec4(0x00cccc, 0xcc7830, 0x78cccc, 0xcc0000);
    if (a<89.5) return vec4(0x00cccc, 0xcccc78, 0x303030, 0x780000);
    if (a<90.5) return vec4(0x00fece, 0x981830, 0x6062c6, 0xfe0000);
    if (a<91.5) return vec4(0x003c30, 0x303030, 0x303030, 0x3c0000);
    if (a<92.5) return vec4(0x000080, 0xc06030, 0x180c06, 0x020000);
    if (a<93.5) return vec4(0x003c0c, 0x0c0c0c, 0x0c0c0c, 0x3c0000);
    if (a<94.5) return vec4(0x10386c, 0xc60000, 0x000000, 0x000000);
    if (a<95.5) return vec4(0x000000, 0x000000, 0x000000, 0x00ff00);
    if (a<96.5) return vec4(0x303018, 0x000000, 0x000000, 0x000000);
    if (a<97.5) return vec4(0x000000, 0x00780c, 0x7ccccc, 0x760000);
    if (a<98.5) return vec4(0x00e060, 0x607c66, 0x666666, 0xdc0000);
    if (a<99.5) return vec4(0x000000, 0x0078cc, 0xc0c0cc, 0x780000);
    if (a<100.5) return vec4(0x001c0c, 0x0c7ccc, 0xcccccc, 0x760000);
    if (a<101.5) return vec4(0x000000, 0x0078cc, 0xfcc0cc, 0x780000);
    if (a<102.5) return vec4(0x00386c, 0x6060f8, 0x606060, 0xf00000);
    if (a<103.5) return vec4(0x000000, 0x0076cc, 0xcccc7c, 0x0ccc78);
    if (a<104.5) return vec4(0x00e060, 0x606c76, 0x666666, 0xe60000);
    if (a<105.5) return vec4(0x001818, 0x007818, 0x181818, 0x7e0000);
    if (a<106.5) return vec4(0x000c0c, 0x003c0c, 0x0c0c0c, 0xcccc78);
    if (a<107.5) return vec4(0x00e060, 0x60666c, 0x786c66, 0xe60000);
    if (a<108.5) return vec4(0x007818, 0x181818, 0x181818, 0x7e0000);
    if (a<109.5) return vec4(0x000000, 0x00fcd6, 0xd6d6d6, 0xc60000);
    if (a<110.5) return vec4(0x000000, 0x00f8cc, 0xcccccc, 0xcc0000);
    if (a<111.5) return vec4(0x000000, 0x0078cc, 0xcccccc, 0x780000);
    if (a<112.5) return vec4(0x000000, 0x00dc66, 0x666666, 0x7c60f0);
    if (a<113.5) return vec4(0x000000, 0x0076cc, 0xcccccc, 0x7c0c1e);
    if (a<114.5) return vec4(0x000000, 0x00ec6e, 0x766060, 0xf00000);
    if (a<115.5) return vec4(0x000000, 0x0078cc, 0x6018cc, 0x780000);
    if (a<116.5) return vec4(0x000020, 0x60fc60, 0x60606c, 0x380000);
    if (a<117.5) return vec4(0x000000, 0x00cccc, 0xcccccc, 0x760000);
    if (a<118.5) return vec4(0x000000, 0x00cccc, 0xcccc78, 0x300000);
    if (a<119.5) return vec4(0x000000, 0x00c6c6, 0xd6d66c, 0x6c0000);
    if (a<120.5) return vec4(0x000000, 0x00c66c, 0x38386c, 0xc60000);
    if (a<121.5) return vec4(0x000000, 0x006666, 0x66663c, 0x0c18f0);
    if (a<122.5) return vec4(0x000000, 0x00fc8c, 0x1860c4, 0xfc0000);
    if (a<123.5) return vec4(0x001c30, 0x3060c0, 0x603030, 0x1c0000);
    if (a<124.5) return vec4(0x001818, 0x181800, 0x181818, 0x180000);
    if (a<125.5) return vec4(0x00e030, 0x30180c, 0x183030, 0xe00000);
    if (a<126.5) return vec4(0x0073da, 0xce0000, 0x000000, 0x000000);
    if (a<127.5) return vec4(0x000000, 0x10386c, 0xc6c6fe, 0x000000);
    if (a<128.5) return vec4(0x0078cc, 0xccc0c0, 0xc0cccc, 0x783060);
    if (a<129.5) return vec4(0x00cccc, 0x00cccc, 0xcccccc, 0x760000);
    if (a<130.5) return vec4(0x0c1830, 0x0078cc, 0xfcc0cc, 0x780000);
    if (a<131.5) return vec4(0x3078cc, 0x00780c, 0x7ccccc, 0x760000);
    if (a<132.5) return vec4(0x00cccc, 0x00780c, 0x7ccccc, 0x760000);
    if (a<133.5) return vec4(0xc06030, 0x00780c, 0x7ccccc, 0x760000);
    if (a<134.5) return vec4(0x386c6c, 0x38f80c, 0x7ccccc, 0x760000);
    if (a<135.5) return vec4(0x000000, 0x0078cc, 0xc0c0cc, 0x783060);
    if (a<136.5) return vec4(0x3078cc, 0x0078cc, 0xfcc0c0, 0x7c0000);
    if (a<137.5) return vec4(0x00cccc, 0x0078cc, 0xfcc0c0, 0x7c0000);
    if (a<138.5) return vec4(0xc06030, 0x0078cc, 0xfcc0c0, 0x7c0000);
    if (a<139.5) return vec4(0x006c6c, 0x007818, 0x181818, 0x7e0000);
    if (a<140.5) return vec4(0x10386c, 0x007818, 0x181818, 0x7e0000);
    if (a<141.5) return vec4(0x603018, 0x007818, 0x181818, 0x7e0000);
    if (a<142.5) return vec4(0x00cc00, 0x3078cc, 0xccfccc, 0xcc0000);
    if (a<143.5) return vec4(0x78cccc, 0x7878cc, 0xccfccc, 0xcc0000);
    if (a<144.5) return vec4(0x0c1800, 0xfcc4c0, 0xf8c0c4, 0xfc0000);
    if (a<145.5) return vec4(0x000000, 0x00fe1b, 0x7fd8d8, 0xef0000);
    if (a<146.5) return vec4(0x003e78, 0xd8d8fe, 0xd8d8d8, 0xde0000);
    if (a<147.5) return vec4(0x3078cc, 0x0078cc, 0xcccccc, 0x780000);
    if (a<148.5) return vec4(0x00cccc, 0x0078cc, 0xcccccc, 0x780000);
    if (a<149.5) return vec4(0xc06030, 0x0078cc, 0xcccccc, 0x780000);
    if (a<150.5) return vec4(0x3078cc, 0x00cccc, 0xcccccc, 0x760000);
    if (a<151.5) return vec4(0xc06030, 0x00cccc, 0xcccccc, 0x760000);
    if (a<152.5) return vec4(0x006666, 0x006666, 0x66663c, 0x0c18f0);
    if (a<153.5) return vec4(0x00cc00, 0x78cccc, 0xcccccc, 0x780000);
    if (a<154.5) return vec4(0xcc00cc, 0xcccccc, 0xcccccc, 0x780000);
    if (a<155.5) return vec4(0x000000, 0x0078cc, 0xdceccc, 0x780000);
    if (a<156.5) return vec4(0x3c6660, 0x6060fc, 0x6060c0, 0xfe0000);
    if (a<157.5) return vec4(0x003a6c, 0xced6d6, 0xd6e66c, 0xb80000);
    if (a<158.5) return vec4(0x000000, 0x0000c6, 0x6c386c, 0xc60000);
    if (a<159.5) return vec4(0x0e1b18, 0x187e18, 0x1818d8, 0x700000);
    if (a<160.5) return vec4(0x0c1830, 0x00780c, 0x7ccccc, 0x760000);
    if (a<161.5) return vec4(0x0c1830, 0x007818, 0x181818, 0x7e0000);
    if (a<162.5) return vec4(0x0c1830, 0x0078cc, 0xcccccc, 0x780000);
    if (a<163.5) return vec4(0x0c1830, 0x00cccc, 0xcccccc, 0x760000);
    if (a<164.5) return vec4(0x0076dc, 0x00f8cc, 0xcccccc, 0xcc0000);
    if (a<165.5) return vec4(0x76dc00, 0xc6e6f6, 0xdecec6, 0xc60000);
    if (a<166.5) return vec4(0x0078cc, 0xcc7e00, 0xfe0000, 0x000000);
    if (a<167.5) return vec4(0x0078cc, 0xcc7800, 0xfe0000, 0x000000);
    if (a<168.5) return vec4(0x003030, 0x003060, 0xc0c0cc, 0x780000);
    if (a<169.5) return vec4(0x003844, 0xbaaaba, 0xb2aa44, 0x380000);
    if (a<170.5) return vec4(0x000000, 0x0000fc, 0x0c0c0c, 0x000000);
    if (a<171.5) return vec4(0x0062e6, 0x6c7830, 0x6ec386, 0x0c1f00);
    if (a<172.5) return vec4(0x0063e6, 0x6c7837, 0x6fdbb3, 0x3f0300);
    if (a<173.5) return vec4(0x003030, 0x003030, 0x787878, 0x300000);
    if (a<174.5) return vec4(0x000000, 0x003366, 0xcccc66, 0x330000);
    if (a<175.5) return vec4(0x000000, 0x00cc66, 0x333366, 0xcc0000);
    if (a<176.5) return vec4(0x249249, 0x249249, 0x249249, 0x249249);
    if (a<177.5) return vec4(0x55aa55, 0xaa55aa, 0x55aa55, 0xaa55aa);
    if (a<178.5) return vec4(0x6ddbb6, 0x6ddbb6, 0x6ddbb6, 0x6ddbb6);
    if (a<179.5) return vec4(0x181818, 0x181818, 0x181818, 0x181818);
    if (a<180.5) return vec4(0x181818, 0x1818f8, 0x181818, 0x181818);
    if (a<181.5) return vec4(0x0c1800, 0x3078cc, 0xccfccc, 0xcc0000);
    if (a<182.5) return vec4(0x78cc00, 0x3078cc, 0xccfccc, 0xcc0000);
    if (a<183.5) return vec4(0x603000, 0x3078cc, 0xccfccc, 0xcc0000);
    if (a<184.5) return vec4(0x003844, 0xbaa2a2, 0xa2ba44, 0x380000);
    if (a<185.5) return vec4(0x666666, 0x66e606, 0x06e666, 0x666666);
    if (a<186.5) return vec4(0x666666, 0x666666, 0x666666, 0x666666);
    if (a<187.5) return vec4(0x000000, 0x00fe06, 0x06e666, 0x666666);
    if (a<188.5) return vec4(0x666666, 0x66e606, 0x06fe00, 0x000000);
    if (a<189.5) return vec4(0x003030, 0x78ccc0, 0xc0cc78, 0x303000);
    if (a<190.5) return vec4(0xcccccc, 0xcc78fc, 0x30fc30, 0x300000);
    if (a<191.5) return vec4(0x000000, 0x0000f8, 0x181818, 0x181818);
    if (a<192.5) return vec4(0x181818, 0x18181f, 0x000000, 0x000000);
    if (a<193.5) return vec4(0x181818, 0x1818ff, 0x000000, 0x000000);
    if (a<194.5) return vec4(0x000000, 0x0000ff, 0x181818, 0x181818);
    if (a<195.5) return vec4(0x181818, 0x18181f, 0x181818, 0x181818);
    if (a<196.5) return vec4(0x000000, 0x0000ff, 0x000000, 0x000000);
    if (a<197.5) return vec4(0x181818, 0x1818ff, 0x181818, 0x181818);
    if (a<198.5) return vec4(0x0076dc, 0x00780c, 0x7ccccc, 0x760000);
    if (a<199.5) return vec4(0x76dc00, 0x3078cc, 0xccfccc, 0xcc0000);
    if (a<200.5) return vec4(0x666666, 0x666760, 0x607f00, 0x000000);
    if (a<201.5) return vec4(0x000000, 0x007f60, 0x606766, 0x666666);
    if (a<202.5) return vec4(0x666666, 0x66e700, 0x00ff00, 0x000000);
    if (a<203.5) return vec4(0x000000, 0x00ff00, 0x00e766, 0x666666);
    if (a<204.5) return vec4(0x666666, 0x666760, 0x606766, 0x666666);
    if (a<205.5) return vec4(0x000000, 0x00ff00, 0x00ff00, 0x000000);
    if (a<206.5) return vec4(0x666666, 0x66e700, 0x00e766, 0x666666);
    if (a<207.5) return vec4(0x000000, 0x0000c6, 0x7c6c7c, 0xc60000);
    if (a<208.5) return vec4(0xcc30d8, 0x0c067e, 0xc6c6c6, 0x7c0000);
    if (a<209.5) return vec4(0x00f86c, 0x6666f6, 0x66666c, 0xf80000);
    if (a<210.5) return vec4(0x78cc00, 0xfcc4c0, 0xf8c0c4, 0xfc0000);
    if (a<211.5) return vec4(0x00cc00, 0xfcc4c0, 0xf8c0c4, 0xfc0000);
    if (a<212.5) return vec4(0x603000, 0xfcc4c0, 0xf8c0c4, 0xfc0000);
    if (a<213.5) return vec4(0x00f030, 0x3030fc, 0x000000, 0x000000);
    if (a<214.5) return vec4(0x183000, 0x783030, 0x303030, 0x780000);
    if (a<215.5) return vec4(0x78cc00, 0x783030, 0x303030, 0x780000);
    if (a<216.5) return vec4(0x00cc00, 0x783030, 0x303030, 0x780000);
    if (a<217.5) return vec4(0x181818, 0x1818f8, 0x000000, 0x000000);
    if (a<218.5) return vec4(0x000000, 0x00001f, 0x181818, 0x181818);
    if (a<219.5) return vec4(0xffffff, 0xffffff, 0xffffff, 0xffffff);
    if (a<220.5) return vec4(0x000000, 0x000000, 0xffffff, 0xffffff);
    if (a<221.5) return vec4(0x001818, 0x181800, 0x181818, 0x180000);
    if (a<222.5) return vec4(0x603000, 0x783030, 0x303030, 0x780000);
    if (a<223.5) return vec4(0xffffff, 0xffffff, 0x000000, 0x000000);
    if (a<224.5) return vec4(0x183000, 0x78cccc, 0xcccccc, 0x780000);
    if (a<225.5) return vec4(0x0078cc, 0xccd8cc, 0xccccf8, 0xc06000);
    if (a<226.5) return vec4(0x78cc00, 0x78cccc, 0xcccccc, 0x780000);
    if (a<227.5) return vec4(0x603000, 0x78cccc, 0xcccccc, 0x780000);
    if (a<228.5) return vec4(0x0076dc, 0x0078cc, 0xcccccc, 0x780000);
    if (a<229.5) return vec4(0x76dc00, 0x78cccc, 0xcccccc, 0x780000);
    if (a<230.5) return vec4(0x000000, 0x006666, 0x666666, 0x7b60c0);
    if (a<231.5) return vec4(0x0000e0, 0x607c66, 0x667c60, 0xf00000);
    if (a<232.5) return vec4(0x00f060, 0x7c6666, 0x667c60, 0xf00000);
    if (a<233.5) return vec4(0x183000, 0xcccccc, 0xcccccc, 0x780000);
    if (a<234.5) return vec4(0x78cc00, 0xcccccc, 0xcccccc, 0x780000);
    if (a<235.5) return vec4(0x603000, 0xcccccc, 0xcccccc, 0x780000);
    if (a<236.5) return vec4(0x060c18, 0x006666, 0x66663c, 0x0c18f0);
    if (a<237.5) return vec4(0x183000, 0xcccccc, 0x783030, 0x780000);
    if (a<238.5) return vec4(0x00fc00, 0x000000, 0x000000, 0x000000);
    if (a<239.5) return vec4(0x0c1830, 0x000000, 0x000000, 0x000000);
    if (a<240.5) return vec4(0x000000, 0x0000fc, 0x000000, 0x000000);
    if (a<241.5) return vec4(0x000030, 0x30fc30, 0x3000fc, 0x000000);
    if (a<242.5) return vec4(0x000000, 0x0000f8, 0x0000f8, 0x000000);
    if (a<243.5) return vec4(0xe03366, 0x3cf837, 0x6fdbb3, 0x3f0300);
    if (a<244.5) return vec4(0x007fdb, 0xdbdb7b, 0x1b1b1b, 0x1b0000);
    if (a<245.5) return vec4(0x007e63, 0x303c66, 0x663c0c, 0xc67e00);
    if (a<246.5) return vec4(0x000030, 0x3000fc, 0x003030, 0x000000);
    if (a<247.5) return vec4(0x000000, 0x000000, 0x000000, 0x003070);
    if (a<248.5) return vec4(0x003c66, 0x66663c, 0x000000, 0x000000);
    if (a<249.5) return vec4(0x00cc00, 0x000000, 0x000000, 0x000000);
    if (a<250.5) return vec4(0x000000, 0x000018, 0x000000, 0x000000);
    if (a<251.5) return vec4(0x003070, 0x303078, 0x000000, 0x000000);
    if (a<252.5) return vec4(0x00780c, 0x380c78, 0x000000, 0x000000);
    if (a<253.5) return vec4(0x00780c, 0x18307c, 0x000000, 0x000000);
    if (a<254.5) return vec4(0x000000, 0xfcfcfc, 0xfcfcfc, 0x000000);

    return vec4(0);
}


/**
 * x [0..8>
 * y [0..12>
 **/
float drawCh(in vec4 character, in float x, in float y)
{
    y = floor(11.5 - y);
    float word = 0.0;
    if (y>5.9)
    {
        if (y>8.9) word = character.x;
        else       word = character.y;
    }
    else
    {
        if (y>2.9) word = character.z;
        else       word = character.a;
    }
    float n = floor(7.0-x + 8.0*mod(y,3.0));
    return mod(floor(word/pow(2.0,n)), 2.0);
}




void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    fragColor = vec4(0.0);

    //write iResolution into BufA (store it for the next Frame)
    if (fragCoord.x<0.9 && fragCoord.y<0.9) {
        fragColor = vec4(iResolution, 1.0);
        return;
    }

    //read iResolution of the previous Frame
    vec3 iPreviousResolution = texture2D(iChannel0, vec2(0.0)).xyz;


    vec2 pixel = vec2(floor(fragCoord.x), iResolution.y - 1.0 - floor(fragCoord.y));
    vec2 char  = floor(pixel / CHAR_SIZE);

    if (char.x < 31.5 && char.y < 7.5)
    {
        if (iResolution != iPreviousResolution)
        {
            vec4 ch = asciiToSprite(char.x + char.y*32.0);
            fragColor = vec4(vec3(drawCh(ch, mod(pixel.x, CHAR_SIZE.x), mod(pixel.y, CHAR_SIZE.y))), 1.0);
        }
        else
        {
            fragColor = texture2D(iChannel0, fragCoord / iResolution.xy);
        }
    }
}
