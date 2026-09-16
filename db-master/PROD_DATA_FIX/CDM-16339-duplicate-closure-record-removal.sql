/*
   Issue Description: CDM-16039
   Category/ Module  :  closure record duplicate
   Root cause: user error - user entered duplicate closure record
   Pull request# for code fix: 
   Reason why no related code fix: 
    user requested to remove duplicate closure record.
*/

update adoptioncasedisposition a 
set 
activeflag = 0,
updatedby = 'CDM-16339',
updatedon = now()
where 
adoptioncasedispositionid = '21d69ec5-77bb-49fd-8651-a316374589cd';