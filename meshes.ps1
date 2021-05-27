# Download and Decompress
function DownloadGitHubRepository { 
    Param ( 
       [Parameter(Mandatory=$True)] 
       [string] $Name, 
         
       [Parameter(Mandatory=$True)] 
       [string] $Author, 
         
       [Parameter(Mandatory=$False)] 
       [string] $Branch = "main",
         
       [Parameter(Mandatory=$True)] 
       [string] $Location,
         
       [Parameter(Mandatory=$True)] 
       [string] $ExtractLocation
    ) 
     
    # Force to create a zip file 
    $ZipFile = "$location\$Name.zip"
    New-Item $ZipFile -ItemType File -Force

    # Sets url
	#https://codeload.github.com/mmokitanoi/dungeonmeshes/zip/main
   # $RepositoryZipUrl = "https://api.github.com/repos/$Author/$Name/zipball/$Branch" 
   #/owner/name/releases/latest/download/asset-name.zip
    $RepositoryZipUrl = "https://github.com/mmokitanoi/dungeonmeshes/archive/refs/tags/dungeonmeshes.zip" 

    # Download the zip 
    Write-Host '== Starting downloading the GitHub Repository'
    Invoke-RestMethod -Uri $RepositoryZipUrl -OutFile $ZipFile
    Write-Host '== Download finished'
    Write-Host
    Write-Host "====================================================================="
    Write-Host
 
    # Extract Zip File
    Write-Host '== Starting unzipping the GitHub Repository locally'
    Expand-Archive -Path $ZipFile -DestinationPath "$ExtractLocation\$Name\" -Force
    Write-Host '== Unzip finished'
}


if (-not (Test-Path "git-repo.zip" -PathType Leaf)){
    DownloadGitHubRepository `
        -Name               dungeonmeshes `
        -Author             mmokitanoi `
        -Branch             main `
        -Location           $PSScriptRoot `
        -ExtractLocation    $PSScriptRoot `
}