/*
   Issue Description: I251013301845:Child is marked Substance Exposed Newborn and it is not populating in the SDM, unabel to send the intake for approval or to approve to open the needed service case. S
   Category/ Module  : Placement
   Root cause: User requestde to do a data fix to make the intake # I251013301845 as the source of SEN and 
   Substance exposed newborn checkbox is selected in the SDM
   Pull request# for code fix: 
   Reason why no related code fix: User error, no functional error.
   Status of the code fix if already submitted and expected prod fix date: 
*/
update person
set substanceexposednewbornsourceid = 'I251013301845',
    substanceexposednewbornsourcetypekey = '2954',  
	updatedby = 'CJAMS-60097', 
	updatedon = now()
where cjamspid = 204158911 
	and activeflag = 1;



 
