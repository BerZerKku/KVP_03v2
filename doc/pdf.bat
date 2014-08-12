:: кодировка файла UTF-8 без BOM
@echo off
:: для русских букв в имени файла и пути к нему 
chcp 65001 

:: -----     ПЕРЕМЕННЫЕ     -----

:: запуск консольной версии приложения pdfsam
SET PDFSAM=java -Dlog4j.configuration=console-log4j.xml -jar %PDFSAM_CONSOLE%\pdfsam-console-2.4.1e.jar
:: ключи для запуска консольной версии приложения pdfsam
SET OPTIONS=-overwrite -compressed -pdfversion "5" concat

:: -----     СОЗДАНИЕ ФАЙЛОВ PDF     -----
:: || - следующая команда за этим знаком выполняется только если предыдущая завершилась с ошибкой
:: && - следующая команда за этим знаком выполняется только если предыдущая завершилась без ошибок

:: БВП Р400м, РЗСК
%PDFSAM% -l ".\files.xml" -o ".\Плата КВП KVP_03v2.pdf" %OPTIONS% || goto EXIT_ERROR

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
PAUSE
goto EXIT

:EXIT

