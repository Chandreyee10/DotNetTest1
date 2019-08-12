FROM microsoft/dotnet-framework-build:4.7.1 as build-env

WORKDIR /app
COPY . /app
RUN nuget.exe restore WebApplication1.csproj 
RUN MSBuild.exe WebApplication1.csproj /T:Clean;Build;Package /p:Configuration=Release /p:OutputPath="obj\Release"


FROM microsoft/dotnet-framework:4.7.1
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "WebApplication1.dll"]