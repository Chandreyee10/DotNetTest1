# escape=`

FROM  mcr.microsoft.com/dotnet/core/aspnet:2.2 AS build
WORKDIR /src
COPY . NetFrameworkDemo/
RUN c:\Program Files\dotnet\dotnet  restore "NetFrameworkDemo/WebApplication1.csproj"
WORKDIR /src/NetFrameworkDemo
COPY . .
RUN c:\Program Files\dotnet\dotnet build "WebApplication1.csproj" -c Release -o \app

FROM build AS publish
RUN c:\Program Files\dotnet\dotnet  publish "WebApplication1.csproj" -c Release -o \publish

FROM base AS final
WORKDIR /inetpub/wwwroot
COPY --from=publish \publish .
