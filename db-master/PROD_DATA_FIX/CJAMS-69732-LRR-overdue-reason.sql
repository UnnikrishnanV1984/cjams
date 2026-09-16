/*
Issue Description: CJAMS-69732
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason to Case not assigned timely > supervisor delay
Fix provided: Data fix to update the over due reason as Case not assigned timely > supervisor delay
Reason why no related code fix: User error
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1='VCNT',
	cpsresponsetimerreason2='VSDT',
	updatedby='CJAMS-69732',
	updatedon=now()
where cpsresponsetimeractionsid='e81e4cf7-5a4c-476a-bfc8-5910cb0afa3b' and activeflag=1;

select * from cjams.cpsresponsetimerupdate('8faa11c7-5859-4f1c-8698-a453f461ad61'::uuid, 'CJAMS-69732'::character varying);