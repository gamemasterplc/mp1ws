armips mp1ws.s
mpromtool -a mp1_temprom.z64 mp1_extract
xcopy "new_files" "mp1_extract" /S /E /Y
mpromtool -b -a mp1_temprom.z64 mp1_extract mp1ws.z64
rmdir /s /q mp1_extract
del mp1_temprom.z64