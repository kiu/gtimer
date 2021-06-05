EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "https://github.com/kiu/gtimer"
Date ""
Rev ""
Comp "@kiu112"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:C C2
U 1 1 5F94D3A0
P 3350 6900
F 0 "C2" H 3465 6946 50  0000 L CNN
F 1 "100nF" H 3465 6855 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 3388 6750 50  0001 C CNN
F 3 "~" H 3350 6900 50  0001 C CNN
	1    3350 6900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5F94DD4E
P 4400 6650
F 0 "R1" H 4470 6696 50  0000 L CNN
F 1 "10k" H 4470 6605 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 4330 6650 50  0001 C CNN
F 3 "~" H 4400 6650 50  0001 C CNN
	1    4400 6650
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x03_Odd_Even JISP1
U 1 1 5F94E3CD
P 4600 5450
F 0 "JISP1" H 4650 5767 50  0000 C CNN
F 1 "Conn_02x03_Odd_Even" H 4650 5676 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03_Pitch2.54mm" H 4600 5450 50  0001 C CNN
F 3 "~" H 4600 5450 50  0001 C CNN
	1    4600 5450
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR03
U 1 1 5F956867
P 5150 5250
F 0 "#PWR03" H 5150 5100 50  0001 C CNN
F 1 "+5V" H 5165 5423 50  0000 C CNN
F 2 "" H 5150 5250 50  0001 C CNN
F 3 "" H 5150 5250 50  0001 C CNN
	1    5150 5250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5F956E30
P 5150 5650
F 0 "#PWR05" H 5150 5400 50  0001 C CNN
F 1 "GND" H 5155 5477 50  0000 C CNN
F 2 "" H 5150 5650 50  0001 C CNN
F 3 "" H 5150 5650 50  0001 C CNN
	1    5150 5650
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x03 JDBG1
U 1 1 5F99F520
P 6250 5450
F 0 "JDBG1" H 6330 5492 50  0000 L CNN
F 1 "Conn_01x03" H 6330 5401 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 6250 5450 50  0001 C CNN
F 3 "~" H 6250 5450 50  0001 C CNN
	1    6250 5450
	1    0    0    -1  
$EndComp
Text GLabel 5950 5350 0    50   Input ~ 0
DBG_RX
Text GLabel 5950 5450 0    50   Input ~ 0
DBG_TX
$Comp
L power:GND #PWR06
U 1 1 5F99FE46
P 5950 5650
F 0 "#PWR06" H 5950 5400 50  0001 C CNN
F 1 "GND" H 5955 5477 50  0000 C CNN
F 2 "" H 5950 5650 50  0001 C CNN
F 3 "" H 5950 5650 50  0001 C CNN
	1    5950 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 5650 5950 5550
Wire Wire Line
	5950 5550 6050 5550
Wire Wire Line
	6050 5450 5950 5450
Wire Wire Line
	5950 5350 6050 5350
Text GLabel 2350 6350 2    50   Input ~ 0
DBG_TX
Text GLabel 2350 6250 2    50   Input ~ 0
DBG_RX
Text GLabel 2350 4850 2    50   Input ~ 0
ISP_MOSI
Text GLabel 2350 4950 2    50   Input ~ 0
ISP_MISO
Text GLabel 2350 5050 2    50   Input ~ 0
ISP_SCK
Text GLabel 2350 6050 2    50   Input ~ 0
ISP_RES
Text GLabel 5050 5450 2    50   Input ~ 0
ISP_MOSI
Text GLabel 4250 5350 0    50   Input ~ 0
ISP_MISO
Text GLabel 4250 5450 0    50   Input ~ 0
ISP_SCK
Text GLabel 4250 5550 0    50   Input ~ 0
ISP_RES
Text GLabel 2350 5850 2    50   Input ~ 0
TWI_SDA
Text GLabel 2350 5950 2    50   Input ~ 0
TWI_SCL
$Comp
L Device:R R3
U 1 1 5F9DB6CD
P 6150 6900
F 0 "R3" H 6220 6946 50  0000 L CNN
F 1 "10k" H 6220 6855 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6080 6900 50  0001 C CNN
F 3 "~" H 6150 6900 50  0001 C CNN
	1    6150 6900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5F9DBFB4
