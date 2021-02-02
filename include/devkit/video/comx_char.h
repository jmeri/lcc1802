#ifndef _COMX_CHAR_H
#define _COMX_CHAR_H

//comx_character_set header

#define CHAR_COLOR1 0xC000 
#define CHAR_COLOR2 0x8000 
#define CHAR_COLOR3 0x4000 
#define CHAR_COLOR4 0x1000 

// Color definition with textcolordefinition(3)
// 			
// textcolor		0 / 1		2 / 3	
// COLORx	
// 0x1000			BLACK		RED		
// 0x4000			BLUE		MAGENTA 
// 0x8000			GREEN		YELLOW		
// 0xC000			CYAN		WHITE	

// COLOR1 and COLOR2 are used for systems with 128 characters and 3rd color bit in charcater bit 7
// COLOR3 and COLOR4 are used for systems with 256 charcaters and no 3rd color bit (i.e. 4 colors only: BLACK, BLUE, GREEN, CYAN)

#if !defined __COMX__ || !defined __PECOM__
static const uint8_t shapes_comx_0[] =
{
	0x1c, 0x22, 0x02, 0x1a, 0x2a, 0x2a, 0x1c, 0x00, 0x00,
	0x08, 0x1C, 0x22, 0x22, 0x3E, 0x22, 0x22, 0x00, 0x00,
	0x3C, 0x12, 0x12, 0x1C, 0x12, 0x12, 0x3C, 0x00, 0x00,
	0x1C, 0x22, 0x20, 0x20, 0x20, 0x22, 0x1C, 0x00, 0x00,
	0x38, 0x24, 0x22, 0x22, 0x22, 0x24, 0x38, 0x00, 0x00,
	0x3E, 0x20, 0x20, 0x3C, 0x20, 0x20, 0x3E, 0x00, 0x00,
	0x3E, 0x20, 0x20, 0x3C, 0x20, 0x20, 0x20, 0x00, 0x00,
	0x1C, 0x20, 0x20, 0x2E, 0x22, 0x22, 0x1C, 0x00, 0x00,
	0x22, 0x22, 0x22, 0x3E, 0x22, 0x22, 0x22, 0x00, 0x00,
	0x1C, 0x08, 0x08, 0x08, 0x08, 0x08, 0x1C, 0x00, 0x00,
	0x0E, 0x04, 0x04, 0x04, 0x04, 0x24, 0x18, 0x00, 0x00,
	0x22, 0x24, 0x28, 0x30, 0x28, 0x24, 0x22, 0x00, 0x00,
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x3E, 0x00, 0x00,
	0x22, 0x36, 0x2A, 0x2A, 0x22, 0x22, 0x22, 0x00, 0x00,
	0x22, 0x22, 0x32, 0x2A, 0x26, 0x22, 0x22, 0x00, 0x00,
	0x1C, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1C, 0x00, 0x00,
	0x3C, 0x22, 0x22, 0x3C, 0x20, 0x20, 0x20, 0x00, 0x00,
	0x1C, 0x22, 0x22, 0x22, 0x2A, 0x24, 0x1A, 0x00, 0x00,
	0x3C, 0x22, 0x22, 0x3C, 0x28, 0x24, 0x22, 0x00, 0x00,
	0x1C, 0x22, 0x20, 0x1C, 0x02, 0x22, 0x1C, 0x00, 0x00,
	0x3E, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00,
	0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x1C, 0x00, 0x00,
	0x22, 0x22, 0x22, 0x14, 0x14, 0x08, 0x08, 0x00, 0x00,
	0x22, 0x22, 0x22, 0x2A, 0x2A, 0x36, 0x22, 0x00, 0x00,
	0x22, 0x22, 0x14, 0x08, 0x14, 0x22, 0x22, 0x00, 0x00,
	0x22, 0x22, 0x14, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00,
	0x3E, 0x02, 0x04, 0x08, 0x10, 0x20, 0x3E, 0x00, 0x00,
	0x0E, 0x08, 0x08, 0x08, 0x08, 0x08, 0x0E, 0x00, 0x00,
	0x00, 0x20, 0x10, 0x08, 0x04, 0x02, 0x00, 0x00, 0x00,
	0x1C, 0x04, 0x04, 0x04, 0x04, 0x04, 0x1C, 0x00, 0x00,
	0x08, 0x1C, 0x3E, 0x08, 0x08, 0x08, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00,
};

