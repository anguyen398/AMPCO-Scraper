@echo off
echo Checking if Python is installed...

where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python is not installed. Downloading and installing Python...
    powershell -Command "& {Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.9.13/python-3.9.13-amd64.exe' -OutFile 'python-installer.exe'}"
    start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
    del python-installer.exe
) else (
    echo Python is already installed.
)

echo Ensuring Python and Pip are in PATH...
setx PATH "%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python313\Scripts\"
setx PATH "%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python313\"

echo Upgrading pip...
python -m ensurepip --default-pip
python -m pip install --upgrade pip

echo Installing required Python packages...
pip install --upgrade streamlit scrapy pandas torch transformers bardapi scrapy-exporters urllib3

echo Verifying Bard API installation...
python -m pip show bardapi || python -m pip install bardapi

echo Running the Scraper UI...
python -m streamlit run app.py

pause
