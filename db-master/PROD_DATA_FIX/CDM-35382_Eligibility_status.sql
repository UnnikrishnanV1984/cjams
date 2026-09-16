-- CDM-35382 - Eligibility results not appearing
/* Issue Description:Eligibility results not appearing after determination request is made.

-- Client ID: 200888090
-- Removal Id: 253772

-- Category/ Module: Title IV-E 

-- Root cause: User not able to view eligibility results
-- Fix Provided: Datafix has been provided, Found removal_id missmatch in tb_client_eligibility.
-- Pull request# N/A

*/

select  personid,removalid,activeflag from Intakeservreqchildremoval  where personid ='1c507c16-3b36-430a-b0dc-e47f01965fb5';

select * from tb_client_eligibility where client_id = '200888090';

update tb_client_eligibility
set removal_id = '253772',
	delete_sw = 'N',
	update_ts = now(), 	
	update_user_id = 'CDM-35382'
where client_id = '200888090';
