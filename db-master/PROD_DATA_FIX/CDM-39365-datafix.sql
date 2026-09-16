/* 
    Issue Description: CDM-39365
  Category/ Module  : Persons
  Root cause: User error data fix to change the answer to Yes.
  Pull request# for code fix: 
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update personrole
set initialresponse = 1,
updatedon = now(),
updatedby = 'CDM-39365'
where personroleid = '5c2371e6-a476-4f8e-b933-0553cc484654'
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
-- select responsetimer, responsetimerdetails, updatedby, updatedon 
-- 	from intakeservicerequest 
-- where servicerequestnumber = '241022258743'
-- 	and activeflag = 1 ;


  select * 
from cjams.cpsresponsetimerupdate( '530c5cce-ae35-4e2f-893a-c23a662ce585'::uuid, 'CDM-39365'::character varying );

-- After
-- select responsetimer, responsetimerdetails, updatedby, updatedon 
-- 	from intakeservicerequest 
-- where servicerequestnumber = '241022258743'
-- 	and activeflag = 1;
