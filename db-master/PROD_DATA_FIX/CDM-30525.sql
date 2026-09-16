/*
   Issue Description: CDM-30525
   Category/ Module  :
   Root cause: user want to delete the intake and service case and Birth match flag for the child. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30525'
where objectid in ('I231010567658');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-30525',
    updatedon = now()
WHERE intakenumber in ('I231010567658');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-30525',
    updatedon = now()
WHERE intakenumber in ('I231010567658');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-30525'
WHERE intakenumber in ('I231010567658');



update servicecase set activeflag =0, updatedby = 'CDM-30525', updatedon = now() 
where servicecaseid in ('99ed4f4d-cfd2-4dc2-b552-4366e4d2640b');

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-30525', updatedon = now() 
where servicecaseid in ('99ed4f4d-cfd2-4dc2-b552-4366e4d2640b');

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-30525' 
where routingid in ('2e69f5be-813c-45a5-b30f-372efe220601');


 update personbirthmatch set activeflag=0,
 updatedby = 'CDM-30525', updatedon = now()
 where personbirthmatchid = '596b4407-145f-4ab5-8f28-fb4a36e61700';