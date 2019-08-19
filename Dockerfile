# escape=`

FROM  mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS build
WORKDIR /src
RUN cp  ["WebApplication1\WebApplication1.csproj", "WebApplication1/"]
RUN dotnet restore "WebApplication1/WebApplication1.csproj"
WORKDIR "/src/WebApplication1"
COPY . .
RUN dotnet build "WebApplication1.csproj" -c Release -o \app

FROM build AS publish
RUN dotnet publish "WebApplication1.csproj" -c Release -o \publish

FROM base AS final
WORKDIR /inetpub/wwwroot
COPY --from=publish \publish .
