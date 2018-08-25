$Location = "C:\stage\src\sandbox\TEA.Web\src\TEA.Web.DataAccess\"

Set-Location $Location

$OutputDir = "$Location\Models"
$ContextDir = "$Location\Context"
$Provider = "Microsoft.EntityFrameworkCore.SqlServer"
#$Connection = "Data Source=teks-api.com;Initial Catalog=TEKS-API;User Id=sa;Password=Magicc12;MultipleActiveResultSets=True"
$Connection = "Data Source=BACKTRACK;Initial Catalog=texesdb;Integrated Security=True;Pooling=False;Connect Timeout=30"

$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Continue

Get-ChildItem -Path $OutputDir | Remove-Item -Force -Verbose
Get-ChildItem -Path $ContextDir | Remove-Item -Force -Verbose


#Scaffold-DbContext -Connection $Connection -Provider $Provider -OutputDir $OutputDir -ContextDir $ContextDir -StartupProject TEA.Web.Utilities -Verbose

dotnet ef dbcontext scaffold "$Connection" "$Provider" -o "$OutputDir" --context-dir "$ContextDir" -c "TExESDbContext" --force

$Files = Get-ChildItem -Path $OutputDir -Filter '*.cs'
$Files += Get-ChildItem -Path $ContextDir -filter '*.cs' 

$Files | ForEach-Object -Process {
    $F = $_

    $Content = Get-Content -Path $F.FullName
    $Content = $Content.Replace('TblCf','')
    $Content = $Content.Replace("Cf", "CF")
    Set-Content -Path $F.FullName -Value $Content -Force -Verbose

    $NewName = $F.BaseName.Replace('TblCf','');

    Rename-Item -Path $F.FullName -NewName "$NewName.cs" -Verbose

}

#Get-ChildItem -Filter *.cs | Move-Item -Destination .\Models -Force -Verbose