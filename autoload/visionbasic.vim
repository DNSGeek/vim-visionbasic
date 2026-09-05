" Vision BASIC keyword database and helper functions.
" Generated from the C64 IDE VisionBASIC 1.1 plugin definition.
" Source: https://www.visionbasic.net
" NOTE: Generated file — regenerate rather than editing by hand.
scriptencoding utf-8

let s:save_cpo = &cpoptions
set cpoptions&vim

" ─── Keyword database ────────────────────────────────────────────────────────
let s:db = {}
let s:db['ABS'] = {'g': 'Math', 's': 'ABS(vov)', 'd': 'Returns the absolute value of vov.', 'e': 'A = ABS(B)', 'n': 'Parentheses are NOT allowed in mathematical expressions, and order of operations is not followed: expressions are evaluated strictly left to right. 4+3*5-2*6 evaluates as (((4+3)*5)-2)*6 = 198.', 'f': 'M'}
let s:db['ADD'] = {'g': 'Math', 's': 'ADD vop = vov + vov', 'd': 'Fast addition of two values into an integer variable, tag or pointer.', 'e': 'ADD A = B + 1', 'n': 'Works only with non-arrayed integer variables, tags and pointers.', 'f': 'mM'}
let s:db['ADSR'] = {'g': 'SID sound', 's': 'ADSR attack, decay, sustain, release', 'd': 'Specifies the attack, decay, sustain and release parameters for the current voice.', 'e': 'ADSR 0,9,0,0', 'n': 'Requires a current VOICE to be selected before calling. All parameters can be values or variables; a parameter left off reuses the previous value, or 0 if none was set. 0 disables, 1 enables.', 'p': [['attack', '0-15', '', 0], ['decay', '0-15', '', 0], ['sustain', '0-15', '', 0], ['release', '0-15', '', 0]]}
let s:db['ALLMOBS'] = {'g': 'Bitmap & sprites', 's': 'ALLMOBS x0, y0, x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7', 'd': 'Sets all eight sprite positions in a single command.', 'e': 'ALLMOBS 24,50,64,50,104,50,144,50,184,50,224,50,264,50,304,50', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.'}
let s:db['AND'] = {'g': 'Word operators', 's': 'vov AND vov', 'd': 'Performs a logical (bitwise) AND.', 'e': 'A = B AND 15'}
let s:db['ASC'] = {'g': 'Strings', 's': 'ASC(string)', 'd': 'Returns the ASCII value of string.', 'e': 'A = ASC(N$)'}
let s:db['ASSEM'] = {'g': 'Assembler mode', 's': 'ASSEM', 'd': 'Switches into assembler mode. Following lines are assembled as 6502 machine language until BASIC switches back.', 'e': 'ASSEM', 'n': 'In ML mode, mnemonics are enclosed in [] brackets and a semicolon (;) starts a comment, e.g. 100 [LDA1: ORA #1: STA1] ; TURN BASIC ROM ON. Branches and jumps take a line number directly, e.g. JMP1000.', 'w': 'In ML mode mnemonics are wrapped in `[]` and `;` starts a comment. Branches and jumps may target a BASIC line number directly, e.g. `JMP1000`.'}
let s:db['ATN'] = {'g': 'Math', 's': 'ATN(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['AUTO'] = {'g': 'Editor & compiler', 's': 'AUTO', 'd': 'Undocumented automatic line numbering.', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.'}
let s:db['BANK'] = {'g': 'Memory & expansion RAM', 's': 'BANK [bank[-bank]][, on/off]', 'd': 'Displays the current bank number, or changes to the bank specified. With on/off, enables or disables the banks.', 'e': 'BANK 2', 'n': 'In a text video context BANK also selects the active 16K VIC-II memory bank; that is not for setting REU banks, and you will probably never need it.', 'p': [['bank', 'integer', 'Bank, or range of banks, to select or toggle', 1], ['on/off', '0-1', '1 enables the banks, 0 disables them', 1]]}
let s:db['BASIC'] = {'g': 'Assembler mode', 's': 'BASIC', 'd': 'Switches out of assembler mode and back into BASIC.', 'e': 'BASIC'}
let s:db['BITMAP'] = {'g': 'Bitmap & sprites', 's': 'BITMAP [bmp, multicolor, map, drawto, screen, color1, color2, color3, clearcol, clearmap]', 'd': 'Turns bitmap mode and multicolor mode on (1) or off (0), and sets the visible map, draw-to screen and colors.', 'e': 'BITMAP 1,0,0,0,1,0,1,2,1,1', 'n': 'All parameters can be values or variables. If a parameter is left off, a default or previous value is used.', 'p': [['bmp', '0-1', 'Turns bitmap mode on or off', 1], ['multicolor', '0-1', 'Turns multicolor mode on or off', 1], ['map', '0-7', 'Which bitmap screen is visible', 1], ['drawto', '0-7', 'Which screen the drawing commands draw to', 1], ['screen', 'integer', 'Screen used for the bitmap colors', 1], ['color1', '0-15', '', 1], ['color2', '0-15', '', 1], ['color3', '0-15', '', 1], ['clearcol', '0-1', '1 clears the color screen', 1], ['clearmap', '0-1', '1 clears the bitmap', 1]]}
let s:db['BLANK'] = {'g': 'Text screen', 's': 'BLANK [blank[, bg, bars1, bars2]]', 'd': 'Blanks or restores the screen.', 'e': 'BLANK 1,0,1,2', 'p': [['blank', '0-1', '1 blanks the screen, 0 un-blanks it', 1], ['bg', '0-15', 'Background color', 1], ['bars1', '0-15', 'First bar color', 1], ['bars2', '0-15', 'Second bar color', 1]]}
let s:db['BMPCLR'] = {'g': 'Bitmap & sprites', 's': 'BMPCLR [clearmap[, clearcol]]', 'd': 'Clears the currently visible bitmap screen if clearmap is 1, and the color screen if clearcol is 1. If neither argument is specified, clears both.', 'e': 'BMPCLR 1,1', 'n': 'All parameters can be values or variables. If a parameter is left off, a default or previous value is used.'}
let s:db['BMPCOL'] = {'g': 'Bitmap & sprites', 's': 'BMPCOL screen, color1, color2, color3, clearcol[, clearmap]', 'd': 'Sets the bitmap colors that will be used and defines which screen to use. If clearmap is 1, clears the bitmap.', 'e': 'BMPCOL 1,0,1,2,1,1', 'n': 'All parameters can be values or variables. If a parameter is left off, a default or previous value is used.'}
let s:db['BMPLOC'] = {'g': 'Bitmap & sprites', 's': 'BMPLOC map, drawto', 'd': 'Sets which bitmap screen is visible and which screen the drawing commands draw to.', 'e': 'BMPLOC 0,1', 'n': 'All parameters can be values or variables. If a parameter is left off, a default or previous value is used.', 'p': [['map', '0-7', 'Bitmap screen to make visible', 0], ['drawto', '0-7', 'Bitmap screen the drawing commands affect', 0]]}
let s:db['BUTTON'] = {'g': 'Disk, files & input', 's': 'BUTTON joynum[, button#]', 'd': 'Returns 1 if the joystick button is pressed, 0 if not.', 'e': 'IF BUTTON 2 THEN GOSUB 1000', 'p': [['joynum', '1-2', 'Joystick port to read', 0], ['button#', '1-3', 'Which button to read; defaults to 1', 1]]}
let s:db['BYTES'] = {'g': 'Memory & expansion RAM', 's': 'BYTES count[, byte[, tag[, alignment]]]', 'd': 'When compiling, inserts count bytes of value byte, with a label of tag, aligned to alignment.', 'e': 'BYTES 256, 0, BUFFER, 256', 'p': [['count', 'integer', 'How many bytes to insert', 0], ['byte', '0-255', 'Fill value; 0 if not specified', 1], ['tag', 'string', 'Label for the block', 1], ['alignment', 'integer', 'Byte alignment of the block', 1]], 'f': 'm'}
let s:db['CATCH'] = {'g': 'Text screen', 's': 'CATCH rasterline', 'd': 'Acts like a WAIT command for the raster line.', 'e': 'CATCH 250', 'p': [['rasterline', '0-255', 'Raster line to wait for', 0]]}
let s:db['CHARPAT'] = {'g': 'Text screen', 's': 'CHARPAT character, charset', 'd': 'Moves the "code" pointer to point at a specific character image.', 'e': 'CHARPAT 65, 2', 'p': [['character', '0-255', 'The character to point at', 0], ['charset', 'integer', 'The character set the character is in', 0]]}
let s:db['CHARSET'] = {'g': 'Text screen', 's': 'CHARSET charset', 'd': 'Selects the desired character set.', 'e': 'CHARSET 2'}
let s:db['CHR$'] = {'g': 'Strings', 's': 'CHR$(vov[, count])', 'd': 'Appends ASCII character vov to a string, 1 or count times.', 'e': 'A$ = CHR$(147)'}
let s:db['CLOCK'] = {'g': 'System & interrupts', 's': 'CLOCK [jiffies]', 'd': 'Sets the CLOCK to jiffies if specified, or to 0 if not.', 'e': 'CLOCK 0'}
let s:db['CLOSE'] = {'g': 'Disk, files & input', 's': 'CLOSE file#, file#, ...', 'd': 'Closes one or more files.', 'e': 'CLOSE 2'}
let s:db['CLR'] = {'g': 'Variables & types', 's': 'CLR', 'd': 'Clears the memory used by all variables.'}
let s:db['CLS'] = {'g': 'Text screen', 's': 'CLS [pokecode[, color]]', 'd': 'Clears the current text screen. Uses space if pokecode is not specified. Colors are not changed unless color is specified.', 'e': 'CLS 32,1'}
let s:db['CMD'] = {'g': 'Disk, files & input', 's': 'CMD file#[, string]', 'd': 'Redirects all I/O to file file#. Optionally sends string to the file.', 'e': 'CMD 4'}
let s:db['CODE'] = {'g': 'Memory & expansion RAM', 's': 'CODE values ....', 'd': 'Any code following this command is stored in memory at the location indicated by the "code" pointer.', 'e': 'CODE 255,129,129,255', 'n': 'MOBPAT and CHARPAT move the "code" pointer to sprite shape data and character image data respectively.'}
let s:db['COLLISION'] = {'g': 'Bitmap & sprites', 's': 'COLLISION selection', 'd': 'Copies the collision registers and zeros the copied register.', 'e': 'COLLISION 0', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.', 'p': [['selection', '0-1', '0 copies the sprite-to-sprite register, 1 the sprite-to-foreground register', 0]]}
let s:db['COLORS'] = {'g': 'Text screen', 's': 'COLORS text, border, screen, color1, color2, color3', 'd': 'Sets the color registers.', 'e': 'COLORS 1,0,0,2,3,4', 'p': [['text', '0-15', 'Text color', 0], ['border', '0-15', 'Border color', 0], ['screen', '0-15', 'Background color', 0], ['color1', '0-15', 'Extra background color 1', 0], ['color2', '0-15', 'Extra background color 2', 0], ['color3', '0-15', 'Extra background color 3', 0]]}
let s:db['COMP'] = {'g': 'Editor & compiler', 's': 'COMP ["filename"[, devnum]]', 'd': 'Compiles the program in memory and optionally saves the result to a file.', 'e': 'COMP "MYPROG",8', 'p': [['filename', 'string', 'Output file name, 12 characters or less', 1], ['devnum', 'integer', 'Device to save to; the default device if omitted', 1]]}
let s:db['COMPARE'] = {'g': 'Math', 's': 'COMPARE vov, vov', 'd': 'Fast comparison of two values. Both parameters must be 2 byte integers.', 'e': 'COMPARE A, B', 'n': 'Works only with non-arrayed integer variables, tags and pointers.', 'f': 'mM'}
let s:db['CONT'] = {'g': 'Editor & compiler', 's': 'CONT', 'd': 'Continues a stopped program.', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.'}
let s:db['COPY'] = {'g': 'Memory & expansion RAM', 's': 'COPY end, start, new', 'd': 'Copies the memory from addresses start-end to address new.', 'e': 'COPY 8191,4096,49152'}
let s:db['COPYSET'] = {'g': 'Text screen', 's': 'COPYSET charset[, case]', 'd': 'Copies the C64 character set to location charset.', 'e': 'COPYSET 2, 0', 'p': [['charset', 'integer', 'Destination of the copied character set', 0], ['case', '0-1', '0 copies uppercase, 1 copies lowercase', 1]]}
let s:db['COS'] = {'g': 'Math', 's': 'COS(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['CUTOFF'] = {'g': 'SID sound', 's': 'CUTOFF freq', 'd': 'Sets the cutoff frequency to freq for the SID filtering system.', 'e': 'CUTOFF 1024', 'n': 'All parameters can be values or variables; a parameter left off reuses the previous value, or 0 if none was set. 0 disables, 1 enables.'}
let s:db['DATA'] = {'g': 'System & interrupts', 's': 'DATA val, val, ...', 'd': 'Holds data to be READ later.', 'e': 'DATA 1, 2, 3'}
let s:db['DEBUG'] = {'g': 'System & interrupts', 's': 'DEBUG 0 | 1', 'd': 'Enables (1) or disables (0) DEBUG mode, which reduces the number of passes for compilation. Results in slower and larger programs.', 'e': 'DEBUG 1', 'f': 'm'}
let s:db['DEC'] = {'g': 'Math', 's': 'DEC vop', 'd': 'Decrements vop by 1.', 'e': 'DEC A', 'n': 'Works with non-arrayed integer variables, tags and pointers, and also with non-arrayed decimal variables.', 'f': 'M'}
let s:db['DECIMAL'] = {'g': 'Variables & types', 's': 'DECIMAL variable[, variable[, variable[, ...]]]', 'd': 'Creates new decimal variables.', 'e': 'DECIMAL X, Y, RATE', 'n': 'Variables must start with a letter and can be up to 8 characters long; anything past 8 characters is silently ignored. The symbols !, @, #, %, & and ? and numbers are allowed. Variable names can contain keywords but cannot start with one. Strings must be terminated with a dollar ($) sign. All variables are integers by default.', 'f': 'V'}
let s:db['DEF'] = {'g': 'Variables & types', 's': 'DEF type var[, var, var, ...]', 'd': 'Defines variable types in a structured fashion.', 'e': 'DEF DECIMAL X, Y', 'p': [['type', 'TAG | LABEL | INT | INTEGER | DECIMAL', 'The type to give the listed variables', 0], ['var', 'name', 'One or more variable names', 0]], 'f': 'V'}
let s:db['DELETE'] = {'g': 'Editor & compiler', 's': 'DELETE [start-end]', 'd': 'Deletes the range of lines from start to end. With no parameters, acts like NEW.', 'e': 'DELETE 100-200'}
let s:db['DESC'] = {'g': 'Editor & compiler', 's': 'DESC line#, label', 'd': 'Creates a subroutine label and starts its code at line#.', 'e': 'DESC 1000, DRAWSCREEN'}
let s:db['DETECT'] = {'g': 'Bitmap & sprites', 's': 'DETECT mob#[, mob#[, mob#[, ...]]]', 'd': 'Used after the COLLISION command. Checks whether the specified sprites were involved in a collision.', 'e': 'COLLISION 0 : DETECT 0,1', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.'}
let s:db['DETEXT'] = {'g': 'Memory & expansion RAM', 's': 'DETEXT(type)', 'd': 'Returns how much extended memory of type is attached to the system.', 'e': 'A = DETEXT(0)'}
let s:db['DEVICE'] = {'g': 'Disk, files & input', 's': 'DEVICE devnum', 'd': 'Sets the device number for the default device.', 'e': 'DEVICE 9'}
let s:db['DIM'] = {'g': 'Variables & types', 's': 'DIM [DECIMAL] variable(value)', 'd': 'Creates array variable of value size. DECIMAL makes it an array of decimals rather than integers.', 'e': 'DIM SCORES(20)', 'f': 'V'}
let s:db['DIR'] = {'g': 'Disk, files & input', 's': 'DIR [num]', 'd': 'Lists the current device''s directory. If num is supplied, the listing is sent to a printer.', 'e': 'DIR'}
let s:db['DISK'] = {'g': 'Disk, files & input', 's': 'DISK ["command"[, devnum]]', 'd': 'Equivalent to OPEN 15,devnum,15,"command":CLOSE 15. Uses the default device if not specified, and initializes the device if command is not specified.', 'e': 'DISK "S0:OLDFILE"'}
let s:db['DO'] = {'g': 'Loops', 's': 'DO line#, times', 'd': 'Runs line line# times times.', 'e': 'DO 1000, 10', 'n': 'DO loops only work on integer variables.'}
let s:db['DOUBLE'] = {'g': 'Math', 's': 'DOUBLE vop', 'd': 'Multiplies vop by 2.', 'e': 'DOUBLE A', 'n': 'Works with non-arrayed integer variables, tags and pointers, and also with non-arrayed decimal variables.', 'f': 'mM'}
let s:db['DUBL'] = {'g': 'Variables & types', 's': 'DUBL', 'd': 'Double-precision variable type, used with DEF.', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.', 'f': 'V'}
let s:db['DUP$'] = {'g': 'Strings', 's': 'DUP$(string, count)', 'd': 'Duplicates string string count times.', 'e': 'A$ = DUP$("-", 40)'}
let s:db['ELSE'] = {'g': 'Conditionals', 's': 'ELSE statement', 'd': 'If the prior IF expression evaluated to FALSE, statement will be executed.', 'e': 'IF A = 1 THEN PRINT "ONE" : ELSE PRINT "OTHER"', 'f': 'M'}
let s:db['END'] = {'g': 'Program flow', 's': 'END', 'd': 'Ends the execution of the program and returns the screen to normal.'}
let s:db['EOR'] = {'g': 'Word operators', 's': 'vov EOR vov', 'd': 'Performs a logical (bitwise) Exclusive OR.', 'e': 'A = B EOR 255'}
let s:db['ERROR'] = {'g': 'Editor & compiler', 's': 'ERROR', 'd': 'Displays the errors.'}
let s:db['EXEC'] = {'g': 'Editor & compiler', 's': 'EXEC command block', 'd': 'Runs a single line in immediate mode. Shorthand: >', 'e': '> PRINT "HELLO"', 'n': 'The > character is an accepted shorthand for EXEC.'}
let s:db['EXP'] = {'g': 'Math', 's': 'EXP(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['EXTENDED'] = {'g': 'Text screen', 's': 'EXTENDED on[, color1, color2, color3]', 'd': 'Turns extended color mode on or off. If colors are supplied, sets the 3 background colors.', 'e': 'EXTENDED 1,0,1,2'}
let s:db['FAST'] = {'g': 'System & interrupts', 's': 'FAST', 'd': 'Enables speed up of some commands.'}
let s:db['FETCH'] = {'g': 'Memory & expansion RAM', 's': 'FETCH count, destination, reu[, bank]', 'd': 'Copies count bytes from an attached REU at address reu and bank bank to C64 address destination.', 'e': 'FETCH 4096, 49152, 0, 0'}
let s:db['FILE'] = {'g': 'Disk, files & input', 's': 'FILE', 'd': 'Undocumented.', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.'}
let s:db['FILL'] = {'g': 'Memory & expansion RAM', 's': 'FILL start, end[, byte[, step]]', 'd': 'Fills the memory from address start to address end with value byte, incrementing the address by step.', 'e': 'FILL 1024,2023,32', 'p': [['start', 'integer', 'First address to fill', 0], ['end', 'integer', 'Last address to fill', 0], ['byte', '0-255', 'Value to write; 0 if not specified', 1], ['step', 'integer', 'Address increment; 1 if not specified', 1]]}
let s:db['FILTER'] = {'g': 'SID sound', 's': 'FILTER voice1, voice2, voice3, ext, resonance', 'd': 'Enables or disables the filters of voice1, voice2 and voice3, the output of the external input, and sets the resonance value.', 'e': 'FILTER 1,0,0,0,8', 'n': 'All parameters can be values or variables; a parameter left off reuses the previous value, or 0 if none was set. 0 disables, 1 enables.'}
let s:db['FIND'] = {'g': 'Editor & compiler', 's': 'FIND text', 'd': 'Searches the program in the current bank for lines containing text.', 'e': 'FIND [LDA', 'n': 'Do not use quotes when searching for keywords. When searching for assembly, put a left bracket in front of the instruction.'}
let s:db['FN'] = {'g': 'Math', 's': 'FN name(vov)', 'd': 'User-defined function reference, as in BASIC V2.', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.'}
let s:db['FOR'] = {'g': 'Loops', 's': 'FOR var = start TO end [STEP val]', 'd': 'Defines a FOR loop that iterates variable var from start to end, incrementing by 1, or by val if STEP is given.', 'e': 'FOR I = 1 TO 10 : PRINT I : NEXT I', 'n': 'FOR-TO-STEP-NEXT loops only work on integer variables.'}
let s:db['FRAC'] = {'g': 'Math', 's': 'FRAC(vov)', 'd': 'Returns the fractional value of vov, stripped of the sign.', 'e': 'A = FRAC(B)', 'f': 'M'}
let s:db['FRE'] = {'g': 'Math', 's': 'FRE(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['FREQ'] = {'g': 'SID sound', 's': 'FREQ freq', 'd': 'Specifies that the current voice will play frequency freq.', 'e': 'FREQ 4291', 'n': 'Requires a current VOICE to be selected before calling. All parameters can be values or variables; a parameter left off reuses the previous value, or 0 if none was set. 0 disables, 1 enables.'}
let s:db['GET'] = {'g': 'Disk, files & input', 's': 'GET variable', 'd': 'Reads a character and puts it in variable.', 'e': 'GET A$'}
let s:db['GET#'] = {'g': 'Disk, files & input', 's': 'GET# file#, variable', 'd': 'Reads a character from file# and puts it in variable.', 'e': 'GET# 2, A$'}
let s:db['GLOBAL'] = {'g': 'Variables & types', 's': 'GLOBAL', 'd': 'Restores the global variable scope.', 'f': 'm'}
let s:db['GOSUB'] = {'g': 'Program flow', 's': 'GOSUB line#[, line#[, ...]]', 'd': 'Runs a subroutine at line#. If more than one line# is specified, runs each one in the order specified.', 'e': 'GOSUB 1000, 2000', 'f': 'm'}
let s:db['GOTO'] = {'g': 'Program flow', 's': 'GOTO tag | line number', 'd': 'Jumps to the line number or tag in the program.', 'e': 'GOTO 1000', 'f': 'm'}
let s:db['GSAVE'] = {'g': 'Disk, files & input', 's': 'GSAVE on', 'd': 'Saves a copy of the C64 RAM to GeoRAM expanded memory. If on is 1, enables the back-up feature.', 'e': 'GSAVE 1'}
let s:db['HALF'] = {'g': 'Math', 's': 'HALF vop', 'd': 'Divides vop by 2.', 'e': 'HALF A', 'n': 'Works with non-arrayed integer variables, tags and pointers, and also with non-arrayed decimal variables.', 'f': 'mM'}
let s:db['HALT'] = {'g': 'Editor & compiler', 's': 'HALT', 'd': 'Stops compilation at this point. All previous code will be compiled.', 'f': 'm'}
let s:db['HALTINT'] = {'g': 'System & interrupts', 's': 'HALTINT', 'd': 'Stops the interrupt totally, returning interrupts to normal.', 'n': 'It is critical to halt your interrupts before exiting your program.', 'w': 'Critical: always HALTINT before your program exits, or the machine is left running your raster interrupt.'}
let s:db['HLINE'] = {'g': 'Bitmap & sprites', 's': 'HLINE x, y, len, color', 'd': 'Draws a straight horizontal line starting at (x, y) and continuing to the right for len pixels in color.', 'e': 'HLINE 0,100,320,1', 'n': 'All parameters can be values or variables. If a parameter is left off, a default or previous value is used.'}
let s:db['IF'] = {'g': 'Conditionals', 's': 'IF expression [AND | OR | EOR expression]', 'd': 'Evaluates the expression and sets a flag that will be acted upon when the program reaches a THEN statement.', 'e': 'IF A = 1 THEN PRINT "ONE"', 'f': 'M'}
let s:db['INC'] = {'g': 'Math', 's': 'INC vop', 'd': 'Increments vop by 1.', 'e': 'INC A', 'n': 'Works with non-arrayed integer variables, tags and pointers, and also with non-arrayed decimal variables.', 'f': 'M'}
let s:db['INPUT'] = {'g': 'Disk, files & input', 's': 'INPUT var, var, ...', 'd': 'Reads lines and puts the values in var.', 'e': 'INPUT A$, B'}
let s:db['INPUT#'] = {'g': 'Disk, files & input', 's': 'INPUT# file#, var[, var[, ...]]', 'd': 'Reads lines from file file# and stores them in var.', 'e': 'INPUT# 2, A$'}
let s:db['INT'] = {'g': 'Math', 's': 'INT(vov)', 'd': 'Returns the integer value of vov, rounded down.', 'e': 'A = INT(B)', 'f': 'M'}
let s:db['INTEGER'] = {'g': 'Variables & types', 's': 'INTEGER', 'd': 'Integer variable type, used with DEF.', 'e': 'DEF INTEGER X, Y', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.', 'f': 'V'}
let s:db['INTEND'] = {'g': 'System & interrupts', 's': 'INTEND flag', 'd': 'Should be the last statement in your interrupt routine.', 'e': 'INTEND 1', 'n': 'It is critical to halt your interrupts before exiting your program.', 'p': [['flag', '0-1', '0 JMPs to BASIC''s hardware timer routine, 1 will RTI', 0]]}
let s:db['INTERRUPT'] = {'g': 'System & interrupts', 's': 'INTERRUPT raster, line#', 'd': 'Creates a new raster interrupt at raster line raster which calls the code at line#.', 'e': 'INTERRUPT 100, 5000', 'n': 'It is critical to halt your interrupts before exiting your program.', 'w': 'Critical: always HALTINT before your program exits, or the machine is left running your raster interrupt.', 'p': [['raster', '50-249', 'Raster line to interrupt on', 0], ['line#', 'integer', 'Line number of the interrupt routine', 0]]}
let s:db['JOIN'] = {'g': 'Math', 's': 'JOIN vop = low, high', 'd': 'Joins a low and a high byte into a single variable. The opposite of SPLIT.', 'e': 'JOIN A = LO, HI'}
let s:db['JOY'] = {'g': 'Disk, files & input', 's': 'JOY(joynum)', 'd': 'Returns the value of the joystick port joynum, typically 1 or 2.', 'e': 'A = JOY(2)'}
let s:db['KEYPRESS'] = {'g': 'Disk, files & input', 's': 'KEYPRESS [vov[, vov]]', 'd': 'If vov is not specified, waits for any keypress; otherwise waits for vov to be pressed. If a second vov is specified, acts like an IF block and is FALSE for the first character, TRUE for the second.', 'e': 'KEYPRESS 89, 78'}
let s:db['LABEL'] = {'g': 'Assembler mode', 's': 'LABEL label [= vov]', 'd': 'Identical to TAG. Creates a label that can be used in place of a value or address.', 'e': 'LABEL SCREEN = 1024', 'n': 'Tags and variables can be used in place of values and addresses in ML mode. Commands that are ML-safe: START, GOTO, GOSUB, RETURN, REM, TAG, PROC, MODULE, LOCAL, GLOBAL, ADD, SUBTRACT, COMPARE, HALF, DOUBLE, VARIABLES, HALT, RESUME, VERSION, DEBUG, STARTINT, RASTER, BYTES and STRINGS.', 'f': 'V'}
let s:db['LEFT$'] = {'g': 'Strings', 's': 'LEFT$(string, count)', 'd': 'Returns count characters from the left of string.', 'e': 'A$ = LEFT$(B$, 5)'}
let s:db['LEN'] = {'g': 'Strings', 's': 'LEN(string)', 'd': 'Returns the length of string.', 'e': 'A = LEN(B$)'}
let s:db['LET'] = {'g': 'Variables & types', 's': 'LET variable = value', 'd': 'Assigns a simple value to a simple variable. Useful for speed.', 'e': 'LET A = 5', 'f': 'M'}
let s:db['LIMITS'] = {'g': 'Bitmap & sprites', 's': 'LIMITS width, height, x-pos, y-pos, colorplot', 'd': 'Limits the area on the bitmap that the drawing commands will affect.', 'e': 'LIMITS 160,100,80,50,1', 'n': 'All parameters can be values or variables. If a parameter is left off, a default or previous value is used.'}
let s:db['LINE'] = {'g': 'Bitmap & sprites', 's': 'LINE x1, y1[, x2, y2[, color]]', 'd': 'Draws a line on the bitmap from (x1, y1) to (x2, y2) in color. If x2 and y2 are not specified, draws from (x1, y1) to the current coordinate.', 'e': 'LINE 0,0,319,199,1', 'n': 'All parameters can be values or variables. If a parameter is left off, a default or previous value is used.'}
let s:db['LIST'] = {'g': 'Editor & compiler', 's': 'LIST [line#[-line#]]', 'd': 'Displays the program in memory. Can optionally display only the lines between the given parameters.', 'e': 'LIST 100-200'}
let s:db['LISTER'] = {'g': 'Editor & compiler', 's': 'LISTER [line#]', 'd': 'A scrollable LIST. If line# is specified, starts at that line.', 'e': 'LISTER 500'}
let s:db['LITE'] = {'g': 'Editor & compiler', 's': 'LITE [0/1]', 'd': 'With no parameter or a 1, enables LITE mode. 0 disables it.', 'e': 'LITE 1'}
let s:db['LLIST'] = {'g': 'Editor & compiler', 's': 'LLIST [line#[-line#[, printer?]]]', 'd': 'Displays extended details about the program in memory.', 'e': 'LLIST 100-200,1', 'p': [['line#', 'integer', 'First line, and optionally last line, to describe', 1], ['printer?', '0-1', '1 sends the output to a printer', 1]]}
let s:db['LOAD'] = {'g': 'Disk, files & input', 's': 'LOAD "filename"[, devnum]', 'd': 'Loads a file from the default device. If filename is not specified, the last specified filename is used.', 'e': 'LOAD "MYPROG",8'}
let s:db['LOC'] = {'g': 'Text screen', 's': 'LOC(x, y)', 'd': 'Moves the cursor to location x, y on the current text screen.', 'e': 'LOC(10,5) : PRINT "HELLO"'}
let s:db['LOCAL'] = {'g': 'Variables & types', 's': 'LOCAL', 'd': 'Starts a local scope for variables.', 'f': 'm'}
let s:db['LOG'] = {'g': 'Math', 's': 'LOG(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['LONGPEEK'] = {'g': 'Memory & expansion RAM', 's': 'LONGPEEK(address)', 'd': 'Returns a single value from address on a SuperCPU.', 'e': 'A = LONGPEEK(16777216)'}
let s:db['LONGPOKE'] = {'g': 'Memory & expansion RAM', 's': 'LONGPOKE address, val, val, val, ...', 'd': 'Pokes into the extended memory of a SuperCPU.', 'e': 'LONGPOKE 16777216, 1, 2, 3'}
let s:db['LOWERCASE'] = {'g': 'Text screen', 's': 'LOWERCASE [disable]', 'd': 'Changes the character set to lowercase. If disable is 1, disables keyboard toggling between upper and lower case.', 'e': 'LOWERCASE 1'}
let s:db['MID$'] = {'g': 'Strings', 's': 'MID$(string, position, count)', 'd': 'Returns count characters, starting at index position, from string.', 'e': 'A$ = MID$(B$, 3, 5)'}
let s:db['MOB'] = {'g': 'Bitmap & sprites', 's': 'MOB number, on, multicolor, priority, x, y, x-add, y-add', 'd': 'Chooses which sprite to make current and initializes it.', 'e': 'MOB 0,1,0,0,160,100,0,0', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.', 'p': [['number', '0-7', 'Which sprite becomes the current sprite', 0], ['on', '0-1', 'Turns the sprite on or off', 0], ['multicolor', '0-1', 'Enables or disables multicolor mode', 0], ['priority', '0-1', 'Enables or disables background priority', 0], ['x', 'integer', 'Initial X coordinate', 0], ['y', 'integer', 'Initial Y coordinate', 0], ['x-add', 'integer', 'X offset', 0], ['y-add', 'integer', 'Y offset', 0]]}
let s:db['MOBCLR'] = {'g': 'Bitmap & sprites', 's': 'MOBCLR', 'd': 'Clears all of the sprite registers. Recommended at the beginning of a program that uses sprites, and when you want to clear the screen of sprites.', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.'}
let s:db['MOBCOL'] = {'g': 'Bitmap & sprites', 's': 'MOBCOL color, shared1, shared2', 'd': 'Sets the sprite colors.', 'e': 'MOBCOL 1,2,3', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.', 'p': [['color', '0-15', 'Color of the current sprite', 0], ['shared1', '0-15', 'First color shared by all multicolor sprites', 0], ['shared2', '0-15', 'Second color shared by all multicolor sprites', 0]]}
let s:db['MOBEXP'] = {'g': 'Bitmap & sprites', 's': 'MOBEXP x-expan, y-expan', 'd': 'Enables and disables the X expansion and Y expansion of the current sprite.', 'e': 'MOBEXP 1,1', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.'}
let s:db['MOBPAT'] = {'g': 'Bitmap & sprites', 's': 'MOBPAT shape#, bank', 'd': 'Moves the CODE pointer to point at the specified sprite shape''s data. shape# selects the shape, bank specifies the bank where the coded data will be sent.', 'e': 'MOBPAT 0,1', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.'}
let s:db['MOBSET'] = {'g': 'Bitmap & sprites', 's': 'MOBSET shape#, number, number, number, ...', 'd': 'Initializes a sprite from The Spreditor.', 'e': 'MOBSET 0,1,2,3', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.'}
let s:db['MOBXY'] = {'g': 'Bitmap & sprites', 's': 'MOBXY x, y, x-add, y-add', 'd': 'Moves the current sprite to the coordinates (x, y). x-add and y-add set the offsets.', 'e': 'MOBXY 160,100,0,0', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.'}
let s:db['MODULE'] = {'g': 'Editor & compiler', 's': 'MODULE filename[, devnum[, address]]  ...  MODULE END', 'd': 'When compiling, writes this section to a separate module file filename for reusability. MODULE END marks the end of the module.', 'e': 'MODULE "SPRITELIB",8,49152', 'p': [['filename', 'string', 'Module file to write', 0], ['devnum', 'integer', 'Device to write to; the default device if omitted', 1], ['address', 'integer', 'Load address; 49152 if not specified', 1]], 'f': 'm'}
let s:db['MODULE END'] = {'g': 'Editor & compiler', 's': 'MODULE END', 'd': 'End of a module section.'}
let s:db['MULTI'] = {'g': 'Text screen', 's': 'MULTI on[, color1, color2]', 'd': 'Turns multicolor mode on or off. If colors are specified, sets the background colors.', 'e': 'MULTI 1,1,2'}
let s:db['NEW'] = {'g': 'Editor & compiler', 's': 'NEW [bank[-bank]]', 'd': 'Clears the current program bank, or the banks specified.', 'e': 'NEW 1-3'}
let s:db['NEXT'] = {'g': 'Loops', 's': 'NEXT var[, var[, ...]]', 'd': 'The end of the FOR loop. var must match the FOR loop you are continuing.', 'e': 'NEXT I'}
let s:db['NORMAL'] = {'g': 'Text screen', 's': 'NORMAL clear', 'd': 'Resets the screen to normal text mode.', 'e': 'NORMAL 1', 'p': [['clear', '0-1', '1 clears the line link table, 0 does not', 0]]}
let s:db['NOT'] = {'g': 'Word operators', 's': 'NOT vov', 'd': 'Logical NOT.', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.'}
let s:db['OLD'] = {'g': 'Editor & compiler', 's': 'OLD [bank[-bank]]', 'd': 'Attempts to restore the program in the current bank, or the banks specified.', 'e': 'OLD'}
let s:db['ON'] = {'g': 'Program flow', 's': 'ON var GOSUB | GOTO line#, line#, ...', 'd': 'Jumps to the line# that matches the value of var.', 'e': 'ON A GOTO 1000, 2000, 3000'}
let s:db['OPEN'] = {'g': 'Disk, files & input', 's': 'OPEN file#, dev#, secondary, string', 'd': 'Opens a connection to device dev#, assigning it to file file# with a secondary address of secondary, and sends string through the open file.', 'e': 'OPEN 2,8,2,"DATA,S,R"'}
let s:db['OR'] = {'g': 'Word operators', 's': 'vov OR vov', 'd': 'Performs a logical (bitwise) OR.', 'e': 'A = B OR 128'}
let s:db['PADBUT'] = {'g': 'Disk, files & input', 's': 'PADBUT joynum', 'd': 'Returns 1 if the paddle button is pressed, 0 if not.', 'e': 'IF PADBUT 1 THEN GOSUB 1000'}
let s:db['PADDLE'] = {'g': 'Disk, files & input', 's': 'PADDLE joynum', 'd': 'Returns the value of the paddle, 0-255. Paddles 1-2 are in joynum 1, paddles 3-4 are in 2.', 'e': 'A = PADDLE 1', 'n': 'Returned values are bit-reversed. POKE 2383,0 to disable the PADDLE bit-reversing.'}
let s:db['PANX'] = {'g': 'Text screen', 's': 'PANX panvalue, columns', 'd': 'Pans the screen horizontally.', 'e': 'PANX 0,1', 'n': 'POKE 2384,0 to disable the bit-reversing of PANX and PANY.', 'p': [['panvalue', '0-7', 'Pan amount, bit-reversed; 0 is none', 0], ['columns', '0-1', '0 sets a 38 column screen, 1 sets 40 columns', 0]]}
let s:db['PANY'] = {'g': 'Text screen', 's': 'PANY panvalue, rows', 'd': 'Pans the screen vertically.', 'e': 'PANY 3,1', 'n': 'POKE 2384,0 to disable the bit-reversing of PANX and PANY.', 'p': [['panvalue', '0-7', 'Pan amount, bit-reversed; 3 is none', 0], ['rows', '0-1', '0 sets a 24 row screen, 1 sets 25 rows', 0]]}
let s:db['PASS'] = {'g': 'Program flow', 's': 'PASS vop[, vop[, vop[, ...]]]', 'd': 'Defines parameters vop for a subroutine. Must be the first command after PROC if you are passing parameters.', 'e': 'PASS X, Y', 'n': 'Call a subroutine like tag.vop,vop,vop. Strings and string variables cannot be returned from subroutines.'}
let s:db['PAUSE'] = {'g': 'System & interrupts', 's': 'PAUSE seconds[, jiffies]', 'd': 'Pauses execution for seconds seconds. If jiffies is specified, pauses for an additional (jiffies/60) seconds.', 'e': 'PAUSE 1, 30'}
let s:db['PEEK'] = {'g': 'Memory & expansion RAM', 's': 'PEEK(vov[, index])', 'd': 'Returns the memory at address vov, optionally offset by index.', 'e': 'A = PEEK(53280)'}
let s:db['PLIST'] = {'g': 'Editor & compiler', 's': 'PLIST [line#[-line#]]', 'd': 'Sends the program LIST to a printer.', 'e': 'PLIST 100-200'}
let s:db['PLOT'] = {'g': 'Bitmap & sprites', 's': 'PLOT x, y, color', 'd': 'Draws a pixel on the bitmap at coordinates (x, y) in color.', 'e': 'PLOT 160,100,1', 'n': 'All parameters can be values or variables. If a parameter is left off, a default or previous value is used.', 'p': [['x', '0-319', '', 0], ['y', '0-199', '', 0], ['color', '0-15', '', 0]]}
let s:db['POINT'] = {'g': 'Program flow', 's': 'POINT vop = line#   |   POINT TAG tag = line#', 'd': 'Sets vop to the address of the compiled code for line line#. The POINT TAG form creates a tag and points it at that address instead.', 'e': 'POINT TAG ROUTINE = 1000', 'n': 'Call a subroutine like tag.vop,vop,vop. Strings and string variables cannot be returned from subroutines.'}
let s:db['POINT TAG'] = {'g': 'System & interrupts', 's': 'POINT TAG', 'd': 'Point a tag at the compiled address of a line.'}
let s:db['POKE'] = {'g': 'Memory & expansion RAM', 's': 'POKE address, vov, vov, vov, ...', 'd': 'Puts values vov in consecutive memory starting at address. Can also be used with strings.', 'e': 'POKE 53280,0,0'}
let s:db['POLL'] = {'g': 'Disk, files & input', 's': 'POLL port#', 'd': 'Tells the C64 which set of paddles you are polling, allowing substitution of the required delay.', 'e': 'POLL 1', 'p': [['port#', '1-2', '1 for joystick port 1, 2 for joystick port 2', 0]]}
let s:db['POS'] = {'g': 'Math', 's': 'POS(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['PREV'] = {'g': 'Editor & compiler', 's': 'PREV', 'd': 'Undocumented.', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.'}
let s:db['PRINT'] = {'g': 'Text screen', 's': 'PRINT expression', 'd': 'Prints expression to the current text screen.', 'e': 'PRINT "HELLO"'}
let s:db['PRINT#'] = {'g': 'Disk, files & input', 's': 'PRINT# file#, expression', 'd': 'Prints expression to file file#.', 'e': 'PRINT# 2, "HELLO"'}
let s:db['PROC'] = {'g': 'Program flow', 's': 'PROC tag[, vop[, vop[, ...]]]', 'd': 'Defines the start of a subroutine named tag with parameters vop.', 'e': 'PROC DRAWBOX, X, Y', 'n': 'Call a subroutine like tag.vop,vop,vop. Strings and string variables cannot be returned from subroutines.', 'w': 'Strings and string variables cannot be returned from subroutines. Call a named subroutine as `TAG.arg,arg`.', 'f': 'm'}
let s:db['PULSE'] = {'g': 'SID sound', 's': 'PULSE width', 'd': 'Specifies the pulse waveform width for the current voice.', 'e': 'PULSE 2048', 'n': 'Requires a current VOICE to be selected before calling. All parameters can be values or variables; a parameter left off reuses the previous value, or 0 if none was set. 0 disables, 1 enables.'}
let s:db['QUIT'] = {'g': 'Editor & compiler', 's': 'QUIT', 'd': 'Quits Vision BASIC.'}
let s:db['RANDOM'] = {'g': 'Math', 's': 'RANDOM [seed]', 'd': 'Initializes the random number table. With no parameter, uses SID voice 3; otherwise seeds the table with seed.', 'e': 'RANDOM', 'f': 'M'}
let s:db['RASTER'] = {'g': 'System & interrupts', 's': 'RASTER raster', 'd': 'Selects the next raster line to interrupt.', 'e': 'RASTER 150', 'n': 'It is critical to halt your interrupts before exiting your program.', 'f': 'm'}
let s:db['READ'] = {'g': 'System & interrupts', 's': 'READ vop, vop, ...', 'd': 'Reads values from a DATA statement.', 'e': 'READ A, B, C'}
let s:db['REM'] = {'g': 'System & interrupts', 's': 'REM', 'd': 'Turns the rest of the line into a comment.', 'e': 'REM THIS IS A COMMENT', 'f': 'm'}
let s:db['RENUM'] = {'g': 'Editor & compiler', 's': 'RENUM start-end, new[, step]', 'd': 'Renumbers the lines from start to end so that they begin at new.', 'e': 'RENUM 100-500, 1000, 10', 'p': [['start-end', 'integer', 'Range of existing lines to renumber', 0], ['new', 'integer', 'New first line number', 0], ['step', 'integer', 'Line number increment; 10 if not specified', 1]]}
let s:db['RESTORE'] = {'g': 'System & interrupts', 's': 'RESTORE [line#]', 'd': 'Resets the pointer to the start of all DATA statements, or to the DATA statement on line line#.', 'e': 'RESTORE 1000'}
let s:db['RESUME'] = {'g': 'Editor & compiler', 's': 'RESUME', 'd': 'Resumes compilation after a HALT.', 'n': 'Must be at the beginning of a line, or it will be ignored.', 'f': 'm'}
let s:db['RETURN'] = {'g': 'Program flow', 's': 'RETURN', 'd': 'Ends a subroutine and sends program flow back to the GOSUB statement, or to the caller of a PROC.', 'n': 'Call a subroutine like tag.vop,vop,vop. Strings and string variables cannot be returned from subroutines.', 'f': 'm'}
let s:db['REUPEEK'] = {'g': 'Memory & expansion RAM', 's': 'REUPEEK(address, bank)', 'd': 'Returns the value from an attached REU at address in bank bank.', 'e': 'A = REUPEEK(0, 0)'}
let s:db['REUPOKE'] = {'g': 'Memory & expansion RAM', 's': 'REUPOKE address, bank, val, val, ...', 'd': 'Writes the values to an attached REU starting at address in bank bank.', 'e': 'REUPOKE 0, 0, 1, 2, 3'}
let s:db['RIGHT$'] = {'g': 'Strings', 's': 'RIGHT$(string, count)', 'd': 'Returns count characters from the right of string.', 'e': 'A$ = RIGHT$(B$, 5)'}
let s:db['RND'] = {'g': 'Math', 's': 'RND [0]', 'd': 'Generates a random number. If 0 is supplied, limits the result to 0-255, otherwise 0-65535.', 'e': 'A = RND 0', 'f': 'M'}
let s:db['RUN'] = {'g': 'Editor & compiler', 's': 'RUN [line#]', 'd': 'Runs the compiled, in-memory program. If the program is not compiled or has been altered, compiles it first. If line# is specified, starts there, otherwise from the first line.', 'e': 'RUN'}
let s:db['SAVE'] = {'g': 'Disk, files & input', 's': 'SAVE "filename"[, devnum]', 'd': 'Saves a file to the default device. Filename must be 12 characters or less. If filename is not specified, the last specified filename is used.', 'e': 'SAVE "MYPROG",8'}
let s:db['SEND'] = {'g': 'Program flow', 's': 'SEND vov', 'd': 'Makes the subroutine return the value vov. Must be the final command before RETURN if used.', 'e': 'SEND RESULT', 'n': 'Call a subroutine like tag.vop,vop,vop. Strings and string variables cannot be returned from subroutines.', 'w': 'Strings and string variables cannot be returned from subroutines.'}
let s:db['SGN'] = {'g': 'Math', 's': 'SGN(vov)', 'd': 'Returns the sign of vov.', 'e': 'A = SGN(B)', 'f': 'M'}
let s:db['SHAPE'] = {'g': 'Bitmap & sprites', 's': 'SHAPE byte[, byte[, byte[, ...]]]', 'd': 'Changes the current sprite''s shape. If more than one shape is specified, sets the shape for the following sprites.', 'e': 'SHAPE 255,255,255', 'n': 'Commands begin with MOB as a carryover from Simon''s BASIC.'}
let s:db['SIDCLR'] = {'g': 'SID sound', 's': 'SIDCLR', 'd': 'Clears the sound registers.', 'n': 'All parameters can be values or variables; a parameter left off reuses the previous value, or 0 if none was set. 0 disables, 1 enables.'}
let s:db['SIN'] = {'g': 'Math', 's': 'SIN(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['SLOW'] = {'g': 'System & interrupts', 's': 'SLOW', 'd': 'Runs at normal C64 speeds.'}
let s:db['SPC'] = {'g': 'Text screen', 's': 'SPC(vov)', 'd': 'Prints vov spaces.', 'e': 'PRINT SPC(10);"HELLO"'}
let s:db['SPLIT'] = {'g': 'Math', 's': 'SPLIT low, high[, high2] = vov', 'd': 'Splits a variable into low and high bytes.', 'e': 'SPLIT LO, HI = A'}
let s:db['SQR'] = {'g': 'Math', 's': 'SQR(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['START'] = {'g': 'Assembler mode', 's': 'START [*=] address', 'd': 'Specifies the starting location for an ML program.', 'e': 'START *= 49152', 'n': 'Must be placed at the very beginning of your ML program, and only used once.', 'f': 'm'}
let s:db['STARTINT'] = {'g': 'System & interrupts', 's': 'STARTINT', 'd': 'Lets you program raster interrupts. Should be the first command in your interrupt routine.', 'n': 'It is critical to halt your interrupts before exiting your program.', 'w': 'Critical: always HALTINT before your program exits, or the machine is left running your raster interrupt.', 'f': 'm'}
let s:db['STASH'] = {'g': 'Memory & expansion RAM', 's': 'STASH address, count, reu[, bank]', 'd': 'Copies count C64 memory bytes at address address to the attached REU address reu in bank bank.', 'e': 'STASH 49152, 4096, 0, 0'}
let s:db['STATUS'] = {'g': 'Disk, files & input', 's': 'STATUS', 'd': 'Reads and clears the STatus of the last I/O operation.', 'e': 'IF STATUS THEN PRINT "ERROR"'}
let s:db['STEP'] = {'g': 'Loops', 's': 'FOR var = start TO end STEP val', 'd': 'Sets the increment of a FOR loop.'}
let s:db['STOP'] = {'g': 'Program flow', 's': 'STOP', 'd': 'Stops the program execution but does not reset the screen.'}
let s:db['STR$'] = {'g': 'Strings', 's': 'STR$(vov)', 'd': 'Converts number vov into a string.', 'e': 'A$ = STR$(N)'}
let s:db['STRINGS'] = {'g': 'Memory & expansion RAM', 's': 'STRINGS [size]', 'd': 'With no parameter, stretches the string field to 53247, otherwise to size.', 'e': 'STRINGS 49152', 'f': 'm'}
let s:db['SUB'] = {'g': 'Variables & types', 's': 'SUB', 'd': 'Undocumented. Sits beside DUBL, LABEL and INTEGER in the DEF type group.', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.', 'f': 'V'}
let s:db['SUBTRACT'] = {'g': 'Math', 's': 'SUBTRACT vop = vov - vov', 'd': 'Fast subtraction of two values into an integer variable, tag or pointer.', 'e': 'SUBTRACT A = B - 1', 'n': 'Works only with non-arrayed integer variables, tags and pointers.', 'f': 'mM'}
let s:db['SWAP'] = {'g': 'Memory & expansion RAM', 's': 'SWAP count, reu[, c64, bank]', 'd': 'Swaps the main memory at address c64 with the memory on the attached REU at address reu in bank bank.', 'e': 'SWAP 4096, 0, 49152, 0'}
let s:db['SWITCH'] = {'g': 'Memory & expansion RAM', 's': 'SWITCH start, end, start2', 'd': 'Swaps the memory at addresses start-end with the memory starting at address start2.', 'e': 'SWITCH 4096,8191,49152'}
let s:db['SYS'] = {'g': 'Assembler mode', 's': 'SYS address[, A, X, Y, ST]', 'd': 'Starts execution of ML code at address. If the A, X, Y and ST values are specified, they are loaded into the registers before starting.', 'e': 'SYS 49152, 0, 1, 2'}
let s:db['TAB'] = {'g': 'Text screen', 's': 'TAB(vov)', 'd': 'Moves the cursor to vov on the current line.', 'e': 'PRINT TAB(20);"HELLO"'}
let s:db['TAG'] = {'g': 'Variables & types', 's': 'TAG tag [= vov]', 'd': 'Creates a TAG named tag with the value vov. If vov is not specified, the tag gets the current address in the program. Used like a label in assembler.', 'e': 'TAG SCREEN = 1024', 'n': 'Tags cannot be to the left of an equals sign in a math expression.', 'f': 'mV'}
let s:db['TAN'] = {'g': 'Math', 's': 'TAN(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['THEN'] = {'g': 'Conditionals', 's': 'THEN statement', 'd': 'If the prior IF expression evaluated to TRUE, statement will be executed.', 'e': 'IF A = 1 THEN PRINT "ONE"', 'f': 'M'}
let s:db['TO'] = {'g': 'Loops', 's': 'FOR var = start TO end', 'd': 'Separates the start and end values of a FOR loop.'}
let s:db['TRAP'] = {'g': 'Program flow', 's': 'TRAP line#[, vop]', 'd': 'Sends control of your program to line# on error.', 'e': 'TRAP 9000, ERRADDR', 'p': [['line#', 'integer', 'Line to jump to when an error occurs', 0], ['vop', 'variable', 'Non-arrayed int that will receive the address of the error', 1]]}
let s:db['TREND'] = {'g': 'Program flow', 's': 'TREND', 'd': 'Undocumented.', 'n': 'Present in the Vision BASIC token table but not documented in the cheat sheet.'}
let s:db['UPPERCASE'] = {'g': 'Text screen', 's': 'UPPERCASE [disable]', 'd': 'Changes the character set to uppercase. If disable is 1, disables keyboard toggling between upper and lower case.', 'e': 'UPPERCASE 1'}
let s:db['USR'] = {'g': 'Math', 's': 'USR(vov)', 'd': 'Not available in Vision BASIC.', 'n': 'The BASIC V2 functions USR, FRE, POS, SQR, LOG, EXP, COS, SIN, TAN and ATN are not implemented by Vision BASIC.', 'f': 'u'}
let s:db['VAL'] = {'g': 'Strings', 's': 'VAL(string)', 'd': 'Returns the mathematical value of string.', 'e': 'A = VAL(N$)'}
let s:db['VARIABLES'] = {'g': 'Variables & types', 's': 'VARIABLES [address]', 'd': 'Moves the program variable table to address, or to 32768 if not specified.', 'e': 'VARIABLES 40960', 'f': 'mV'}
let s:db['VERIFY'] = {'g': 'Disk, files & input', 's': 'VERIFY "filename"[, devnum]', 'd': 'Verifies the program in memory against a file on the default device. If filename is not specified, the last specified filename is used.', 'e': 'VERIFY "MYPROG",8'}
let s:db['VERSION'] = {'g': 'System & interrupts', 's': 'VERSION number', 'd': 'Specifies which version of Vision BASIC is needed to compile the block of code.', 'e': 'VERSION 1.1', 'f': 'm'}
let s:db['VIDLOC'] = {'g': 'Text screen', 's': 'VIDLOC screen, printto, charset, clear', 'd': 'Moves the text screen to any of the 64 1K screens available.', 'e': 'VIDLOC 1,1,2,1', 'p': [['screen', '0-63', 'Which 1K screen to display', 0], ['printto', '0-63', 'Which screen to print to; usually equal to screen', 0], ['charset', 'integer', 'Location of the character set', 0], ['clear', '0-1', '1 clears the line link table, 0 does not', 0]]}
let s:db['VLINE'] = {'g': 'Bitmap & sprites', 's': 'VLINE x, y, len, color', 'd': 'Draws a straight vertical line starting at (x, y) and going down for len pixels in color.', 'e': 'VLINE 160,0,200,1', 'n': 'All parameters can be values or variables. If a parameter is left off, a default or previous value is used.'}
let s:db['VLIST'] = {'g': 'Editor & compiler', 's': 'VLIST [num]', 'd': 'Displays all of the variables from the program in memory. If num is specified, sends the output to a printer.', 'e': 'VLIST'}
let s:db['VOICE'] = {'g': 'SID sound', 's': 'VOICE num', 'd': 'Chooses which voice will be used.', 'e': 'VOICE 1', 'n': 'All parameters can be values or variables; a parameter left off reuses the previous value, or 0 if none was set. 0 disables, 1 enables.', 'w': 'Must be called before FREQ, PULSE, ADSR and WAVE — they all act on the current voice.', 'p': [['num', '1-3', 'SID voice to make current', 0]]}
let s:db['VOL'] = {'g': 'SID sound', 's': 'VOL volume, low, band, high, disconnect', 'd': 'Controls the main volume and filter selection.', 'e': 'VOL 15,0,0,0,0', 'n': 'All parameters can be values or variables; a parameter left off reuses the previous value, or 0 if none was set. 0 disables, 1 enables.', 'p': [['volume', '0-15', 'Main SID volume', 0], ['low', '0-1', 'Low pass filter', 0], ['band', '0-1', 'Band pass filter', 0], ['high', '0-1', 'High pass filter', 0], ['disconnect', '0-1', 'Disconnects the output of voice 3', 0]]}
let s:db['WAIT'] = {'g': 'System & interrupts', 's': 'WAIT address, and, eor', 'd': 'Waits for a non-0 result from PEEKing address and filtering it with AND and and EOR eor.', 'e': 'WAIT 53265, 128, 0'}
let s:db['WAVE'] = {'g': 'SID sound', 's': 'WAVE gate, wave, ring, sync, test', 'd': 'Sets the waveform and gate for the current voice.', 'e': 'WAVE 1,4,0,0,0', 'n': 'Requires a current VOICE to be selected before calling. All parameters can be values or variables; a parameter left off reuses the previous value, or 0 if none was set. 0 disables, 1 enables.', 'p': [['gate', '0-1', 'Enables or disables the gate', 0], ['wave', '1 | 2 | 4 | 8', '1 triangle, 2 sawtooth, 4 pulse, 8 noise', 0], ['ring', '0-1', 'Ring modulate oscillators', 0], ['sync', '0-1', 'Sync modulate oscillators', 0], ['test', '0-1', 'Enables or disables the voice oscillator', 0]]}
let s:db['WHOLE'] = {'g': 'Math', 's': 'WHOLE(vov)', 'd': 'Returns the integer value of vov without rounding.', 'e': 'A = WHOLE(B)', 'f': 'M'}
let s:db['Π'] = {'g': 'Math', 's': 'π', 'd': 'The value of PI in decimal.', 'e': 'A = π'}

let s:mnemonics = ['ADC', 'AND', 'ASL', 'BCC', 'BCS', 'BEQ', 'BIT', 'BMI', 'BNE', 'BPL', 'BRK', 'BVC', 'BVS', 'CLC', 'CLD', 'CLI', 'CLV', 'CMP', 'CPX', 'CPY', 'DEC', 'DEX', 'DEY', 'EOR', 'INC', 'INX', 'INY', 'JMP', 'JSR', 'LDA', 'LDX', 'LDY', 'LSR', 'NOP', 'ORA', 'PHA', 'PHP', 'PLA', 'PLP', 'ROL', 'ROR', 'RTI', 'RTS', 'SBC', 'SEC', 'SED', 'SEI', 'STA', 'STX', 'STY', 'TAX', 'TAY', 'TSX', 'TXA', 'TXS', 'TYA']
let s:math_note = 'Parentheses are NOT allowed in math expressions and there is no operator precedence: expressions evaluate strictly left to right. `4+3*5-2*6` is `(((4+3)*5)-2)*6` = 198.'
let s:var_note = 'Variable names start with a letter, are significant to 8 characters, and may contain `!@#%&?` and digits. A name may contain a keyword but may not start with one. String variables end in `$`. Variables are integers unless declared `DECIMAL`.'

" ─── Public accessors ────────────────────────────────────────────────────────
function! visionbasic#keywords() abort
  return sort(keys(s:db))
endfunction

function! visionbasic#mnemonics() abort
  return copy(s:mnemonics)
endfunction

" For a statusline: %{visionbasic#mode()} -> "BASIC" or "ML".
function! visionbasic#mode() abort
  return get(b:, 'visionbasic_ml_mode', 0) ? 'ML' : 'BASIC'
endfunction

function! visionbasic#lookup(word) abort
  let l:key = toupper(a:word)
  return get(s:db, l:key, {})
endfunction

" True when the cursor column sits inside a [...] machine language block.
function! visionbasic#in_assembly(line, col) abort
  let l:before = strpart(a:line, 0, a:col)
  return strridx(l:before, '[') > strridx(l:before, ']')
endfunction

" ─── Documentation rendering ─────────────────────────────────────────────────
function! s:wrap(text, width, indent) abort
  let l:lines = []
  let l:cur = ''
  for l:word in split(a:text, ' ')
    if l:cur !=# '' && strlen(l:cur) + 1 + strlen(l:word) > a:width
      call add(l:lines, a:indent . l:cur)
      let l:cur = l:word
    else
      let l:cur = l:cur ==# '' ? l:word : l:cur . ' ' . l:word
    endif
  endfor
  if l:cur !=# ''
    call add(l:lines, a:indent . l:cur)
  endif
  return l:lines
endfunction

function! visionbasic#render(word) abort
  let l:key = toupper(a:word)
  let l:e = get(s:db, l:key, {})
  if empty(l:e)
    if index(s:mnemonics, l:key) >= 0
      return [l:key . '  (6502 mnemonic)', '',
        \ 'Machine language lives inside [] brackets, statements are separated',
        \ 'by ":", and ";" starts a comment. Branches and jumps may target a',
        \ 'BASIC line number directly, e.g. JMP1000.']
    endif
    return []
  endif
  let l:out = [l:e.s, repeat('-', strlen(l:e.s)), '']
  let l:out += s:wrap(l:e.d, 72, '')
  if has_key(l:e, 'p')
    call add(l:out, '')
    call add(l:out, 'Parameters:')
    for l:p in l:e.p
      let l:head = printf('  %-12s %s', l:p[0] . (l:p[3] ? ' (opt)' : ''), l:p[1])
      call add(l:out, l:head)
      let l:out += s:wrap(l:p[2], 56, '        ')
    endfor
  endif
  if has_key(l:e, 'e')
    call add(l:out, '')
    call add(l:out, 'Example:')
    call add(l:out, '  ' . l:e.e)
  endif
  if has_key(l:e, 'n')
    call add(l:out, '')
    let l:out += s:wrap(l:e.n, 72, '')
  endif
  if has_key(l:e, 'w')
    call add(l:out, '')
    let l:out += s:wrap('!! ' . l:e.w, 72, '')
  endif
  let l:f = get(l:e, 'f', '')
  if l:f =~# 'u'
    call add(l:out, '')
    let l:out += s:wrap('!! Not implemented by Vision BASIC.', 72, '')
  endif
  if l:f =~# 'M'
    call add(l:out, '')
    let l:out += s:wrap(s:math_note, 72, '')
  endif
  if l:f =~# 'V'
    call add(l:out, '')
    let l:out += s:wrap(s:var_note, 72, '')
  endif
  if l:f =~# 'm'
    call add(l:out, '')
    call add(l:out, 'ML-safe: usable inside an ASSEM block.')
  endif
  call add(l:out, '')
  call add(l:out, 'Category: ' . l:e.g)
  return l:out
endfunction

" Show the documentation for the word under the cursor in a preview window.
function! visionbasic#doc(...) abort
  let l:word = a:0 && a:1 !=# '' ? a:1 : expand('<cword>')
  " Pick up the trailing $ or # of CHR$, GET# and friends.
  let l:line = getline('.')
  let l:tail = matchstr(l:line, '\%' . col('.') . 'c\k*\zs[$#]')
  if l:tail !=# '' && has_key(s:db, toupper(l:word . l:tail))
    let l:word .= l:tail
  endif
  let l:text = visionbasic#render(l:word)
  if empty(l:text)
    echohl WarningMsg
    echomsg 'Vision BASIC: no entry for ' . l:word
    echohl None
    return
  endif
  silent! pclose
  execute 'silent! pedit! +setlocal\\ buftype=nofile\\ bufhidden=wipe\\ noswapfile\\ nobuflisted [Vision\\ BASIC]'
  let l:win = win_getid()
  noautocmd wincmd P
  setlocal modifiable
  silent %delete _
  call setline(1, l:text)
  setlocal nomodifiable nomodified filetype=help
  noautocmd call win_gotoid(l:win)
endfunction

" ─── Completion ──────────────────────────────────────────────────────────────
" 'omnifunc' — completes 6502 mnemonics inside [] and keywords everywhere else.
function! visionbasic#complete(findstart, base) abort
  if a:findstart
    let l:line = getline('.')
    let l:start = col('.') - 1
    while l:start > 0 && l:line[l:start - 1] =~# '\a'
      let l:start -= 1
    endwhile
    return l:start
  endif
  let l:asm = visionbasic#in_assembly(getline('.'), col('.') - 1)
  let l:pool = l:asm ? s:mnemonics : keys(s:db)
  let l:out = []
  for l:name in sort(copy(l:pool))
    if l:name !~? '^' . escape(a:base, '\.*$^~[]')
      continue
    endif
    if l:asm
      call add(l:out, {'word': l:name, 'kind': 'a', 'menu': '6502 mnemonic'})
    else
      let l:e = s:db[l:name]
      call add(l:out, {
        \ 'word': l:name,
        \ 'kind': get(l:e, 'f', '') =~# 'u' ? 'x' : 'k',
        \ 'menu': l:e.s,
        \ 'info': join(visionbasic#render(l:name), "\n"),
        \ })
    endif
  endfor
  return l:out
endfunction

" ─── Keyword case folding ────────────────────────────────────────────────────
" Uppercase Vision BASIC keywords on a line, leaving strings and comments be.
function! visionbasic#uppercase_line(lnum) abort
  let l:line = getline(a:lnum)
  if l:line ==# ''
    return
  endif
  let l:result = ''
  let l:i = 0
  let l:len = strlen(l:line)
  while l:i < l:len
    let l:ch = l:line[l:i]
    if l:ch ==# '"'
      " Copy the string literal verbatim.
      let l:end = stridx(l:line, '"', l:i + 1)
      let l:end = l:end < 0 ? l:len - 1 : l:end
      let l:result .= strpart(l:line, l:i, l:end - l:i + 1)
      let l:i = l:end + 1
    elseif l:ch ==# ';'
      let l:result .= strpart(l:line, l:i)
      break
    else
      let l:word = matchstr(l:line, '^\a[[:alnum:]!@#%&?]*[$#]\=', l:i)
      if l:word ==# ''
        let l:result .= l:ch
        let l:i += 1
      else
        if toupper(l:word) ==# 'REM'
          let l:result .= 'REM' . strpart(l:line, l:i + 3)
          break
        endif
        let l:up = toupper(l:word)
        let l:known = has_key(s:db, l:up) || index(s:mnemonics, l:up) >= 0
        let l:result .= l:known ? l:up : l:word
        let l:i += strlen(l:word)
      endif
    endif
  endwhile
  if l:result !=# l:line
    call setline(a:lnum, l:result)
  endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
