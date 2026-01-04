Write-Host ""
Write-Host "What would you like to do?"
Write-Host ""
Write-Host "       A) Collect new Baseline?"
Write-Host "       B) Begin monitoring files with saved Baseline?"
Write-Host ""
$response = Read-Host -Prompt "Please enter 'A' or 'B'"
Write-Host ""
Write-Host "User entered $($response)"

Function Calculate-File-Hash($filepath) {
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $filehash

}

Function Erase-Baseline-If-Already-Exists() {
    $baselineExists = Test-Path -Path .\baseline.txt
    if ($baselineExists){
    Remove-Item -Path .\baseline.txt
    }


}


if ($response -eq "A".ToUpper()){
    # Delete baseline.txt if it already exists
    Erase-Baseline-If-Already-Exists
    

    # Calculate Hash from target files and store in baseline.txt

    # Collect all the files in the target folder
    $files = Get-ChildItem -Path .\Files
    

  

    # For the file, calculate the hash, and write to baseline.txt
    foreach ($f in $files) {
    $hash = Calculate-File-Hash $f.FullName
    "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append
    }
}

elseif ($response -eq "B".ToUpper()){
    
    $fileHashDictionary = @{}
    # Load file|hash from baseline.txt and store them in dictionary 
    $filePathesAndHashes = Get-Content -Path .\baseline.txt
    
    foreach($f in $filePathesAndHashes){
          $fileHashDictionary.add($f.Split("|")[0],$f.Split("|")[1])
    }

    $fileHashDictionary
    
    # Begin (contiously) monitoring files with saved Baseline
    while ($true) {
        Start-Sleep -Seconds 1
        
        $files = Get-ChildItem -Path .\Files
        # For the file, calculate the hash, and write to baseline.txt
        foreach ($f in $files) {
        $hash = Calculate-File-Hash $f.FullName
        #"$($hash.Path)|$($hash.Hash)" | Out-File -FilePath .\baseline.txt -Append

        # Notify if new file has been created
        if ($fileHashDictionary[$hash.Path] -eq $null){
            # A file has been created which is new!
            Write-Host "$($hash.Path) has been created!" -ForegroundColor Green
        }
        else {
            # Notify if a new file has been changed
            if ($fileHashDictionary[$hash.Path] -eq $hash.Hash) {
                # The file has not changed
            }
            else {
                 # The file has been comprimised!, notify the user
                Write-Host "$($hash.Path) has been comprimised!!!" -ForegroundColor Red

            }

        }

        

        
    }
        
        foreach ($key in $fileHashDictionary.Keys) {
            $baselineFileStillExists = Test-Path -Path $key
            if (-Not $baselineFileStillExists){
                # One of the baseline files must have been deleted, notify the user
                Write-Host "$($key) was deleted!" -ForegroundColor DarkRed -BackgroundColor DarkGray
            
            }
        }
        

   }
}
