
/*
   Issue Description: CDM-21380
   Category/ Module  : Unable to end date adoption reunification
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- null null
update permanencyplan p set parentname = '00000000-0000-0000-0000-000000000000' ,updatedby = 'CDM-21380', updatedon = now() 
where permanencyplanid = 'd1754b86-1a43-461f-9b78-0bb693b9fa78';