## Build and Publish Web App
FROM microsoft/dotnet-framework-build:4.7.1 as build-env 
WORKDIR /src
COPY ["C:\Users\Administrator\source\repos\WebApplication1\WebApplication1\WebApplication1.csproj", "SampleWebAppForIIS/"]
RUN dotnet restore "SampleWebAppForIIS/WebApplication1.csproj"
COPY . .
WORKDIR "/src/SampleWebAppForIIS"
RUN dotnet build "WebApplication1.csproj" --no-restore --no-dependencies -c Release -o /app 
FROM build AS publish
RUN dotnet publish "WebApplication1.csproj" -c Release -o /publish
FROM base AS final
WORKDIR /inetpub/wwwroot/samplewebapp
## Create Web Site and Web Application
RUN Import-Module WebAdministration; 
##`
    ##Remove-Website -Name 'Default Web Site'; `
    ##New-WebAppPool -Name 'ap-samplewebapp'; `
    ##Set-ItemProperty IIS:\AppPools\ap-samplewebapp -Name managedRuntimeVersion -Value ''; `
    ##Set-ItemProperty IIS:\AppPools\ap-samplewebapp -Name enable32BitAppOnWin64 -Value 0; `
    ##Set-ItemProperty IIS:\AppPools\ap-samplewebapp -Name processModel.identityType -Value Service; 
    New-Website -Name 'samplewebapp' 
                -Port 80 -PhysicalPath 'C:\inetpub\wwwroot\samplewebapp' 
                ##-ApplicationPool 'ap-samplewebapp' -force
COPY --from=publish /publish .
EXPOSE 80