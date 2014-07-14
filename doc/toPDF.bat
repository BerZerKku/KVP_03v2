:: кодировка файла UTF-8 без BOM
@echo off
:: для русских букв в имени файла и пути к нему 
chcp 65001 

:: -----     ПЕРЕМЕННЫЕ     -----

:: запуск консольной версии приложения pdfsam
SET PDFSAM=java -Dlog4j.configuration=console-log4j.xml -jar %PDFSAM_CONSOLE%\pdfsam-console-2.4.1e.jar
:: ключи для запуска консольной версии приложения pdfsam
SET OPTIONS=-overwrite -compressed -pdfversion "5" concat
:: путь к общей папке документации
:: SET GLBPCKG="Z:\Текущие версии железа\Блоки АВАНТ"

:: копирование файлов
::goto COPY_TO_GLBPCKG

:: -----     СОЗДАНИЕ ФАЙЛОВ PDF     -----
:: || - следующая команда за этим знаком выполняется только если предыдущая завершилась с ошибкой
:: && - следующая команда за этим знаком выполняется только если предыдущая завершилась без ошибок

:: БВП Р400м, РЗСК
%PDFSAM% -l ".\files.xml" -o ".\Плата КВП KVP_03v2.pdf" %OPTIONS% || goto EXIT_ERROR
goto EXIT_NO_ERROR

:: -----     КОПИРОВАНИЕ В ОБЩУЮ ПАПКУ     -----
:COPY_TO_GLBPCKG

:: /I - копирование с созданием необходимых папок
:: /Y - замена существующих файлов без запроса
@echo.
@echo Copy ".\Documents\" to %GLBPCKG.
@echo.
xcopy ".\Documents" %GLBPCKG% /I /Y		|| goto EXIT_ERROR			
@echo.
@echo Copy "readme.txt" to %GLBPCKG.
@echo.
xcopy "readme.txt" %GLBPCKG% /Y			|| goto EXIT_ERROR

:: -----     ЗАВЕРШЕНИЕ РАБОТЫ     -----

:EXIT_NO_ERROR
:: Успешное завершение выполнения bat-файла
@echo.
echo !!! DONE !!!
@echo.
goto :EXIT

:EXIT_ERROR
:: В ходе выполнения bat-файла произошла ошибка
@echo. 
@echo !!! FAIL !!!
@echo.
CMD /Q /K
goto EXIT

:EXIT

