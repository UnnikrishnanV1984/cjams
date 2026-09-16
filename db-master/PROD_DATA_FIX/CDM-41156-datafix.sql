/*
  Issue Description:CDM-41156
Category/ Module:Application
Root cause: User requested to remove case from SEN flag
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/


update person
set substanceexposednewbornflag = NULL,  -- 1
	substanceexposednewbornsourcetypekey = NULL, -- '2954'
	substanceexposednewbornsourceid = NULL, -- 'I241012892142'
	substanceexposednewborntimetamp = NULL, -- '2024-07-30 17:21:12.882'
	substanceclasses = NULL, -- '["BCOC"]'
--	othersubstances = NULL, -- NULL
	senstatusflag = NULL, -- 1
	updatedby = 'CDM-41156', 
	updatedon = now()
where cjamspid = 203711643
	and activeflag = 1;


