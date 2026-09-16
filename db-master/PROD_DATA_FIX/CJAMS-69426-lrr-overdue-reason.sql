/*
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason to Case not assigned timely > Supervisor delays
Fix provided: Data fix to update the over due reason as Case not assigned timely > Supervisor delays
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1='VCNT',
	cpsresponsetimerreason2='VSDT',
	cpsresponsetimerreason7='CCNT',
	cpsresponsetimerreason8='CSDT',
	updatedby='CJAMS-69426',
	updatedon=now()
where cpsresponsetimeractionsid='2c0fe082-9151-4704-98ab-e192a5d8ff0c' and activeflag=1;

select * from cjams.cpsresponsetimerupdate('c89c8bbc-6d9e-424d-9d07-daaba46cb196'::uuid, 'CJAMS-69426'::character varying);
