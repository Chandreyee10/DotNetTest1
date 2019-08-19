FROM microsoft/iis
RUN dism /online /enable-feature /all /featurename:iis-webserver /NoRestart
RUN mkdir c:\install
ADD WebDeploy_x86_en-US.msi /install/WebDeploy_x86_en-US.msi
WORKDIR /install
RUN powershell start-Process msiexec.exe -ArgumentList '/i c:\install\WebDeploy_x86_en-US.msi /qn' -Wait
RUN docker build -t windowsserveriisaspnetwebdeploy .
FROM windowsserveriisaspnetwebdeploy 
RUN mkdir c:\webapplication
WORKDIR /webapplication
ADD WebApplication1.zip&nbsp; /webapplication/WebApplication1.zip
ADD WebApplication1.deploy.cmd /webapplication/WebApplication1.deploy.cmd
ADD WebApplication1.SetParameters.xml /webapplication/WebApplication1.SetParameters.xmlRUN WebApplication1.deploy.cmd, /Y
RUN docker build -t mycontainerizedwebsite .
RUN docker run -p 80:80 mycontainerizedwebsite ping localhost -t