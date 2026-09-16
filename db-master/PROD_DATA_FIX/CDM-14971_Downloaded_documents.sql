/*
   Issue Description: CDM-14971
   Category/ Module  : Downloaded documents
   Root cause:The downloaded documents aharris.pdf, jhalliwell.pdf and a blank one all needs to be deleted. I am unable to delete and I was able to before
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update documentproperties set activeflag = 0, updatedby = 'CDM-14971', updatedon = now() where documentpropertiesid = 'fb75ac32-26af-415b-b953-d4455d69c592';

update documentattachment set activeflag = 0, updatedby = 'CDM-14971', updatedon = now() where documentpropertiesid = 'fb75ac32-26af-415b-b953-d4455d69c592';