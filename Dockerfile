FROM microsoft/iis as base

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /app
COPY WebApplication1/*.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet build "WebApplication1.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "WebApplication1.csproj" -c Release -o /publish

FROM base AS final
WORKDIR /inetpub/wwwroot
COPY --from=publish /publish .
