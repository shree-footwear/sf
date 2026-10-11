@echo off
setlocal

REM Get the script directory
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

echo ===================================================
echo      Starting Tally Stock App (SF Srikakulam)
echo ===================================================

echo.
echo [1/4] Checking for updates...
call git pull
if %ERRORLEVEL% NEQ 0 (
    echo Warning: Git pull failed or not a git repository. Continuing...
)

echo.
echo [2/4] Checking Backend...
if not exist "backend\node_modules" (
    echo Installing backend dependencies...
    cd backend
    call npm install
    cd ..
)

echo Starting Backend Server...
start "SF Backend (Port 3000)" cmd /k "cd /d "%SCRIPT_DIR%backend" && npm start"

echo.
echo [3/4] Checking Frontend...
if not exist "frontend\node_modules" (
    echo Installing frontend dependencies...
    cd frontend
    call npm install
    cd ..
)

echo.
echo [4/4] Starting Frontend Dev Server...
start "SF Frontend" cmd /k "cd /d "%SCRIPT_DIR%frontend" && npm run dev"

echo.
echo ===================================================
echo      App started!
echo      Backend: http://localhost:3000
echo      Frontend: Check the Vite terminal
echo ===================================================
echo.
