if (!require("pacman")) install.packages("pacman")
pacman::p_load(here)

save_SharePoint <- function(fileName)
{
   cmd <-
      paste(
         "curl --max-time 7200 --connect-timeout 7200 --ntlm --user",
         "username:password",
         "--upload-file",
         fileName,
         "usqprd.sharepoint.com/sites/USQ1903-003RTX2/Shared Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2FUSQ1903-003RTX2%2FShared Documents%2FDispersal Paper&FolderCTID=0x01200043735422C44AAB4385699BE239E28DF0",
         fileName,
         sep = " "
      )
   system(cmd)
}

save_SharePoint("SomeFileName.Ext")
