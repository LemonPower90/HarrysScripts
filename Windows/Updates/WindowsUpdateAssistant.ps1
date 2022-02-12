if(!(Test-Path "C:\temp")){
    mkdir "c:\temp"
}

Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?LinkID=799445" -OutFile "C:\temp\updateassistant.exe"

c:\temp\updateassistant.exe /quietinstall /skipeula /auto upgrade