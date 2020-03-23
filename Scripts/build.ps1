Write-Output "`n#############################################"
Write-Output "## Starting Windows Build Script ##"
Write-Output "#############################################`n"

#Write-Output  "Configuraiton: $($config)"    
#Write-Output "MSBuild: $($MSBuildBase)"    

#Write-Output  "MsBuildPath:"  $(Get-Item MsBuildPath).Value
Write-Output  "Path:"  $(Get-Item Env:Path).Value
#Exit
# Write-Output "`n#############################################"
# Write-Output "## About to start msbuildstep ##"
# Write-Output "#############################################`n"
# if(-not(Get-Command "msbuild" -ErrorAction SilentlyContinue)){
#     Error "MSBuild must be set in your path. It is recommended to use MSBuild that comes with Visual Studio 2019.`n"
#     Exit
# }
# Write-Output "`n#############################################"
# Write-Output "## Passed msbuildstep ##"
# Write-Output "#############################################`n"

# if  (-not(Get-Command "fxc" -ErrorAction SilentlyContinue)){
#     Error "Direct X SDK is not installed. Please install it.`n"
#     Exit
# }
# Write-Output "`n#############################################"
# Write-Output "## Passed directx step##"
# Write-Output "#############################################`n"

# if  (-not(Get-Command "signtool" -ErrorAction SilentlyContinue)){
#     Error "Windows 10 dev kit is missing. Please install it.`n"
#     Exit
# }	
# Write-Output "`n#############################################"
# Write-Output "## signtool ##"
# Write-Output "#############################################`n"


#Write-Output "[Getting msbuild]"   
#$MSBuildBase = (Get-Command "msbuild").Definition 
#$Fxc = (Get-Command "fxc").Definition 
#Write-Output "[Getting signtool]"  
#$SignTool  = (Get-Command "signtool").Definition 


Write-Output "[Starting Build]"    

# & $Fxc /T ps_2_0 /E main /Fo"..\TunnelBear.UI.Effects\GrayscaleEffect\GrayscaleEffect.ps" "..\TunnelBear.UI.Effects\GrayscaleEffect\GrayscaleEffect.fx" 

# Tests
# & $MSBuildBase TunnelBear.UnitTest\TunnelBear.UnitTest.csproj /t:Rebuild /p:Configuration=$config /p:Platform=x86

# TunnelBear.Maintenance
# & $MSBuildBase TunnelBear.Maintenance.Console\TunnelBear.Maintenance.Console.vcxproj /t:Rebuild /p:Configuration=$config /p:Platform=x86 /p:OutputPath="..\Build\$config\" /p:OutDir="..\Build\$config\"
# & $MSBuildBase TunnelBear.Maintenance.Wrapper\TunnelBear.Maintenance.Wrapper.vcxproj /t:Rebuild /p:Configuration=$config /p:Platform=x86 /p:OutputPath="..\Build\$config\" /p:OutDir="..\Build\$config\"

# # TunnelBear.UI
# & $MSBuildBase TunnelBear.UI.Launcher\TunnelBear.UI.Launcher.vcxproj /t:Rebuild /p:Configuration=$config /p:Platform=x86 /p:OutputPath="..\Build\$config\" /p:OutDir="..\Build\$config\"
# & $MSBuildBase TunnelBear.UI.Console\TunnelBear.UI.Console.vcxproj /t:Rebuild /p:Configuration=$config /p:Platform=x86 /p:OutputPath="..\Build\$config\" /p:OutDir="..\Build\$config\"
# $version = ls Build\$config\TunnelBear.UI.exe -r | % versioninfo | % ProductVersion

# ((Get-Content TunnelBear.UI\Properties\AssemblyInfo.cs) `
# 	-replace "(\[assembly: AssemblyVersion(.*?)])", "[assembly: AssemblyVersion(""$version"")]" `
# 	-replace "(\[assembly: AssemblyFileVersion(.*?)])", "[assembly: AssemblyFileVersion(""$version"")]") `
# | Set-Content TunnelBear.UI\Properties\AssemblyInfo.cs

# ((Get-Content TunnelBear.Maintenance\Properties\AssemblyInfo.cs) `
# 	-replace "(\[assembly: AssemblyVersion(.*?)])", "[assembly: AssemblyVersion(""$version"")]" `
# 	-replace "(\[assembly: AssemblyFileVersion(.*?)])", "[assembly: AssemblyFileVersion(""$version"")]") `
# | Set-Content TunnelBear.Maintenance\Properties\AssemblyInfo.cs

