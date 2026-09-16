
update caseassignment set objectid = 'f843a51c-f993-45ef-8828-4b6d464f782a', updatedon =now(), updatedby ='CDM-11567'where caseassignmentid ='e23f8237-51a8-4252-9044-b66e71ea55da';
update intakeservicerequest set activeflag =0,  servicerequestnumber = '202109507011', updatedon =now(), updatedby ='CDM-11567'where intakeserviceid ='b441d9db-f165-4a8f-9e6f-1afbf9767498' and servicecaseid = 'f843a51c-f993-45ef-8828-4b6d464f782a';

update personprogramarea 
set
activeflag = 0,
updatedby = 'CDM-11567',
updatedon = now()
where 
personprogramid in ('0ae8afdd-440b-4e49-85a3-885660384d2e', 'ef74b726-91f3-43a2-8ec9-5e593ef1f0bb','8ea285d7-d6e4-4a30-8151-6d4fa53877f4');