@echo off
cd /d E:\inet4031-lab7

echo Fetching latest changes...
git fetch origin main

FOR /F "tokens=*" %%i IN ('git rev-parse HEAD') DO SET LOCAL_REV=%%i
FOR /F "tokens=*" %%i IN ('git rev-parse origin/main') DO SET REMOTE_REV=%%i

if "%LOCAL_REV%" neq "%REMOTE_REV%" (
    echo New changes detected. Pulling and deploying...
    git pull origin main
    docker compose up -d --build
    echo Deployment completed successfully at %DATE% %TIME% >> E:\inet4031-lab7\deploy.log
) else (
    echo Already up-to-date.
)
