/*
 * CDM-32847 - HINDERING COMPLIANCE
 * Customer Email ID:devan.barker@maryland.gov
 * Dashboard:Answer to "was this child an active member of the household at the start of the case but left out of original referral" 
 * needs to be changed to "YES" IN ORDER TO MEET COMPLINCE. Child Layla MIncey (DOB: 8/23/22) 
 * Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/person-info-cw/profile
 * Data fix to change the answer to Yes for "was this child an active member of the household at the start of the case but left out of original referral" in case # 231020656752 (CJAMS ID# 201367055)
 */

--select initialresponse, updatedby, updatedon, * from personrole where personid = '10d36cd3-c4e2-4cc2-99e2-6e2a6b7dc087';

UPDATE cjams.personrole
SET initialresponse=1, updatedby='CDM-32847', updatedon=now() 
WHERE personroleid='acee9c80-5145-428a-b91a-0e92b6193c9d' and personid='10d36cd3-c4e2-4cc2-99e2-6e2a6b7dc087';

-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020656752'
	and activeflag = 1 ;

select * 
from cjams.cpsresponsetimerupdate('27d7a654-bcec-4bae-b06f-854566995ba5'::uuid, 'CDM-32847'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020656752'
	and activeflag = 1 ;