static const uint8_t shapes_comx_32[] =
{
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x08, 0x08, 0x08, 0x08, 0x08, 0x00, 0x08, 0x00, 0x00,
	0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x14, 0x14, 0x3E, 0x14, 0x3E, 0x14, 0x14, 0x00, 0x00,
	0x08, 0x1E, 0x28, 0x1C, 0x0A, 0x3C, 0x08, 0x00, 0x00,
	0x32, 0x32, 0x04, 0x08, 0x10, 0x26, 0x26, 0x00, 0x00,
	0x10, 0x28, 0x28, 0x10, 0x2A, 0x24, 0x1A, 0x00, 0x00,
	0x08, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x02, 0x04, 0x08, 0x08, 0x08, 0x04, 0x02, 0x00, 0x00,
	0x20, 0x10, 0x08, 0x08, 0x08, 0x10, 0x20, 0x00, 0x00,
	0x08, 0x2A, 0x1C, 0x08, 0x1C, 0x2A, 0x08, 0x00, 0x00,
	0x00, 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x10, 0x00,
	0x00, 0x00, 0x00, 0x3E, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00,
	0x00, 0x02, 0x04, 0x08, 0x10, 0x20, 0x00, 0x00, 0x00,
	0x1C, 0x22, 0x26, 0x2A, 0x32, 0x22, 0x1C, 0x00, 0x00,
	0x08, 0x18, 0x08, 0x08, 0x08, 0x08, 0x1C, 0x00, 0x00,
	0x1C, 0x22, 0x22, 0x0C, 0x10, 0x20, 0x3E, 0x00, 0x00,
	0x1C, 0x22, 0x02, 0x0C, 0x02, 0x22, 0x1C, 0x00, 0x00,
	0x04, 0x0C, 0x14, 0x24, 0x3E, 0x04, 0x04, 0x00, 0x00,
	0x3E, 0x30, 0x3C, 0x02, 0x02, 0x22, 0x1C, 0x00, 0x00,
	0x0C, 0x10, 0x20, 0x3C, 0x22, 0x22, 0x1C, 0x00, 0x00,
	0x3E, 0x02, 0x04, 0x08, 0x10, 0x10, 0x10, 0x00, 0x00,
	0x1C, 0x22, 0x22, 0x1C, 0x22, 0x22, 0x1C, 0x00, 0x00,
	0x1C, 0x22, 0x22, 0x1E, 0x02, 0x04, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x08, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x08, 0x00, 0x00, 0x08, 0x08, 0x10, 0x00,
	0x04, 0x08, 0x10, 0x20, 0x10, 0x08, 0x04, 0x00, 0x00,
	0x00, 0x00, 0x3E, 0x00, 0x3E, 0x00, 0x00, 0x00, 0x00,
	0x20, 0x10, 0x08, 0x04, 0x08, 0x10, 0x20, 0x00, 0x00,
	0x1C, 0x22, 0x04, 0x08, 0x08, 0x00, 0x08, 0x00, 0x00,
};
#endif

static const uint8_t shapes_comx_lowercase[] =
{
    0x00, 0x00, 0x18, 0x04, 0x1C, 0x24, 0x1A, 0x00, 0x00, 
    0x20, 0x20, 0x2C, 0x32, 0x22, 0x32, 0x2C, 0x00, 0x00,
    0x00, 0x00, 0x1C, 0x20, 0x20, 0x20, 0x1C, 0x00, 0x00,
    0x02, 0x02, 0x1A, 0x26, 0x22, 0x26, 0x1A, 0x00, 0x00,
    0x00, 0x00, 0x1C, 0x22, 0x3E, 0x20, 0x1C, 0x00, 0x00,
    0x0C, 0x12, 0x10, 0x38, 0x10, 0x10, 0x10, 0x00, 0x00,
    0x00, 0x00, 0x1A, 0x26, 0x1A, 0x02, 0x1C, 0x00, 0x00,
    0x20, 0x20, 0x2C, 0x32, 0x22, 0x22, 0x22, 0x00, 0x00,
    0x08, 0x00, 0x18, 0x08, 0x08, 0x08, 0x1C, 0x00, 0x00,
    0x02, 0x00, 0x06, 0x02, 0x02, 0x22, 0x1C, 0x00, 0x00,
    0x20, 0x20, 0x22, 0x24, 0x28, 0x34, 0x22, 0x00, 0x00,
    0x0C, 0x04, 0x04, 0x04, 0x04, 0x04, 0x0E, 0x00, 0x00,
    0x00, 0x00, 0x34, 0x2A, 0x2A, 0x2A, 0x2A, 0x00, 0x00,
    0x00, 0x00, 0x2C, 0x32, 0x22, 0x22, 0x22, 0x00, 0x00,
    0x00, 0x00, 0x1C, 0x22, 0x22, 0x22, 0x1C, 0x00, 0x00,
    0x00, 0x00, 0x3C, 0x22, 0x32, 0x2C, 0x20, 0x00, 0x00,
    0x00, 0x00, 0x1E, 0x22, 0x26, 0x1A, 0x02, 0x00, 0x00,
    0x00, 0x00, 0x2C, 0x32, 0x20, 0x20, 0x20, 0x00, 0x00,
    0x00, 0x00, 0x1C, 0x20, 0x1C, 0x02, 0x1C, 0x00, 0x00,
    0x10, 0x10, 0x38, 0x10, 0x10, 0x12, 0x0C, 0x00, 0x00,
    0x00, 0x00, 0x22, 0x22, 0x22, 0x26, 0x1A, 0x00, 0x00,
    0x00, 0x00, 0x22, 0x22, 0x22, 0x14, 0x08, 0x00, 0x00,
    0x00, 0x00, 0x22, 0x22, 0x2A, 0x2A, 0x14, 0x00, 0x00,
    0x00, 0x00, 0x22, 0x14, 0x08, 0x14, 0x22, 0x00, 0x00,
    0x00, 0x00, 0x22, 0x26, 0x1A, 0x02, 0x1C, 0x00, 0x00,
    0x00, 0x00, 0x3E, 0x04, 0x08, 0x10, 0x3E, 0x00, 0x00 
};

void character_set(uint8_t number);

#endif // _COMX_CHAR_H
