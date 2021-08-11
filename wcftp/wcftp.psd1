@{
    RootModule = 'wcftp.psm1'
    ModuleVersion = '1.0.0.0'
    GUID = '83fe0af5-76f2-4363-ab82-b9b7a844f3ae'
    Author = 'Roy Ashbrook'
    CompanyName = 'ashbrook.io'
    Copyright = '(c) 2021 royashbrook. All rights reserved.'
    Description = 'Basic FTP operations using dotnet webclient class.'
    FunctionsToExport = @("ftp_put","df","rf")
    AliasesToExport = @("wcftp-put","wcftp-get","wcftp-ren")
    CmdletsToExport = @()
    VariablesToExport = @()
}
