
/*
   Issue Description: CDM-21618
   Category/ Module  : Prod data fix for updating Guardian Relation ship
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update guardianship set primaryrelationshipkey = 'MTNLAT', secondaryrelationshipkey = 'MATNLUE', updatedby = 'CDM-21404', updatedon = now() 
where gapid = '91f9cce4-aa06-43e9-a15e-c6a6c8db7bd1';