/*
   Issue Description: CDM-44689
   Category/ Module  : Prod data fix to remove duplicate guardianship
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/






update guardianship set activeflag = 0, updatedby = 'CDM-44689', updatedon= now() where gapid in ('23f1c2e0-2783-4f65-8ced-c4b7778e7ae8',
'227e6198-9ab3-4dda-845c-611dc80bfd5b',
'653c2355-5ed6-45e2-ab3d-91fc768af75b',
'507e1154-3e9a-478c-9735-b7806c4507ef',
'89ff19c8-ab18-4a69-9bc5-ed7aa56e220b') and activeflag = 1;