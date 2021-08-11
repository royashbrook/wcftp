function ftp_put($local_file_path, $remote_file_name, $ip, $path, $user, $pass){
    [alias("wcftp-put")]
    $cmd = "ftp://{0}{1}{2}" -f $ip, $path, $remote_file_name
    "Upload: {0} URI: {1}" -f $local_file_path, $cmd
    $uri = New-Object System.Uri($cmd)
    $wc = New-Object System.Net.WebClient
    $wc.Credentials = New-Object System.Net.NetworkCredential($user,$pass)  
    $wc.UploadFile($uri, $local_file_path)
    $wc.ResponseHeaders
    $wc.Dispose()
    $wc = $null
}
function df($f,$c){
    [alias("wcftp-get")]
    $req = [System.Net.FtpWebRequest]::Create((New-Object System.Uri($f)))
    $req.Credentials = $c
    $req.Method = [System.Net.WebRequestMethods+FTP]::DownloadFile
    try{
        $rs = $req.GetResponse().GetResponseStream()
        $sr = New-Object System.IO.StreamReader $rs
        do {$sr.ReadLine()} until ($sr.EndOfStream)
        [void]$sr.Dispose(); [void]$rs.Dispose()
    }
    catch{
        # return nothing
        #  using exceptions as control flow is a noted anti-pattern,
        #  but in this case it is the most expedient solution and
        #  robust enough to handle our limited use case here.
        #  it will save us making a list call to the server when
        #  we will only ever want the one file we are looking for.
    }
}
function rf($url,$c,$nurl){
    [alias("wcftp-ren")]
    $req = [System.Net.FtpWebRequest]::Create((New-Object System.Uri($url)))
    $req.Credentials = $c
    $req.Method = [System.Net.WebRequestMethods+FTP]::Rename
    $req.RenameTo = $nurl
    $rs = $req.GetResponse().GetResponseStream()
    $sr = New-Object System.IO.StreamReader $rs
    do {$sr.ReadLine()} until ($sr.EndOfStream)
    [void]$sr.Dispose(); [void]$rs.Dispose()
}