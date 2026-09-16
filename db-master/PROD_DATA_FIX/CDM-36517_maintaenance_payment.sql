-- CDM-36517 - Missing maintenance payment
/* Issue Description: No placement validation populated for our youth Melodic Braboy ID#3305446

-- Case ID: 3305446
-- Client ID: 200786700 (Melodic Romancia Braboy) - a87ca565-9251-4c60-8fc8-6e537f2aafa9
-- Removal Id: 293176 - 2021-07-26 To 2023-11-09 - a42bd2f4-c5c9-4bf0-a4f6-bbfb1f765d9b
-- Placement Id: 1774278 - 2023-11-07 To 2023-11-09 - af62c75d-ed30-4550-bb49-65d295580c67

-- Category/ Module: Payments

-- Root cause: No placement validation populated for our youth Melodic Braboy ID#3305446 
-- Fix Provided: Datafix has been provided to update payments
-- Pull request# N/A
*/

-- Update Placement table with removal id = a42bd2f4-c5c9-4bf0-a4f6-bbfb1f765d9b
select alternateid, placementid, startdatetime, enddatetime, altproviderid,
	intakeservreqchildremovalid, updatedby, updatedon
from placement 
where personid='a87ca565-9251-4c60-8fc8-6e537f2aafa9' and intakeservreqchildremovalid='5dd86355-fc13-4d96-80c0-2cbaad6a7372' and activeflag = 1;

select activeflag,removalid,removaldate,exitdate,* from intakeservreqchildremoval 
where intakeservreqchildremovalid='5dd86355-fc13-4d96-80c0-2cbaad6a7372' or personid='a87ca565-9251-4c60-8fc8-6e537f2aafa9'; 

update placement 
set intakeservreqchildremovalid='a42bd2f4-c5c9-4bf0-a4f6-bbfb1f765d9b',
updatedby='CDM-36517',
updatedon=now()
where personid='a87ca565-9251-4c60-8fc8-6e537f2aafa9' and intakeservreqchildremovalid='5dd86355-fc13-4d96-80c0-2cbaad6a7372' and activeflag = 1;

select * from tb_placement where client_id='200786700';

-- Placement Validations updates
select placement_id, placement_entry_dt, placement_exit_dt, 
	validation_start_dt, validation_end_dt, validation_status_cd ,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_id = 1774278
	and delete_sw = 'N'
order by validation_start_dt;

INSERT INTO cjams.tb_placement_validation
(placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date)
VALUES(nextval('sq_placement_validation'::regclass),1774278, '2023-11-07', '2023-11-09', NULL, NULL, 'CDM-36517', 'CDM-36517', 'N', '2023-11-07', '2023-11-09', now(), now(), NULL, NULL);
