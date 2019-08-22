FROM microsoft/aspnet 
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY WebApplication1/*.csproj ./
RUN dotnet restore
RUN MSBuild.exe WebApplication1.csproj /T:Clean;Build;Package /p:Configuration=Release /p:OutputPath="obj\Release"

# Build runtime image
COPY ./obj/Release/_PublishedWebsites/WebApplication1_Package /inetpub/wwwroot
