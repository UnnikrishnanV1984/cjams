/*
   Issue Description: CDM-28800
   Category/ Module  :  Investigation Findings
   Root cause: user wants to remove duplicates in Findings
   Pull request# for data fix: 8009
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
update Investigationmaltreatment 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-28800' 
where maltreatmentid in ('92ac3837-34d9-48da-a0ff-36d3da4b0c30', '4c131f5a-e955-4e57-8a1f-4bd51132194d', 
'4e4d3349-d353-4701-a875-d79e4979ecd7', '42dae2d8-261b-4db3-8c6a-446a72436038');
