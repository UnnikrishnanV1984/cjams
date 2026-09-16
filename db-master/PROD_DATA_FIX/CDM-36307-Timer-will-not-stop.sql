/*
   Issue Description: CDM-36307
   Category/ Module  :  child welfare/ Person
   Root cause: This error occurred due to selected the option "No" instead of "Yes"
   Fix Provided: did data fix to updated the value to Yes  
*/

-- Backup
select * from personrole where personroleid='15ab2658-cf6f-4deb-b31c-1f18ebadf929' and intakeserviceid ='e5a35890-6370-43f1-ac7e-9818acaee90e';

-- Update
update personrole set initialresponse = '1',updatedby = 'CDM-36307', updatedon = now()  where personroleid='15ab2658-cf6f-4deb-b31c-1f18ebadf929' and intakeserviceid ='e5a35890-6370-43f1-ac7e-9818acaee90e';


-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021655142'
	and activeflag = 1 ;
	

select * 
from cjams.cpsresponsetimerupdate( 'e5a35890-6370-43f1-ac7e-9818acaee90e'::uuid, 'CDM-36307'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021655142'
	and activeflag = 1 ;