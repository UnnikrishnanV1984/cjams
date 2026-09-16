/*
   Issue Description: CDM-29065
   Category/ Module  : Investigation findings missing after case closed
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/

UPDATE cjams.investigationfinding
SET activeflag=1, updatedby='CDM-29065', updatedon=now()
WHERE investigationfindingid in ('44ae29ce-27ab-45eb-8f0c-2b6a504be166','b0bca7d1-49e0-45e3-bd4b-4bc1fd41ea3b');

