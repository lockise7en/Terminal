@echo off
echo.
echo               �q�������������������r
echo   �q������������   internet����   �������������r
echo   ��          �t�������������������s          ��
echo   ��     ��֧�ֲ�������·internet���ؾ���     ��
echo   ��                                          ��
echo   ��         msn:        ��
echo   �t�������������������������������������������s
echo.
echo ���Թ���Ա�������д�������
echo.
echo ���д�����ǰ:
echo ------���ȰѸ�������ͨinternet
echo ------��������ipconfig /all�鿴��������Ӧ�������
echo.
setlocal EnableDelayedExpansion

rem ��ȡ������Ϣ-----------------------------------------
for /f "delims=" %%i in ('route print ^| find "..."') do (
set /a n+=1
set line!n!=%%i
)
echo.

rem ��ȡ������Ϣ-----------------------------------------
set m=1 & set o=1
:getinter
for /f "tokens=2 delims==" %%i in ('set line%m%') do set line%m%=%%i
set yn=
set /p yn=!line%m%! ��internetͨ·��[ֱ�ӻس�Ĭ��n][y/n]?:
if "%yn%" == "y" (
for /f "tokens=1,* delims=. " %%i in ("!line%m%!") do set interface%o%=%%i
set /p gateway%o%=...........����[ֱ�ӻس�Ĭ��192.168.168.1]:
if "#!gateway%o%!" == "#" set gateway%o%=192.168.168.1
set /a o+=1
)
set /a m+=1
if %m% leq %n% goto getinter

rem ����·��-----------------------------------------
echo.

if "#%interface1%" == "#" (
echo û��internetͨ·
goto ext
)

if "#%interface2%" == "#" (
echo ֻ��һ���������������ܸ��ؾ���
goto ext
)

rem �ų�IP��10 127 172 169 192
if "#%interface3%" == "#" (
echo �ж���������������ʼ���ؾ���...
set n1=1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83 85 87 89 91 93 95 97 99 101 103 105 107 109 111 113 115 117 119 121 123 125 129 131 133 135 137 139 141 143 145 147 149 151 153 155 157 159 161 163 165 167 171 173 175 177 179 181 183 185 187 189 191 193 195 197 199 201 203 205 207 209 211 213 215 217 219 221 223
set n2=2 4 6 8 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 86 88 90 92 94 96 98 100 102 104 106 108 110 112 114 116 118 120 122 124 126 128 130 132 134 136 138 140 142 144 146 148 150 152 154 156 158 160 162 164 166 168 170 174 176 178 180 182 184 186 188 190 194 196 198 200 202 204 206 208 210 212 214 216 218 220 222
rem route delete 0.0.0.0 >nul
route delete 0.0.0.0
route add  0.0.0.0 mask 0.0.0.0 %gateway1% metric 30 if %interface1%
for %%i in (!n1!) do route  add %%i.0.0.0 mask 255.0.0.0 %gateway1% metric 25 if %interface1%
for %%i in (!n2!) do route  add %%i.0.0.0 mask 255.0.0.0 %gateway2% metric 25 if %interface2%
goto ext
)