P 6650 6900
F 0 "R4" H 6720 6946 50  0000 L CNN
F 1 "10k" H 6720 6855 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 6580 6900 50  0001 C CNN
F 3 "~" H 6650 6900 50  0001 C CNN
	1    6650 6900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR08
U 1 1 5F9DEEBF
P 3350 6350
F 0 "#PWR08" H 3350 6200 50  0001 C CNN
F 1 "+5V" H 3365 6523 50  0000 C CNN
F 2 "" H 3350 6350 50  0001 C CNN
F 3 "" H 3350 6350 50  0001 C CNN
	1    3350 6350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR014
U 1 1 5F9DFBCC
P 3350 7450
F 0 "#PWR014" H 3350 7200 50  0001 C CNN
F 1 "GND" H 3355 7277 50  0000 C CNN
F 2 "" H 3350 7450 50  0001 C CNN
F 3 "" H 3350 7450 50  0001 C CNN
	1    3350 7450
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5F9EDB6B
P 4400 7150
F 0 "C4" H 4515 7196 50  0000 L CNN
F 1 "100nF" H 4515 7105 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 4438 7000 50  0001 C CNN
F 3 "~" H 4400 7150 50  0001 C CNN
	1    4400 7150
	1    0    0    -1  
$EndComp
Text GLabel 4200 6900 0    50   Input ~ 0
ISP_RES
$Comp
L power:+5V #PWR010
U 1 1 5F9EE841
P 4400 6350
F 0 "#PWR010" H 4400 6200 50  0001 C CNN
F 1 "+5V" H 4415 6523 50  0000 C CNN
F 2 "" H 4400 6350 50  0001 C CNN
F 3 "" H 4400 6350 50  0001 C CNN
	1    4400 6350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5F9EF0A9
P 4400 7450
F 0 "#PWR016" H 4400 7200 50  0001 C CNN
F 1 "GND" H 4405 7277 50  0000 C CNN
F 2 "" H 4400 7450 50  0001 C CNN
F 3 "" H 4400 7450 50  0001 C CNN
	1    4400 7450
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR01
U 1 1 5F9EFC23
P 1550 4100
F 0 "#PWR01" H 1550 3950 50  0001 C CNN
F 1 "+5V" H 1565 4273 50  0000 C CNN
F 2 "" H 1550 4100 50  0001 C CNN
F 3 "" H 1550 4100 50  0001 C CNN
	1    1550 4100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR019
U 1 1 5F9F0B65
P 1600 7500
F 0 "#PWR019" H 1600 7250 50  0001 C CNN
F 1 "GND" H 1605 7327 50  0000 C CNN
F 2 "" H 1600 7500 50  0001 C CNN
F 3 "" H 1600 7500 50  0001 C CNN
	1    1600 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 7500 1600 7250
Wire Wire Line
	1550 4100 1550 4150
Wire Wire Line
	1550 4150 1600 4150
Wire Wire Line
	1600 4150 1600 4250
Wire Wire Line
	1700 4250 1700 4150
Text GLabel 6650 7300 3    50   Input ~ 0
TWI_SDA
Text GLabel 6150 7300 3    50   Input ~ 0
TWI_SCL
$Comp
L power:+5V #PWR012
U 1 1 5F9FDC31
P 6150 6350
F 0 "#PWR012" H 6150 6200 50  0001 C CNN
F 1 "+5V" H 6165 6523 50  0000 C CNN
F 2 "" H 6150 6350 50  0001 C CNN
F 3 "" H 6150 6350 50  0001 C CNN
	1    6150 6350
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR013
U 1 1 5F9FE5B1
P 6650 6350
F 0 "#PWR013" H 6650 6200 50  0001 C CNN
F 1 "+5V" H 6665 6523 50  0000 C CNN
F 2 "" H 6650 6350 50  0001 C CNN
F 3 "" H 6650 6350 50  0001 C CNN
	1    6650 6350
	1    0    0    -1  
