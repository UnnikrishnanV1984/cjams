/*
   Issue Description: CDM-40061 Update the source of SEN for client ID # 203378446 as intake # I241012599139, Currently in CJAMS the source for the SEN is intake # I241012596122 
   Category/ Module  : Persons
   Root cause: Data fix to update the source of SEN for client ID # 203378446 as intake # I241012599139, Currently in CJAMS the source for the SEN is intake # I241012596122
   Fix provided : Data fix has been provided  to update SEN source for client ID # 203378446 as intake # I241012599139 from # I241012596122
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete:
*/

update person
set substanceexposednewbornsourceid = 'I241012599139',
    substanceexposednewbornsourcetypekey = '2954',  
	updatedby = 'CDM-40061', 
	updatedon = now()
where cjamspid = 203378446
	and activeflag = 1;