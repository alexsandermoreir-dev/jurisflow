@echo off
chcp 65001 >nul
title JurisFlow Backend

echo.
echo  ============================================
echo   JurisFlow — Iniciando backend...
echo  ============================================
echo.

:: Verifica se Node.js está instalado
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo  [AVISO] Node.js nao encontrado!
    echo.
    echo  Instale com este comando no PowerShell ^(cole e pressione Enter^):
    echo.
    echo     winget install OpenJS.NodeJS.LTS
    echo.
    echo  Depois de instalar, feche e reabra este arquivo.
    echo.
    pause
    exit /b
)

:: Entra na pasta do backend
cd /d "%~dp0backend"

:: Instala dependencias se necessario
if not exist node_modules (
    echo  Instalando dependencias pela primeira vez ^(pode demorar 1-2 min^)...
    npm install --silent
    echo  Dependencias instaladas!
    echo.
)

:: Inicia o servidor em segundo plano (nova janela)
echo  Iniciando servidor...
start "JurisFlow — Servidor (nao feche esta janela)" cmd /k "node server/app.js"

:: Aguarda o servidor inicializar
echo  Aguardando servidor inicializar...
timeout /t 2 /nobreak > nul

:: Abre o sistema no navegador
echo  Abrindo JurisFlow no navegador...
start "" http://localhost:3000

echo.
echo  ============================================
echo   JurisFlow aberto em http://localhost:3000
echo   IMPORTANTE: nao feche a janela do servidor!
echo  ============================================
echo.
echo  Esta janela pode ser fechada agora.
echo  Para encerrar o servidor, feche a outra janela.
echo.
pause