$EndComp
Text Notes 6250 6050 0    50   ~ 0
Optional
$Comp
L Connector_Generic:Conn_01x02 JPWR1
U 1 1 5F9FFBA4
P 6250 4400
F 0 "JPWR1" H 6330 4392 50  0000 L CNN
F 1 "Conn_01x02" H 6330 4301 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 6250 4400 50  0001 C CNN
F 3 "~" H 6250 4400 50  0001 C CNN
	1    6250 4400
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR04
U 1 1 5FA00432
P 5950 4250
F 0 "#PWR04" H 5950 4100 50  0001 C CNN
F 1 "+5V" H 5965 4423 50  0000 C CNN
F 2 "" H 5950 4250 50  0001 C CNN
F 3 "" H 5950 4250 50  0001 C CNN
	1    5950 4250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5FA00B06
P 5950 4650
F 0 "#PWR07" H 5950 4400 50  0001 C CNN
F 1 "GND" H 5955 4477 50  0000 C CNN
F 2 "" H 5950 4650 50  0001 C CNN
F 3 "" H 5950 4650 50  0001 C CNN
	1    5950 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 4500 6050 4500
Wire Wire Line
	6050 4400 5950 4400
Wire Wire Line
	4400 6500 4400 6350
Wire Wire Line
	4400 6800 4400 6900
Wire Wire Line
	4400 7300 4400 7450
Connection ~ 4400 6900
Wire Wire Line
	4400 6900 4400 7000
Wire Wire Line
	5050 5450 4900 5450
Wire Wire Line
	4900 5550 5150 5550
Wire Wire Line
	5150 5550 5150 5650
Wire Wire Line
	4900 5350 5150 5350
Wire Wire Line
	5150 5350 5150 5250
Wire Wire Line
	4400 5350 4250 5350
Wire Wire Line
	4250 5450 4400 5450
Wire Wire Line
	4250 5550 4400 5550
$Comp
L Device:C C1
U 1 1 5F9F4A66
P 900 4800
F 0 "C1" H 1015 4846 50  0000 L CNN
F 1 "100nF" H 1015 4755 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 938 4650 50  0001 C CNN
F 3 "~" H 900 4800 50  0001 C CNN
	1    900  4800
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5F9F552E
P 900 5100
F 0 "#PWR02" H 900 4850 50  0001 C CNN
F 1 "GND" H 905 4927 50  0000 C CNN
F 2 "" H 900 5100 50  0001 C CNN
F 3 "" H 900 5100 50  0001 C CNN
	1    900  5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1000 4550 900  4550
Wire Wire Line
	900  4550 900  4650
Wire Wire Line
	900  4950 900  5100
Wire Wire Line
	2200 5850 2350 5850
Wire Wire Line
	2200 5950 2350 5950
Wire Wire Line
	2200 6050 2350 6050
Wire Wire Line
	2350 6250 2200 6250
Wire Wire Line
	2200 6350 2350 6350
Wire Wire Line
	2350 4850 2200 4850
Wire Wire Line
	2350 4950 2200 4950
Wire Wire Line
	2350 5050 2200 5050
NoConn ~ 2200 5150
NoConn ~ 2200 5250
NoConn ~ 2200 6950
NoConn ~ 1000 6550
NoConn ~ 1000 6450
NoConn ~ 1000 6350
NoConn ~ 1000 6250
Wire Wire Line
	4200 6900 4400 6900
Wire Wire Line
	3350 7050 3350 7450
Wire Wire Line
	3350 6350 3350 6750
Wire Wire Line
	6150 6350 6150 6750
Wire Wire Line
	6650 6350 6650 6750
Wire Wire Line
	5950 4500 5950 4650
Wire Wire Line
	5950 4250 5950 4400
Wire Notes Line
	500  3850 500  7750
Wire Notes Line
	6900 7750 6900 3850
Wire Notes Line
	500  7750 6900 7750
Wire Notes Line
	500  3850 6900 3850
Wire Wire Line
	6650 7050 6650 7300
Wire Wire Line
	6150 7050 6150 7300
$Comp
L power:+15V #PWR015
U 1 1 60985743
P 2100 1000
F 0 "#PWR015" H 2100 850 50  0001 C CNN
F 1 "+15V" H 2115 1173 50  0000 C CNN
F 2 "" H 2100 1000 50  0001 C CNN
F 3 "" H 2100 1000 50  0001 C CNN
	1    2100 1000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 609864E9
P 2700 1900
F 0 "#PWR023" H 2700 1650 50  0001 C CNN
F 1 "GND" H 2705 1727 50  0000 C CNN
F 2 "" H 2700 1900 50  0001 C CNN
F 3 "" H 2700 1900 50  0001 C CNN
	1    2700 1900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR017
