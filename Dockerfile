##FROM microsoft/dotnet-framework-build:4.7.1 as build-env
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY WebApplication1/*.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
##FROM microsoft/dotnet-framework:4.7.1
FROM mcr.microsoft.com/windows/servercore:1809
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]

