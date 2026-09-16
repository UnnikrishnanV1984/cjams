-- CDM-35431 - Child Removal end date
/* Issue Description:User request to update end date on child removal

-- Person ID: c58cc89d-f59c-4201-9b4d-25d2e21f6d14

-- Category/ Module: Child Removal 

-- Root cause: User request to update end date on child removal 
-- Fix Provided: Datafix has been provided to update exit date on Intakeservreqchildremoval with personId=c58cc89d-f59c-4201-9b4d-25d2e21f6d14
-- Pull request# N/A

*/

select exitdate,* from Intakeservreqchildremoval where personid = 'c58cc89d-f59c-4201-9b4d-25d2e21f6d14' and activeflag=1 and removalid ='259877';

update Intakeservreqchildremoval
set exitdate = '2023-09-06',
	updatedon = now(), 	
	updatedby = 'CDM-35431'
where personid = 'c58cc89d-f59c-4201-9b4d-25d2e21f6d14' and activeflag=1 and removalid ='259877';

select * from personprogramarea
where personprogramid = '8cfbfc1a-9819-4257-b9fc-ad4ea6f380ac'
	and personid = 'c58cc89d-f59c-4201-9b4d-25d2e21f6d14'
	and activeflag=1
	and programkey = 'OOH';

update personprogramarea
set enddate = '2023-09-06',
	updatedon = now(), 	
	updatedby = 'CDM-35431'
where personprogramid = '8cfbfc1a-9819-4257-b9fc-ad4ea6f380ac'
	and personid = 'c58cc89d-f59c-4201-9b4d-25d2e21f6d14'
	and activeflag=1
	and programkey = 'OOH';

select * from tb_client_eligibility where removal_id = 259877;

update tb_client_eligibility
set end_dt = '2023-09-06',
	update_ts = now(), 	
	update_user_id = 'CDM-35431'
where removal_id = 259877;