U 1 1 609870D2
P 3300 1000
F 0 "#PWR017" H 3300 850 50  0001 C CNN
F 1 "+5V" H 3315 1173 50  0000 C CNN
F 2 "" H 3300 1000 50  0001 C CNN
F 3 "" H 3300 1000 50  0001 C CNN
	1    3300 1000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR020
U 1 1 60987DE9
P 750 1400
F 0 "#PWR020" H 750 1150 50  0001 C CNN
F 1 "GND" H 755 1227 50  0000 C CNN
F 2 "" H 750 1400 50  0001 C CNN
F 3 "" H 750 1400 50  0001 C CNN
	1    750  1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	750  1250 850  1250
Wire Wire Line
	850  1150 750  1150
Wire Wire Line
	750  1250 750  1400
Wire Wire Line
	750  1000 750  1150
$Comp
L power:+15V #PWR011
U 1 1 6098A47E
P 750 1000
F 0 "#PWR011" H 750 850 50  0001 C CNN
F 1 "+15V" H 765 1173 50  0000 C CNN
F 2 "" H 750 1000 50  0001 C CNN
F 3 "" H 750 1000 50  0001 C CNN
	1    750  1000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 6099154D
P 8400 4600
F 0 "R2" H 8470 4646 50  0000 L CNN
F 1 "1k" H 8470 4555 50  0000 L CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 8330 4600 50  0001 C CNN
F 3 "~" H 8400 4600 50  0001 C CNN
	1    8400 4600
	0    1    1    0   
$EndComp
$Comp
L Device:CP C3
U 1 1 60997EBD
P 2100 1450
F 0 "C3" H 2218 1496 50  0000 L CNN
F 1 "10uF" H 2218 1405 50  0000 L CNN
F 2 "Capacitors_Tantalum_SMD:CP_Tantalum_Case-D_EIA-7343-31_Hand" H 2138 1300 50  0001 C CNN
F 3 "~" H 2100 1450 50  0001 C CNN
	1    2100 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C5
U 1 1 60998BA4
P 3300 1450
F 0 "C5" H 3418 1496 50  0000 L CNN
F 1 "10uF" H 3418 1405 50  0000 L CNN
F 2 "Capacitors_Tantalum_SMD:CP_Tantalum_Case-D_EIA-7343-31_Hand" H 3338 1300 50  0001 C CNN
F 3 "~" H 3300 1450 50  0001 C CNN
	1    3300 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 1600 2100 1750
Wire Wire Line
	2100 1750 2700 1750
Wire Wire Line
	3300 1600 3300 1750
Wire Wire Line
	3300 1750 2700 1750
Connection ~ 2700 1750
Wire Wire Line
	2700 1900 2700 1750
$Comp
L Relay:G2RL-24-DC5 RL1
U 1 1 609BE1BA
P 9400 5400
F 0 "RL1" H 10030 5446 50  0000 L CNN
F 1 "G2RL-24-DC5" H 10030 5355 50  0000 L CNN
F 2 "kiu-footprints:Relay_DPDT_Omron_G2RL-24" H 10050 5350 50  0001 L CNN
F 3 "https://omronfs.omron.com/en_US/ecb/products/pdf/en-g2rl.pdf" H 9400 5400 50  0001 C CNN
	1    9400 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 4950 9000 4800
Wire Wire Line
	9000 4950 9000 5100
Connection ~ 9000 4950
Wire Wire Line
	9000 5850 9000 5700
$Comp
L power:GND #PWR027
U 1 1 609D3B4D
P 9000 6000
F 0 "#PWR027" H 9000 5750 50  0001 C CNN
F 1 "GND" H 9005 5827 50  0000 C CNN
F 2 "" H 9000 6000 50  0001 C CNN
F 3 "" H 9000 6000 50  0001 C CNN
	1    9000 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 6000 9000 5850
Connection ~ 9000 5850
Wire Wire Line
	8700 4600 8550 4600
