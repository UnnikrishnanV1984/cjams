/*
  Issue Description: CDM-39362
  Root cause: Timer not turning off
  Fix provided : 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

UPDATE cjams.personrole
SET initialresponse=1, updatedby='CDM-39362', updatedon=now()
WHERE personroleid='f3275659-9c70-4326-a33e-fa34f529241d'
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
-- select responsetimer, responsetimerdetails, updatedby, updatedon 
-- 	from intakeservicerequest 
-- where servicerequestnumber = '241021940791'
-- 	and activeflag = 1 ;


select * 
from cjams.cpsresponsetimerupdate( '3feef547-d271-4266-877c-bb3ef1ae1c76'::uuid, 'CDM-39362'::character varying );
		
-- After
-- select responsetimer, responsetimerdetails, updatedby, updatedon 
-- 	from intakeservicerequest 
-- where servicerequestnumber = '241021940791'
-- 	and activeflag = 1;