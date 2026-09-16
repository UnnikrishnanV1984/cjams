/*
 Issue Description: CDM-40237
-- Category/ Module: Child Removal
-- Root cause: User wants to udpate child removal end date.
-- Fix Provided: Datafix has been promoted to update end date.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update Intakeservreqchildremoval
set 
exitdate= '2024-06-10',
updatedby = 'CDM-40237',
updatedon = now()
where   
intakeservreqchildremovalid in ('7a52a0f0-bc19-4d73-96af-4db9ff9cf3a6',
								'c11ff0a1-5707-4fd8-a0d6-46a98d0108ff',
								'c78d80aa-7165-4675-a957-86202ace8805');


update personprogramarea 
set 
enddate= '2024-06-10',
updatedby = 'CDM-40237',
updatedon= now()
where 
personprogramid in ('b8256d8d-775a-423b-afab-4fb8c9ee3aa8',
					'dd93338c-5101-4767-a61c-a1ec9155a6bc',
					'dfc53f7d-875d-42a6-94e7-210748160d3f');


update tb_client_eligibility
set
end_dt = '2024-06-10',
update_user_id = 'CDM-40237',
update_ts = now()
where 
removal_id in ('264584','264585','264586');





