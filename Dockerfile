FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /app
# Copy csproj and restore as distinct layers
COPY WebApplication1/*.csproj ./
RUN dotnet restore
RUN MSBuild.exe WebApplication1.csproj /T:Clean;Build;Package /p:Configuration=Release /p:OutputPath="obj\Release"

# Build runtime image
FROM microsoft/aspnet 
COPY ./obj/Release/_PublishedWebsites/WebApplication1_Package /inetpub/wwwroot
