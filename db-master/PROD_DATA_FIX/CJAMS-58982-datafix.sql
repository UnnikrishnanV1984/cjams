/*
   Issue Description: CJAMS-58982
   Category/ Module  : Placement
   Root cause: User requestde to do a data fix to make the intake # I251013262529 as the source of SEN and 
   Substance exposed newborn checkbox is selected in the SDM
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update person
set substanceexposednewbornsourceid = 'I251013262529',
    substanceexposednewbornsourcetypekey = '2954',  
	updatedby = 'CJAMS-58982', 
	updatedon = now()
where cjamspid = 204117689
	and activeflag = 1;