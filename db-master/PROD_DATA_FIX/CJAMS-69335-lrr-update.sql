/*
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason for all the 3 categories
Fix provided: Data fix to update the over due reason for all the 3 categories
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/


update cpsresponsetimeractions 
set cpsresponsetimerreason1 ='VEPC', cpsresponsetimerreason2 ='VNEC', cpsresponsetimerreason3 ='',
	cpsresponsetimerreason4 ='OEPC', cpsresponsetimerreason5 ='ONEC',
	cpsresponsetimerreason7 ='CEPC', cpsresponsetimerreason8 ='CNEC', cpsresponsetimerreason9 =''
where cpsresponsetimeractionsid ='70651df8-6b6c-44f0-bd73-4f4841fc694a' and intakeserviceid ='193218d4-efa5-4e98-83bb-9a4c413fdc0d' and activeflag =1;