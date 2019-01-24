$BuildCounter= $Env:BUILD_BUILDNUMBER
$AssemblyInfoPattern = '\[assembly: AssemblyInformationalVersion\("(.*)"\)\]'
$AssemblyFiles = Get-ChildItem . AssemblyInfo.cs -rec

foreach ($file in $AssemblyFiles){
    (Get-Content $file.PSPath) | ForEach-Object{
        if($_ -match $AssemblyInfoPattern){
            $fileVersion = [version]$matches[1]
            # Write-Host "fileVersion '$_ '  "
            $newVersion = "{0}.{1}.{2}.{3}" -f $fileVersion.Major, $fileVersion.Minor, $fileVersion.Build, $BuildCounter 
            '[assembly: AssemblyInformationalVersion("{0}")]' -f $newVersion            
        }         
        else {
            # Output line as is
            $_
        }
    } | Set-Content $file.PSPath
}
 