$Comp
L power:+5V #PWR026
U 1 1 609D7EDF
P 9000 4250
F 0 "#PWR026" H 9000 4100 50  0001 C CNN
F 1 "+5V" H 9015 4423 50  0000 C CNN
F 2 "" H 9000 4250 50  0001 C CNN
F 3 "" H 9000 4250 50  0001 C CNN
	1    9000 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 4250 9000 4400
Text GLabel 8100 4600 0    50   Input ~ 0
RELAY
Wire Wire Line
	8100 4600 8250 4600
Text GLabel 2350 4550 2    50   Input ~ 0
RELAY
Wire Notes Line
	7000 3850 11150 3850
Wire Notes Line
	11150 3850 11150 6450
Wire Notes Line
	11150 6450 7000 6450
Wire Notes Line
	7000 6450 7000 3850
Wire Notes Line
	600  600  600  2200
Wire Notes Line
	600  2200 3700 2200
Wire Notes Line
	3700 2200 3700 600 
Wire Notes Line
	3700 600  600  600 
Text GLabel 4500 750  0    50   Input ~ 0
BTN_NOW
Text GLabel 4500 850  0    50   Input ~ 0
BTN_NOW_LED
Wire Wire Line
	4500 950  4650 950 
Wire Wire Line
	4650 850  4500 850 
Wire Wire Line
	4500 750  4650 750 
$Comp
L power:+15V #PWR028
U 1 1 60A11240
P 9400 6000
F 0 "#PWR028" H 9400 5850 50  0001 C CNN
F 1 "+15V" H 9415 6173 50  0000 C CNN
F 2 "" H 9400 6000 50  0001 C CNN
F 3 "" H 9400 6000 50  0001 C CNN
	1    9400 6000
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR029
U 1 1 60A12DF1
P 9800 6000
F 0 "#PWR029" H 9800 5750 50  0001 C CNN
F 1 "GND" H 9805 5827 50  0000 C CNN
F 2 "" H 9800 6000 50  0001 C CNN
F 3 "" H 9800 6000 50  0001 C CNN
	1    9800 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 5100 9900 4950
Wire Wire Line
	9500 5100 9500 4950
Wire Wire Line
	9400 5700 9400 6000
Wire Wire Line
	9800 5700 9800 6000
$Comp
L Connector:Screw_Terminal_01x02 JPMP1
U 1 1 60A1CF82
P 9650 4650
F 0 "JPMP1" V 9614 4462 50  0000 R CNN
F 1 "Screw_Terminal_01x02" V 9523 4462 50  0000 R CNN
F 2 "Terminal_Blocks:TerminalBlock_bornier-2_P5.08mm" H 9650 4650 50  0001 C CNN
F 3 "~" H 9650 4650 50  0001 C CNN
	1    9650 4650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9750 4850 9750 4950
Wire Wire Line
	9750 4950 9900 4950
Wire Wire Line
	9500 4950 9650 4950
Wire Wire Line
	9650 4950 9650 4850
Text GLabel 4500 1550 0    50   Input ~ 0
BTN_WAIT
Text GLabel 4500 1650 0    50   Input ~ 0
BTN_WAIT_LED
$Comp
L power:GND #PWR024
U 1 1 60A2C4FD
P 4500 1900
F 0 "#PWR024" H 4500 1650 50  0001 C CNN
F 1 "GND" H 4505 1727 50  0000 C CNN
F 2 "" H 4500 1900 50  0001 C CNN
F 3 "" H 4500 1900 50  0001 C CNN
	1    4500 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 1900 4500 1850
Wire Wire Line
	4500 1750 4650 1750
Wire Wire Line
	4650 1650 4500 1650
Wire Wire Line
	4500 1550 4650 1550
Text GLabel 2350 5450 2    50   Input ~ 0
BTN_NOW
Text GLabel 2350 5550 2    50   Input ~ 0
BTN_NOW_LED
Text GLabel 2350 5650 2    50   Input ~ 0
BTN_WAIT
Text GLabel 2350 5750 2    50   Input ~ 0
BTN_WAIT_LED
Wire Notes Line
	3800 600  3800 2200
$Comp
L MCU_Microchip_ATmega:ATmega328PB-AU U1
U 1 1 5F94A1DC
P 1600 5750
F 0 "U1" H 1600 4161 50  0000 C CNN
F 1 "ATmega328PB-AU" H 1600 4070 50  0000 C CNN
F 2 "Housings_QFP:LQFP-32_7x7mm_Pitch0.8mm" H 1600 5750 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/40001906C.pdf" H 1600 5750 50  0001 C CNN
	1    1600 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 4550 2200 4550
