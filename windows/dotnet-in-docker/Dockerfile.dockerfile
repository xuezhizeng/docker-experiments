# escape=`
FROM microsoft/dotnet-framework:4.7.2-sdk

RUN Invoke-WebRequest -UseBasicParsing https://download.visualstudio.microsoft.com/download/pr/12210059/e64d79b40219aea618ce2fe10ebd5f0d/vs_BuildTools.exe -OutFile vs_BuildTools.exe; `
    # Installer won't detect DOTNET_SKIP_FIRST_TIME_EXPERIENCE if ENV is used, must use setx /M
    setx /M DOTNET_SKIP_FIRST_TIME_EXPERIENCE 1; `
    Start-Process vs_BuildTools.exe -ArgumentList '--add', 'Microsoft.VisualStudio.Workload.WebBuildTools', '--quiet', '--norestart', '--nocache' -NoNewWindow -Wait; `
    Remove-Item -Force vs_buildtools.exe; `
    Remove-Item -Force -Recurse \"${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\"; `
    Remove-Item -Force -Recurse ${Env:TEMP}\*; `
    Remove-Item -Force -Recurse \"${Env:ProgramData}\Package Cache\"; `
    Get-ChildItem -Directory \"${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\BuildTools\MSBuild\Microsoft\VisualStudio\v15.0\"
CMD powershell

