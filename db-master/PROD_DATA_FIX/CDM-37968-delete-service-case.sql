/*
   Issue Description: CDM-37968 case open in error.
   Category/ Module  : Case Timeline
   Root cause: Service case # 231021120948 is not searchable but appear under the person (PID# 1295428) prior history case.
   Fix Provided: Data fix has been promoted to remove the service case from casemanagement, intakeservicerequest and routing tables
*/

select activeflag, * from caseassignment where objectid ='8b447b67-2593-4412-84e3-fca85b197562';

update caseassignment set activeflag =0, updatedby = 'CDM-37968', updatedon = now() 
where objectid ='8b447b67-2593-4412-84e3-fca85b197562';

select activeflag, * from intakeservicerequest i where intakeserviceid ='8b447b67-2593-4412-84e3-fca85b197562';

update intakeservicerequest set activeflag =0, updatedby = 'CDM-37968', updatedon = now() 
where intakeserviceid ='8b447b67-2593-4412-84e3-fca85b197562';

select activeflag , * from routing where objectid='8b447b67-2593-4412-84e3-fca85b197562';

update routing set activeflag =0, updatedby = 'CDM-37968', updatedon = now() 
where objectid ='8b447b67-2593-4412-84e3-fca85b197562';

