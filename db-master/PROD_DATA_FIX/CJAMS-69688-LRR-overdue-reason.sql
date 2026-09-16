/*
Issue Description: CJAMS-69688
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason to Alleged victim Unavailable > Attempted Face to Face > 1-2 Attempts Screen 
Fix provided: Data fix to update the over due reason as Alleged victim Unavailable > Attempted Face to Face > 1-2 Attempts Screen 
Reason why no related code fix: User error
*/


update cpsresponsetimeractions
set cpsresponsetimerreason1='CAVU', 
	cpsresponsetimerreason2='CAFF', 
	cpsresponsetimerreason3='C12F', 
	updatedby='CJAMS-69688', 
	updatedon=now()
where cpsresponsetimeractionsid='438c2402-82a1-40ef-8185-1b8a8e105f17' and activeflag=1;

select * from cjams.cpsresponsetimerupdate('5c5b9ab1-9c80-41e4-afe9-b6901e607f5f'::uuid, 'CJAMS-69688'::character varying);
