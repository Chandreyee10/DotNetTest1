FROM microsoft/dotnet-framework-build:4.7.1 as build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY WebApplication1/*.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet-framework:4.7.1
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
