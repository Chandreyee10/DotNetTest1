FROM microsoft/dotnet:2.1-sdk AS build-env  
WORKDIR /app  
COPY WebApplication1/*.csproj ./  
COPY . ./  
RUN dotnet restore   
  
# STAGE02 - Publish the application  
FROM build-env AS publish  
RUN dotnet publish -c Release -o /app  
  
# STAGE03 - Create the final image  
FROM microsoft/dotnet:2.1-aspnetcore-runtime  
WORKDIR /app
COPY --from=publish /app .  
ENTRYPOINT ["dotnet", "WebApplication1.dll", "--server.urls", "http://*:80"]
