#aws sucks and doesnt have a ssm doccument for enabling ENA. simple powershell script to fix that. Run via systems manager.
#refer to this article. this covers step 2. https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/migrating-latest-types.html

#make temp dir
Remove-Item -path C:\enatemp\ –recurse -force
mkdir C:\enatemp\
#download install script
Invoke-WebRequest -Uri https://s3.amazonaws.com/ec2-windows-drivers-downloads/ENA/Latest/AwsEnaNetworkDriver.zip -OutFile C:\enatemp\AwsEnaNetworkDriver.zip

#extract install script
[System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null
[System.IO.Compression.ZipFile]::ExtractToDirectory('C:\enatemp\AwsEnaNetworkDriver.zip', 'C:\enatemp\AwsEnaNetworkDriver')

#run install script
powershell.exe -ExecutionPolicy Unrestricted C:\enatemp\AwsEnaNetworkDriver\install.ps1

# once this has installed, shut down the instance, run the following command from your local machine, and then change instance type :)
# aws ec2 modify-instance-attribute --instance-id instanceidhere --ena-support