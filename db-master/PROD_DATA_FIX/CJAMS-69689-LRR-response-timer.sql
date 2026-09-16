/*
Issue Description: CJAMS-69689
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason to  Alleged victim Unavailable > Attempted Face to Face > 1-2 Attempts Screen 
Fix provided: Data fix to update the over due reason as  Alleged victim Unavailable > Attempted Face to Face > 1-2 Attempts Screen 
Reason why no related code fix: User error
*/


update cpsresponsetimeractions
set cpsresponsetimerreason1='VAVU', 
	cpsresponsetimerreason2='VAFF', 
	cpsresponsetimerreason3='V12F', 
	updatedby='CJAMS-69689', 
	updatedon=now()
where cpsresponsetimeractionsid='190c2aae-7cf2-4ca3-a2e5-84ac9664af82' and activeflag=1;

select * from cjams.cpsresponsetimerupdate('c5ea81bd-a1d2-4aa4-8004-c80561bca8c0'::uuid, 'CJAMS-69689'::character varying);