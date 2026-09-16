/*
 * CDM-37632 - Disclosure Checklist
 * user role issue
 * Customer Email ID:reginal.bowers@maryland.gov
 * Description - 221030014349:The disclosure checklist is submitted to supervisor for approval and system indicates it was submitted successfully.
 * Supervisor approves on her end and the system indicates it was approved successfully.When I check on my end there is no approval or the system 
 * is asking me to submit to supervisor for approval again. We have conducted this process about five times with no approval obtained. 
 * 
 */

select roletypekey, teammemberid, * from v_userprofile where securityusersid = 'eb143b37-3c52-44ce-80a4-a14950c7a6f5';

-- Update roletypekey = CWCW (Old Values: KINSHIPUP)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = 'ffbc42fc-d636-419a-aa61-7ba6695ab0bf'
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'CWCW',
	updatedon = now(),
	updatedby = 'CDM-37632'
where teammemberid = 'ffbc42fc-d636-419a-aa61-7ba6695ab0bf'
	and activeflag  = 1 ;