$Comp
L power:+5V #PWR025
U 1 1 60A8D337
P 1750 4100
F 0 "#PWR025" H 1750 3950 50  0001 C CNN
F 1 "+5V" H 1765 4273 50  0000 C CNN
F 2 "" H 1750 4100 50  0001 C CNN
F 3 "" H 1750 4100 50  0001 C CNN
	1    1750 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 4150 1750 4150
Wire Wire Line
	1750 4150 1750 4100
$Comp
L Diode:BAV99 D1
U 1 1 60AA3209
P 8400 5450
F 0 "D1" V 8446 5529 50  0000 L CNN
F 1 "BAV99" V 8355 5529 50  0000 L CNN
F 2 "digikey-footprints:SOT-23-3" H 8400 4950 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/BAV99_SER.pdf" H 8400 5450 50  0001 C CNN
	1    8400 5450
	0    1    -1   0   
$EndComp
NoConn ~ 8200 5450
Wire Wire Line
	8400 4950 8400 5150
Wire Wire Line
	8400 4950 9000 4950
Wire Wire Line
	8400 5750 8400 5850
Wire Wire Line
	8400 5850 9000 5850
$Comp
L Transistor_BJT:BC847 Q1
U 1 1 60AB23B6
P 8900 4600
F 0 "Q1" H 9091 4646 50  0000 L CNN
F 1 "BC847" H 9091 4555 50  0000 L CNN
F 2 "digikey-footprints:SOT-23-3" H 9100 4525 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/Infineon-BC847SERIES_BC848SERIES_BC849SERIES_BC850SERIES-DS-v01_01-en.pdf?fileId=db3a304314dca389011541d4630a1657" H 8900 4600 50  0001 L CNN
	1    8900 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 5450 2350 5450
Wire Wire Line
	2350 5550 2200 5550
Wire Wire Line
	2200 5650 2350 5650
Wire Wire Line
	2350 5750 2200 5750
$Comp
L Connector:Screw_Terminal_01x02 JPWR2
U 1 1 60B47AAA
P 1050 1150
F 0 "JPWR2" H 1130 1142 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 1130 1051 50  0000 L CNN
F 2 "Terminal_Blocks:TerminalBlock_bornier-2_P5.08mm" H 1050 1150 50  0001 C CNN
F 3 "~" H 1050 1150 50  0001 C CNN
	1    1050 1150
	1    0    0    -1  
$EndComp
NoConn ~ 9300 5100
NoConn ~ 9700 5100
Wire Notes Line
	5650 600  5650 2200
Wire Notes Line
	5650 2200 7100 2200
Wire Notes Line
	7100 2200 7100 600 
Wire Notes Line
	7100 600  5650 600 
$Comp
L Connector_Generic:Conn_01x05 JNOW1
U 1 1 60B6AFF1
P 4850 950
F 0 "JNOW1" H 4930 942 50  0000 L CNN
F 1 "Conn_01x04" H 4930 851 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 4850 950 50  0001 C CNN
F 3 "~" H 4850 950 50  0001 C CNN
	1    4850 950 
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x05 JWAIT1
U 1 1 60B6BB44
P 4850 1750
F 0 "JWAIT1" H 4930 1742 50  0000 L CNN
F 1 "Conn_01x04" H 4930 1651 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 4850 1750 50  0001 C CNN
F 3 "~" H 4850 1750 50  0001 C CNN
	1    4850 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 1050 4500 1050
Connection ~ 4500 1050
Wire Wire Line
	4500 1050 4500 950 
Wire Wire Line
	4650 1850 4500 1850
Connection ~ 4500 1850
Wire Wire Line
	4500 1850 4500 1750
Wire Wire Line
	3300 1000 3300 1150
Wire Wire Line
	2100 1150 2100 1300
Wire Wire Line
	2100 1000 2100 1150
Connection ~ 2100 1150
Wire Wire Line
	2100 1150 2400 1150
