rem @echo off
rem title ������־���� ����ʱ��:%CurDate%

rem ======================================================================
rem STEP1 start:��ȡϵͳִ�и������ʱ��                                 =
rem ======================================================================
echo ��ȡϵͳʱ��
set CurYear=%Date:~0,4%

set CurMonth=%Date:~5,2%
if %CurMonth% LSS 10 set CurMonth=0%Date:~6,1%

set CurDay=%Date:~8,2%
if %CurDay% LSS 10 set CurDay=0%Date:~9,1%

set Curhore=%time:~0,2%
if %Curhore% LSS 10 set Curhore=0%time:~1,1%

set Curminute=%time:~3,2%
if %Curminute% LSS 10 set Curminute=0%time:~4,1%

set Cursecond=%time:~6,2%
if %Cursecond% LSS 10 set Cursecond=0%time:~7,1%

set CurDate=%CurYear%%CurMonth%%CurDay%_%Curhore%%Curminute%%Cursecond%


rem ===================================================
rem STEP2 start:������������                          =
rem STEP2.1:Դ�ļ�·��                                =
rem STEP2.2:ѹ��·��                                  =
rem STEP2.3:rar�����������                           =
rem STEP2.4:��ȡ���豸���ļ������ڣ�����15�ţ�        =
rem ===================================================
set FilePath=C:\Users\Administrator\Desktop\�½��ļ���

set BackPath=C:\Log_M_B2EC%CurDate%.rar

set Path=%Path%;"C:\Program Files\WinRAR"

if %CurMonth% LSS 10 (set /a LastMonth=%Date:~6,1%-1)
if not %CurMonth% LSS 10 (set /a LastMonth=%Date:~5,2%-1)


rem ���ñ�������:����EQU;������NEQ;����LSS;���ڵ���LEQ;����GTR;���ڵ���GEQ.
rem case1:��ǰ�·�Ϊ1��,��ѹ��ȥ��12��ǰ���ļ�;
rem case2:��ǰ�·�Ϊ2-9�·�,��ѹ����������ǰ���ļ�,�·�ǰ����0;
rem case3:��ǰ�·�Ϊ10-12�·�,��ѹ���������µ��ļ�,�·�ǰ���ò���0.
echo �����·�Ϊ:%LastMonth%
if %LastMonth% LSS 10 if %LastMonth% GEQ 1 (set LastMonth_Temp=0%LastMonth% & set /a LastYear=%CurYear%)

if %LastMonth% LSS 1 (set LastMonth_Temp=12 & set /a LastYear=%CurYear%-1)

if %LastMonth% LEQ 12 if %LastMonth% GEQ 10 (set /a LastMonth_Temp=%LastMonth% & set /a LastYear=%CurYear%)

set LastMonth=%LastMonth_Temp%

rem ȥ��LastMonth�����еĿո�
set "LastMonth=%LastMonth: =%"

set BakUpDate=%LastYear%-%LastMonth%-15


rem ===================================================
rem STEP3 start:�л���Դ�ļ�·��(ȥ��)                =
rem ===================================================
rem C:
rem cd %FilePath%

rem ================================================================================================
rem STEP4 start:��ʼѹ��                                                                           =
rem "C:\Program Files\WinRAR\Rar.exe" a -r %BackPath% *.log(����STEP3����)                         =
rem forfiles /p %FilePath% /m *.log /d -1 /c "cmd /c rar a %BackPath% @path"                       =
rem ================================================================================================
echo ��ʼѹ��������־������Դ�ļ�·����%FilePath%������Ŀ��·����%BackPath%���������ڣ�%BakUpDate%

rem a:����ļ���ѹ���ĵ� -r:�ݹ���Ŀ¼ -tb:����YYYY-MM-DD֮ǰ�޸Ĺ����ļ� -ep1:���������ų���Ŀ¼
rar a -r -tb%BakUpDate% -ep1 "%BackPath%" "%FilePath%\*.log"

echo ����ѹ��������־

rem ============================================================================
rem STEP5 start:������ѹ����Դ�ļ�(ȥ��)                                       =
rem ============================================================================
rem echo ��ʼ���������־Դ�ļ�

rem del %FilePath%\*.log
rem forfiles /p %FilePath% /m *.log /d -1 /c "cmd /c del /f /q /a @path"

rem echo �������������־

rem ===================================================
rem STEP6 END                                         =
rem ===================================================

pause
