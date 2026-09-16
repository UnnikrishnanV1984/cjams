/*
Issue Description: CPS IR# 251023119927 was closed on 10/03/2025 and user accidentally uploaded incorrect document into the CPS IR case.
Root cause:User Error, uploaded incorrect document into the CPS IR case.
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry issue.
*/

update documentproperties
set activeflag = 0,
	updatedby = 'CJAMS-62737',
	updatedon = now()
where documentpropertiesid ='e801c9ea-cec5-4434-bd73-7d8c5d2de704'
 	  and activeflag = 1 ;
 	  
update documentattachment
set activeflag = 0,
	updatedby = 'CJAMS-62737',
	updatedon = now()
where documentpropertiesid = 'e801c9ea-cec5-4434-bd73-7d8c5d2de704'
 	  and activeflag = 1 ;