$Comp
L dk_PMIC-Voltage-Regulators-Linear:NCP1117ST50T3G U2
U 1 1 60B76ECC
P 2700 1150
F 0 "U2" H 2750 1437 60  0000 C CNN
F 1 "NCP1117ST50T3G" H 2750 1331 60  0000 C CNN
F 2 "digikey-footprints:SOT-223" H 2900 1350 60  0001 L CNN
F 3 "https://www.onsemi.com/pub/Collateral/NCP1117-D.PDF" H 2900 1450 60  0001 L CNN
F 4 "NCP1117ST50T3GOSCT-ND" H 2900 1550 60  0001 L CNN "Digi-Key_PN"
F 5 "NCP1117ST50T3G" H 2900 1650 60  0001 L CNN "MPN"
F 6 "Integrated Circuits (ICs)" H 2900 1750 60  0001 L CNN "Category"
F 7 "PMIC - Voltage Regulators - Linear" H 2900 1850 60  0001 L CNN "Family"
F 8 "https://www.onsemi.com/pub/Collateral/NCP1117-D.PDF" H 2900 1950 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/on-semiconductor/NCP1117ST50T3G/NCP1117ST50T3GOSCT-ND/1967217" H 2900 2050 60  0001 L CNN "DK_Detail_Page"
F 10 "IC REG LINEAR 5V 1A SOT223" H 2900 2150 60  0001 L CNN "Description"
F 11 "ON Semiconductor" H 2900 2250 60  0001 L CNN "Manufacturer"
F 12 "Active" H 2900 2350 60  0001 L CNN "Status"
	1    2700 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 1750 2700 1550
Wire Wire Line
	3100 1250 3300 1250
Connection ~ 3300 1250
Wire Wire Line
	3300 1250 3300 1300
Wire Wire Line
	3100 1150 3300 1150
Connection ~ 3300 1150
Wire Wire Line
	3300 1150 3300 1250
Wire Notes Line
	3800 2200 5550 2200
Wire Notes Line
	5550 2200 5550 600 
Wire Notes Line
	5550 600  3800 600 
$Comp
L Connector_Generic:Conn_01x04 JHTU1
U 1 1 60BF5EB9
P 8200 1200
F 0 "JHTU1" H 8280 1192 50  0000 L CNN
F 1 "Conn_01x04" H 8280 1101 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 8200 1200 50  0001 C CNN
F 3 "~" H 8200 1200 50  0001 C CNN
	1    8200 1200
	1    0    0    -1  
$EndComp
Text GLabel 7850 1400 0    50   Input ~ 0
TWI_SDA
Text GLabel 7850 1300 0    50   Input ~ 0
TWI_SCL
$Comp
L power:GND #PWR021
U 1 1 60BF6E5F
P 7400 1550
F 0 "#PWR021" H 7400 1300 50  0001 C CNN
F 1 "GND" H 7405 1377 50  0000 C CNN
F 2 "" H 7400 1550 50  0001 C CNN
F 3 "" H 7400 1550 50  0001 C CNN
	1    7400 1550
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR09
U 1 1 60BF73C2
P 7850 950
F 0 "#PWR09" H 7850 800 50  0001 C CNN
F 1 "+5V" H 7865 1123 50  0000 C CNN
F 2 "" H 7850 950 50  0001 C CNN
F 3 "" H 7850 950 50  0001 C CNN
	1    7850 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 950  7850 1100
Wire Wire Line
	7850 1100 8000 1100
Wire Wire Line
	8000 1200 7400 1200
Wire Wire Line
	7400 1200 7400 1550
Wire Wire Line
	8000 1300 7850 1300
Wire Wire Line
	8000 1400 7850 1400
Wire Notes Line
	7200 600  7200 1900
Wire Notes Line
	7200 1900 8850 1900
Wire Notes Line
	8850 1900 8850 600 
Wire Notes Line
	8850 600  7200 600 
Text Notes 650  700  0    50   ~ 0
Power
Text Notes 7300 750  0    50   ~ 0
HTU21
$Comp
L Connector_Generic:Conn_01x05 JRTC1
U 1 1 60A01F92
P 6450 1300
F 0 "JRTC1" H 6530 1342 50  0000 L CNN
F 1 "Conn_01x05" H 6530 1251 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 6450 1300 50  0001 C CNN
F 3 "~" H 6450 1300 50  0001 C CNN
	1    6450 1300
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR022
U 1 1 60A030ED
P 6100 950
F 0 "#PWR022" H 6100 800 50  0001 C CNN
F 1 "+5V" H 6115 1123 50  0000 C CNN
F 2 "" H 6100 950 50  0001 C CNN
F 3 "" H 6100 950 50  0001 C CNN
	1    6100 950 
	1    0    0    -1  