# ((Get-Content TunnelBear.Bootstrapper.Actions\Properties\AssemblyInfo.cs) `
# 	-replace "(\[assembly: AssemblyVersion(.*?)])", "[assembly: AssemblyVersion(""$version"")]" `
# 	-replace "(\[assembly: AssemblyFileVersion(.*?)])", "[assembly: AssemblyFileVersion(""$version"")]") `
# | Set-Content TunnelBear.Bootstrapper.Actions\Properties\AssemblyInfo.cs

# & $MSBuildBase TunnelBear.UI.Wrapper\TunnelBear.UI.Wrapper.vcxproj /t:Rebuild /p:Configuration=$config /p:Platform=x86 /p:OutputPath="..\Build\$config\" /p:OutDir="..\Build\$config\"

# # Clean Output
# Remove-Item -path "Build\$config\*" -include *.lib, *.xml, *.json, *.pdb, *.metagen, *.ipdb, *.iobj, *.exp

# & $SignTool sign /sm /t http://timestamp.verisign.com/scripts/timstamp.dll  /n "TunnelBear" /sha1 "9F2452136EA3565E65236162C20DFD012728CA31" "Build\$config\TunnelBear.UI.exe" 
# & $SignTool sign /sm /t http://timestamp.verisign.com/scripts/timstamp.dll  /n "TunnelBear" /sha1 "9F2452136EA3565E65236162C20DFD012728CA31" "Build\$config\TunnelBear.exe" 
# & $SignTool sign /sm /t http://timestamp.verisign.com/scripts/timstamp.dll  /n "TunnelBear" /sha1 "9F2452136EA3565E65236162C20DFD012728CA31" "Build\$config\TunnelBear.Maintenance.exe"

# & $MSBuildBase TunnelBear.Bootstrapper.Actions\TunnelBear.Bootstrapper.Actions.csproj /t:Rebuild /p:Configuration=$config /p:Platform=x86
# & $MSBuildBase TunnelBear.Setup.Actions\TunnelBear.Setup.Actions.csproj /t:Rebuild /p:Configuration=$config /p:Platform=x86
Write-Output "`n#############################################"
Write-Output "## Starting Building... ##"
Write-Output "#############################################`n"

msbuild UnitTestProject1\UnitTestProject1.csproj 
msbuild WpfApp1\WpfApp1.csproj 

Write-Output "`n#############################################"
Write-Output "## Starting Signing.... ##"
Write-Output "#############################################`n"

#& $SignTool sign /sm /t http://timestamp.verisign.com/scripts/timstamp.dll  /n "Dana Woo" "WpfApp1\bin\Debug\WpfApp1.exe"

# & $SignTool sign /sm /t http://timestamp.verisign.com/scripts/timstamp.dll  /n "TunnelBear" /sha1 "9F2452136EA3565E65236162C20DFD012728CA31" "TunnelBear.Installer.UI\bin\x86\$config\TunnelBear.Installer.UI.exe"

# & $MSBuildBase TunnelBear.Setup\TunnelBear.Setup.wixproj /t:Rebuild /p:Configuration=Release /p:Platform=x86
# & $MSBuildBase TunnelBear.Bootstrapper\TunnelBear.Bootstrapper.wixproj /t:Rebuild /p:Configuration=$config /p:Platform=x86

Write-Output "[Build Finished]"    

# $branch = (git rev-parse --abbrev-ref HEAD).Split('/')[1]
# $output = ".\Output\$version\$branch"
# New-Item -Force -ItemType directory -Path $output

# Write-Output "[Copying installer]"
# Write-Output "cp TunnelBear.Bootstrapper\bin\$($config)\TunnelBear-Installer.exe $($output)"
# cp TunnelBear.Bootstrapper\bin\$config\TunnelBear-Installer.exe $output
# if (Test-Path AWS\update_windows_beta.xml) {
#     $xml = "AWS\update_windows_beta.xml"
# } else {
#     if ($version.StartsWith("4")){
#            $xml = "AWS\V4\update_windows.xml"
#     }
#     else{
#         $xml = "AWS\update_windows.xml"
#     }
    
# }
# $filename = ls $xml | % basename
# $xmlOutput = "$output\$filename.xml"
# $xmlContent = (Get-Content $xml).replace('[VERSION]', $version)
# New-Item $xmlOutput -type file -force -value "$xmlContent"