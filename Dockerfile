# escape=`

FROM  mcr.microsoft.com/dotnet/core/aspnet:2.2 AS build
WORKDIR /src
COPY . WebApplication1/

RUN C:\dotnet\dotnet.exe  restore "WebApplication1/WebApplication1.csproj"
WORKDIR /src/WebApplication1
COPY . .
RUN "C:\dotnet\dotnet" build "WebApplication1.csproj" -c Release -o \app

FROM build AS publish
RUN "C:\dotnet\dotnet"  publish "WebApplication1.csproj" -c Release -o \publish

FROM base AS final
WORKDIR /inetpub/wwwroot
COPY --from=publish \publish .
