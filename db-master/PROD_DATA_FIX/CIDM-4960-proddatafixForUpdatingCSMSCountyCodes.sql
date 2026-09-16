/*
   Issue Description: CIDM-4960
   Category/ Module  : Prod data fix to Update CSMS County Code
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update ivecsescountycodes set countycode = '30', updatedby = 'CIDM-4960', updatedon = now() where fipscode = '24510';