$EndComp
Text GLabel 6100 1200 0    50   Input ~ 0
TWI_SDA
Text GLabel 6100 1300 0    50   Input ~ 0
TWI_SCL
$Comp
L power:GND #PWR030
U 1 1 60A03903
P 6100 1650
F 0 "#PWR030" H 6100 1400 50  0001 C CNN
F 1 "GND" H 6105 1477 50  0000 C CNN
F 2 "" H 6100 1650 50  0001 C CNN
F 3 "" H 6100 1650 50  0001 C CNN
	1    6100 1650
	1    0    0    -1  
$EndComp
NoConn ~ 6250 1400
Wire Wire Line
	6250 1100 6100 1100
Wire Wire Line
	6100 1100 6100 950 
Wire Wire Line
	6250 1500 6100 1500
Wire Wire Line
	6100 1500 6100 1650
Wire Wire Line
	6250 1300 6100 1300
Wire Wire Line
	6250 1200 6100 1200
Text Notes 5750 750  0    50   ~ 0
RTC
NoConn ~ 2200 6850
NoConn ~ 2200 6750
NoConn ~ 2200 6650
NoConn ~ 2200 6550
NoConn ~ 2200 6450
NoConn ~ 2200 4750
NoConn ~ 2200 4650
$Comp
L Mechanical:MountingHole H1
U 1 1 60A71A4B
P 9100 750
F 0 "H1" H 9200 796 50  0000 L CNN
F 1 "MountingHole" H 9200 705 50  0000 L CNN
F 2 "Mounting_Holes:MountingHole_4.3mm_M4" H 9100 750 50  0001 C CNN
F 3 "~" H 9100 750 50  0001 C CNN
	1    9100 750 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 60A72735
P 9100 1150
F 0 "H3" H 9200 1196 50  0000 L CNN
F 1 "MountingHole" H 9200 1105 50  0000 L CNN
F 2 "Mounting_Holes:MountingHole_4.3mm_M4" H 9100 1150 50  0001 C CNN
F 3 "~" H 9100 1150 50  0001 C CNN
	1    9100 1150
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H5
U 1 1 60A72ACA
P 9850 750
F 0 "H5" H 9950 796 50  0000 L CNN
F 1 "MountingHole" H 9950 705 50  0000 L CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3" H 9850 750 50  0001 C CNN
F 3 "~" H 9850 750 50  0001 C CNN
	1    9850 750 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H6
U 1 1 60A72DA6
P 9850 950
F 0 "H6" H 9950 996 50  0000 L CNN
F 1 "MountingHole" H 9950 905 50  0000 L CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3" H 9850 950 50  0001 C CNN
F 3 "~" H 9850 950 50  0001 C CNN
	1    9850 950 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 60A7316A
P 9100 950
F 0 "H2" H 9200 996 50  0000 L CNN
F 1 "MountingHole" H 9200 905 50  0000 L CNN
F 2 "Mounting_Holes:MountingHole_4.3mm_M4" H 9100 950 50  0001 C CNN
F 3 "~" H 9100 950 50  0001 C CNN
	1    9100 950 
	1    0    0    -1  
$EndComp
Wire Notes Line
	8950 600  10500 600 
Wire Notes Line
	10500 600  10500 1550
Wire Notes Line
	10500 1550 8950 1550
Wire Notes Line
	8950 1550 8950 600 
Wire Wire Line
	4500 1100 4500 1050
$Comp
L power:GND #PWR018
U 1 1 60A08DEC
P 4500 1100
F 0 "#PWR018" H 4500 850 50  0001 C CNN
F 1 "GND" H 4505 927 50  0000 C CNN
F 2 "" H 4500 1100 50  0001 C CNN
F 3 "" H 4500 1100 50  0001 C CNN
	1    4500 1100
	1    0    0    -1  
$EndComp
NoConn ~ 4650 1150
NoConn ~ 4650 1950
$EndSCHEMATC
