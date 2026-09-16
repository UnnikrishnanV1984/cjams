/*
Issue Description: CDM-44190
   Category/ Module  : Data fix to remove the uploaded document
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update documentproperties
set activeflag = 0,
	updatedby = 'CDM-44190',
	updatedon = now()
where documentpropertiesid = '8ae20e27-846c-4c55-9cc2-6df48e52efdd'
	and activeflag = 1 ;
	
update documentattachment
set activeflag = 0,
	updatedby = 'CDM-44190',
	updatedon = now()
where documentpropertiesid = '8ae20e27-846c-4c55-9cc2-6df48e52efdd'
	and activeflag = 1 ;

