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
