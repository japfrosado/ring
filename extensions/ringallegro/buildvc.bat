cls
call ../../src/locatevc.bat
cl /c /DEBUG ring_allegro.c -I"..\..\libdepwin\allegro\include" -I"..\..\include"
link /DEBUG ring_allegro.obj  ..\..\lib\ring.lib ..\..\libdepwin\allegro\lib\allegro_monolith.lib /DLL /OUT:..\..\bin\ring_allegro.dll /SUBSYSTEM:CONSOLE,"5.01" 
del ring_allegro.obj