FROM microsoft/dotnet-framework:4.7.2-sdk AS build

WORKDIR /app
COPY WebApplication1/*.csproj ./
RUN nuget restore

# copy everything else and build app
COPY WebApplication1/. ./
WORKDIR /app/WebApplication1
RUN msbuild /p:Configuration=Release

# copy build artifacts into runtime image
FROM microsoft/aspnet:4.7.2 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/WebApplication1/. ./
