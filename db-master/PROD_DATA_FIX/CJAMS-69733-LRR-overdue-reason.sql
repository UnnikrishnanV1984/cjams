/*
Issue Description: CJAMS-69733
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason to Case not assigned timely > supervisor delay
Fix provided: Data fix to update the over due reason as Case not assigned timely > supervisor delay
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1='VCNT', 
	cpsresponsetimerreason2='VSDT',
	cpsresponsetimerreason4='OCNT',
	cpsresponsetimerreason5='OSDT',
	cpsresponsetimerreason7='CCNT',
	cpsresponsetimerreason8='CSDT',
	updatedby='CJAMS-69733', 
	updatedon=now()
where cpsresponsetimeractionsid='a426cfba-beec-41a5-b7d5-03d8c80a5d42' and activeflag=1;

select * from cjams.cpsresponsetimerupdate('4a4cfe67-2e14-4042-8d67-d01753c82966'::uuid, 'CJAMS-69733'::character varying);