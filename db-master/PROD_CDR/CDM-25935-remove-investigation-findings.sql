/*
   Issue Description: CDM-25935
   Category/ Module  Investigation findings
   Root cause: User wants to remove the investigation findings
*/

update Investigationmaltreatmentactor 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-25935' 
where maltreatmentid in ('71eb8829-fb6e-4c30-a16a-aa046ff575fb', '425d8ebb-8281-4664-92da-e0c42b5342fe');

update Investigationmaltreatment 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-25935' 
where maltreatmentid in ('71eb8829-fb6e-4c30-a16a-aa046ff575fb', '425d8ebb-8281-4664-92da-e0c42b5342fe');
