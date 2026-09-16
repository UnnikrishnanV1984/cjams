/*
 * CDM-35467 - CJAMS- correction
 * Customer Email ID:mollie.shrader@maryland.gov
 * Customer Name:Mollie Shrader
 * Focus Area:Persons: Household
 * Update Was this child an active member of the household at the start of the case but not included on the referral?  to Yes
 * 
 */

--SELECT prole.dangertoself,prole.isdangertoworker,prole.initialresponse,*
--				from personrole as prole WHERE activeflag=1 
--				AND  prole.personid in ('16c55923-e19d-4721-9a84-01a231c27bfc','f8c5c61d-c5be-4bec-bb41-51d7b3c06138');
			
-- intakeserviceid = 10db13f4-822f-4681-bb7d-047ebd436804
--select * from intakeservicerequest where intakeserviceid = '10db13f4-822f-4681-bb7d-047ebd436804';	-- 231021342799
					
UPDATE cjams.personrole
SET initialresponse=1, updatedby='CDM-35467', updatedon=now() 
WHERE personroleid in ('7baa09cf-6e56-4af1-906b-fd0ad8cf1949'::uuid, 'aa301533-bd69-4b2c-9397-7aced63aa74e'::uuid);

-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021342799'
	and activeflag = 1 ;

select * from cjams.cpsresponsetimerupdate( '10db13f4-822f-4681-bb7d-047ebd436804'::uuid, 'CDM-35467'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021342799'
	and activeflag = 1 ;
    