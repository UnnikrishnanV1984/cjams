/*
  Issue Description:  CDM-39642
   Category/ Module  :  Application
   Root cause: user requested to uncheck SEN flag
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update person
set substanceexposednewbornflag = NULL,  -- 1
	substanceexposednewbornsourcetypekey = NULL, -- '2952'
	substanceexposednewbornsourceid = NULL, -- 'I241012426383'
	substanceexposednewborntimetamp = NULL, -- '2024-05-29 00:53:44.961'
	substanceclasses = NULL, -- '["BTNR"]'
--	othersubstances = NULL, -- NULL
	senstatusflag = NULL, -- 1
	updatedby = 'CDM-39642', 
	updatedon = now()
where cjamspid = 203187588
	and activeflag = 1;
  