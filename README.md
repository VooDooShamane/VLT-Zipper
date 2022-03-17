[ATTACH type="full" alt="VLT-Zipper2_Logo.JPG"]14269[/ATTACH]

VLT-Zipper 2 kommt nun ohne XiaoTea!
XiaoTea muss von dem Benutzer manuell hinzugefügt werden.
Ebenso benötigt VLT-Zipper 2 nun die unverschlüsselten Vanilla Firmware Dateien DRV236.bin und DRV304.bin.
(Beschreibung wie ihr die benötigten dinge in VLT-Zipper 2 integriert unten bei Download zu finden)

[B]Ich habe VLT-Zipper aber auch stark in sachen Sicherheit überarbeitet.[/B]
Neben der, im Hintergrund ablaufenden Überprüfungen, die z.b. verifizieren ob eine Datei auch richtig erstellt wurde,
Ist die größte Verbesserung nun, dass die params.txt (zu finden in der fertigen zip) auch die Offsets und jeweiligen Veränderungen
der VLT-Firmware beinhaltet.
Das ermöglicht nun noch besser nachzuvollziehen, was in der VLT-Firmware überhaupt gepatcht wurde.
Auch kann in Zukunft, sollte der Roller mal ein ungewöhnliches Verhalten zeigen, hier im VLT Thread besagte params.txt gepostet werden.
Dann können wir untersuchen was das "ungewollte Verhalten" verursacht und verbessern.
Das ist der Grund, warum [USER=13840]@nandtek[/USER] und ich ab jetzt den VLT-Zipper 2 als bevorzugte Methode,
für das erstellen einer zip Datei empfehlen.

So sieht eine von VLT-Zipper 2 generierte params.txt nun aus.
[SPOILER]
- Version: DRV236;
This file has been generated from VLT_Zipper powered by XiaoTea. Make sure you know what it contains.;
;
Changes below;
Offset| Vanilla | Mod;
Vergleichen der Dateien C:\VLT_ZIPPER2\RESOURCE\BIN\FIRMWARES\DRV236.bin und C:\VLT_ZIPPER2\236LTGM.BIN
00000724: 43 3A
00000725: 10 11
0000073C: 43 3A
0000073D: 00 01
00000BFC: 43 3A
00000BFD: 20 21
0000156A: 43 3A
0000156B: 00 01
00005E6A: 43 3A
00005E6B: 10 11
00005EDE: 43 3A
00005EDF: 10 11
00005F58: 43 3A
00005F59: 30 31
00005F6E: 43 3A
00005F6F: 30 31
00006162: 43 3A
00006163: 00 01
00006170: 43 3A
00006171: 00 01
000061EE: 43 3A
000061EF: 00 01
000068B0: 43 3A
000068B1: 20 21

[/SPOILER]
[COLOR=rgb(250, 197, 28)]Offset[/COLOR] [COLOR=rgb(65, 168, 95)]Vanillawert an dem Offset[/COLOR] [COLOR=rgb(184, 49, 47)]Modifizierter Wert an dem Offset[/COLOR]
[COLOR=rgb(250, 197, 28)]00000724:[/COLOR] [COLOR=rgb(65, 168, 95)]43[/COLOR] [COLOR=rgb(184, 49, 47)]3A[/COLOR]

[B]Die Handhabung von VLT-Zipper 2 bleibt gewohnt einfach![/B]
Es muss nur die gepatchte .bin (unverschlüsselte Firmware) auf die VLT-Zipper2.bat gezogen werden.
Dann macht VLT-Zipper 2 alles automatisch.
1. Firmware version wird überprüft
2. Firmware wird auf die erwartete Byte größe überprüft
3. Firmware wird mit der entsprechenden Vanilla Firmware verglichen
4. Erlangte Informationen werden in die info.txt und params.txt geschrieben
5. Firmware wird mit XiaoTea verschlüsselt
6. md5 checksummen der FIRM.bin und FIRM.bin.enc werden in info.txt geschrieben
7. erstellte FIRM.bin.enc, FIRM.bin, info.txt, params.txt werden gezippt

bei jedem schritt in dem eine Datei-operation stattfindet, überprüft sich VLT-Zipper 2 nun selbst.
Beispielsweise überprüft VLT-Zipper 2 nun auch ob die mit XiaoTea verschlüsselte Datei,
die erwartete Bytegröße hat.

Das macht VLT-Zipper 2 aktuell zu der sichersten Methode, um aus seiner gepatchten .bin eine zip Datei zum flashen zu erstellen.


[B][U][SIZE=7]Download und Anleitung[/SIZE][/U][/B]
VLT-Zipper 2 exestiert momentan nur für Win7-10 (Win11 und WinXP ungetestet)
Android Version wird bei entsprechend hohem Bedarf folgen

[URL='https://github.com/BotoX/xiaomi-m365-firmware-patcher/raw/master/xiaotea/xiaotea.py']-->xiaotea.py<--[/URL] (Rechts klick, Ziel speichern unter...)
[URL='https://github.com/BotoX/xiaomi-m365-firmware-patcher/raw/master/xiaotea/enc.py']-->enc.py<--[/URL] (Rechts klick, Ziel speichern unter...)
[URL='https://github.com/BotoX/xiaomi-m365-firmware-patcher/raw/master/xiaotea/dec.py']-->dec.py<--[/URL] (Rechts klick, Ziel speichern unter...)
[URL='https://files.scooterhacking.org/firmware/pro2/DRV/DRV236.bin']-->DRV236.bin<--[/URL]
[URL='https://files.scooterhacking.org/firmware/1s/DRV/DRV304.bin']-->DRV304.bin<--[/URL]

1. VLT-Zipper2.zip entpacken
2. xiaotea.py, enc.py, dec.py in "VLT_Zipper2\resource\bin\python\"  speichern
3. Vanilla Firmwares DRV236.bin, DRV304.bin in "VLT_Zipper2\resource\bin\firmwares\"  speichern

[B]Fertig, nun ist VLT-Zipper2 100% einsatzbereit![/B]
