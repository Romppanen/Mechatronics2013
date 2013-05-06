EEPROM 0,("Heippakaikki!") ' store the text in the EEPROM memory
gosub init ' initialise LCD
main: let b1 = 1 ' set b1 to 'clear display’ instruction
pause 200
gosub wrins ' send instruction to LCD
for b3 = 0 to 5 ' setup for...next loop (“Hello” - positions 0 to 4)
read b3, b1 ' read letter from EEPROM into variable b1
gosub wrchr ' send character to LCD
next b3 ' next loop
let b1 = 192 ' set b1 to 'start of second line’ position
gosub wrins ' send instruction to LCD
for b3 = 6 to 13 ' setup for...next loop (“there!”-positions 5 to 11)
read b3, b1 ' read letter from EEPROM memory into variable b1
gosub wrchr ' send character to LCD
next b3 ' next loop


init:
hi2csetup i2cmaster, %01000000, i2cslow, i2cbyte
let b5 = 0 ' Reset variable b5
pause 200 ' Wait 200 ms for LCD to reset.
hi2cout 0, (0x80) ' Set to 8-bit operation.
pause 1000
hi2cout 0, (0x10)
pause 10 ' Wait 10 ms
hi2cout 0, (0x03) ' taas
pause 1
hi2cout 0, (0x13)
pause 4
hi2cout 0, (0x03) ' vielä kerran
pause 1
hi2cout 0,(0x13)
pause 4
hi2cout 0, (0x02) ' Set to 4-bit operation.
pause 1
hi2cout 0, (0x12)
pause 10
hi2cout 0, (0x02) ' Set to 4-bit operation.
pause 1
hi2cout 0, (0x12)
pause 4
hi2cout 0, (0x02) ' Set to 4-bit operation.
pause 1
hi2cout 0, (0x12)
pause 4
hi2cout 0, (0x08) ' Set to two line operation
pause 1
hi2cout 0, (0x18) ' Send data.
pause 10
let b1 = 14 ' Screen on, cursor on instruction
gosub wrins ' Write instruction to LCD
return


wrchr:
let b5 = b1 / 16 
let b5 = b5 | 0x40' Make sure RS is high
hi2cout 0, (b5)
let b5 = b5 | 0x10
hi2cout 0,(b5)
pauseus 50
let b5 = b1 & 0x0F
let b5 = b5 | 0x40
hi2cout 0, (b5)
let b5 = b5 | 0x10
hi2cout 0, (b5) 
pauseus 50
return


wrins: 
let b5 = b1 / 16 
'let b5 = b5 | 0x80' Make sure RS is low
hi2cout 0, (b5)
let b5 = b5 | 0x10
hi2cout 0, (b5)
pauseus 50
let b5 = b1 & 0x0F
hi2cout 0, (b5)
let b5 =b5 | 0x10
hi2cout 0, (b5) 
pauseus 50
return