if "#%interface4%" == "#" (
echo ������������������ʼ���ؾ���...
set n1=1 4 7 13 16 19 22 25 28 31 34 37 40 43 46 49 52 55 58 61 64 67 70 73 76 79 82 85 88 91 94 97 100 103 106 109 112 115 118 121 124 130 133 136 139 142 145 148 151 154 157 160 163 166 175 178 181 184 187 190 193 196 199 202 205 208 211 214 217 220 223
set n2=2 5 8 11 14 17 20 23 26 29 32 35 38 41 44 47 50 53 56 59 62 65 68 71 74 77 80 83 86 89 92 95 98 101 104 107 110 113 116 119 122 125 128 131 134 137 140 143 146 149 152 155 158 161 164 167 170 173 176 179 182 185 188 191 194 197 200 203 206 209 212 215 218 221
set n3=3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60 63 66 69 72 75 78 81 84 87 90 93 96 99 102 105 108 111 114 117 120 123 126 129 132 135 138 141 144 147 150 153 156 159 162 165 168 171 174 177 180 183 186 189 195 198 201 204 207 210 213 216 219 222
route delete 0.0.0.0
route add 0.0.0.0 mask 0.0.0.0 %gateway1% metric 30 if %interface1%
for %%i in (!n1!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway1% metric 25 if %interface1%
for %%i in (!n2!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway2% metric 25 if %interface2%
for %%i in (!n3!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway3% metric 25 if %interface3%
goto ext
)

if "#%interface5%" == "#" (
echo ���Ŀ�������������ʼ���ؾ���...
set n1=1 5 9 13 17 21 25 29 33 37 41 45 49 53 57 61 65 69 73 77 81 85 89 93 97 101 105 109 113 117 121 125 129 133 137 141 145 149 153 157 161 165 173 177 181 185 189 193 197 201 205 209 213 217 221
set n2=2 6 14 18 22 26 30 34 38 42 46 50 54 58 62 66 70 74 78 82 86 90 94 98 102 106 110 114 118 122 126 130 134 138 142 146 150 154 158 162 166 170 174 178 182 186 190 194 198 202 206 210 214 218 222
set n3=3 7 11 15 19 23 27 31 35 39 43 47 51 55 59 63 67 71 75 79 83 87 91 95 99 103 107 111 115 119 123 131 135 139 143 147 151 155 159 163 167 171 175 179 183 187 191 195 199 203 207 211 215 219 223
set n4=4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 176 180 184 188 196 200 204 208 212 216 220
route delete 0.0.0.0
route add 0.0.0.0 mask 0.0.0.0 %gateway1% metric 30 if %interface1%
for %%i in (!n1!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway1% metric 25 if %interface1%
for %%i in (!n2!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway2% metric 25 if %interface2%
for %%i in (!n3!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway3% metric 25 if %interface3%
for %%i in (!n4!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway4% metric 25 if %interface4%
goto ext
)

if not "#%interface5%" == "#" (
echo �����������������ʼ���ؾ���...
set n1=1 6 11 16 21 26 31 36 41 46 51 56 61 66 71 76 81 86 91 96 101 106 111 116 121 126 131 136 141 146 151 156 161 166 171 176 181 186 191 196 201 206 211 216 221
set n2=2 7 12 17 22 27 32 37 42 47 52 57 62 67 72 77 82 87 92 97 102 107 112 117 122 132 137 142 147 152 157 162 167 177 182 187 197 202 207 212 217 222
set n3=3 8 13 18 23 28 33 38 43 48 53 58 63 68 73 78 83 88 93 98 103 108 113 118 123 128 133 138 143 148 153 158 163 168 173 178 183 188 193 198 203 208 213 218 223
set n4=4 9 14 19 24 29 34 39 44 49 54 59 64 69 74 79 84 89 94 99 104 109 114 119 124 129 134 139 144 149 154 159 164 174 179 184 189 194 199 204 209 214 219
set n5=5 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 165 170 175 180 185 190 195 200 205 210 215 220
route delete 0.0.0.0
route add 0.0.0.0 mask 0.0.0.0 %gateway1% metric 30 if %interface1%
for %%i in (!n1!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway1% metric 25 if %interface1%
for %%i in (!n2!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway2% metric 25 if %interface2%
for %%i in (!n3!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway3% metric 25 if %interface3%
for %%i in (!n4!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway4% metric 25 if %interface4%
for %%i in (!n5!) do route add %%i.0.0.0 mask 255.0.0.0 %gateway5% metric 25 if %interface5%
goto ext
)

if "#%interface6%" == "#" (
echo δ��������������Ҫ����������չ...
rem ��չ����������֧�֣�����Ҫ����ǰ���д��if�������伴�ɣ�����ͬ��
goto ext
)

if %o% geq 7 echo echo δ��������������Ҫ����������չ...

:ext
echo.
echo ���ؾ������!
echo.
pause