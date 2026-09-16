/*
  Issue Description:  CDM-41264
   Category/ Module  :  Child Removal
   Root cause: User request update removal end date and program and gap start and end dates
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/


----4143121-----
update intakeservreqchildremoval 
set exitdate = '2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where intakeservreqchildremovalid = 'c466fdff-ba17-4ff1-afd8-89d4a6c9e6b0' and activeflag = 1;

--update personprogramarea
--set enddate ='2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
--where personprogramid = '4425823d-ff87-478f-8956-f2aefc4ee0bd' and activeflag = 1;

update tb_client_eligibility 
set end_dt ='2024-09-05', update_user_id = 'CDM-42564', update_ts = now()  
where removal_id =198067 and client_id =4143121;


----4143122-----
update intakeservreqchildremoval 
set exitdate = '2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where intakeservreqchildremovalid = '81b0bcab-ea22-4274-8ad5-a5fb554c05ac' and activeflag = 1;

update personprogramarea
set enddate ='2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where personprogramid = '2d3086b5-d939-4351-b9ad-a411fb3bf574' and activeflag = 1;

update tb_client_eligibility 
set end_dt ='2024-09-05', update_user_id = 'CDM-42564', update_ts = now()  
where removal_id =198068 and client_id =4143122;


----4418840-----
update intakeservreqchildremoval 
set exitdate = '2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where intakeservreqchildremovalid = '1a60c0f3-173e-4cb5-9db6-dc5d8be3c9b8' and activeflag = 1;

update personprogramarea
set enddate ='2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where personprogramid = 'a3cd97b4-22ee-482e-9d4f-47cf8f957bfa' and activeflag = 1;

update tb_client_eligibility 
set end_dt ='2024-09-05', update_user_id = 'CDM-42564', update_ts = now()  
where removal_id =198064 and client_id =4418840;


----- Update personprogramarea----------

update personprogramarea
set startdate  ='2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where personprogramid = 'c1f6855d-36e2-47ac-9b32-1ee96f077a50' and activeflag = 1;

update personprogramarea
set enddate ='2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where personprogramid = '4425823d-ff87-478f-8956-f2aefc4ee0bd' and activeflag = 1;

update personprogramarea
set startdate  ='2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where personprogramid = '781da395-d574-4409-b8c8-77c259f8f39e' and activeflag = 1;

update personprogramarea
set enddate ='2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where personprogramid = 'a3cd97b4-22ee-482e-9d4f-47cf8f957bfa' and activeflag = 1;

update personprogramarea
set startdate  ='2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where personprogramid = '8f2473b2-9bbd-4921-a081-90f2ec303b72' and activeflag = 1;

update personprogramarea
set enddate ='2024-09-05', updatedon = now(),updatedby = 'CDM-42564'
where personprogramid = '2d3086b5-d939-4351-b9ad-a411fb3bf574' and activeflag = 1;

-------- Update Placement ---------------------


update placement set enddatetime='2024-09-05 00:00:00.000', updatedon = now(),updatedby = 'CDM-42564'
where placementid ='e2770021-1167-4a42-ba21-d4aad09ca243';

update placement set enddatetime='2024-09-05 00:00:00.000', updatedon = now(),updatedby = 'CDM-42564'
where placementid ='8e1c4894-95c5-401c-a204-c7c3db595d83';

update placement set enddatetime='2024-09-05 00:00:00.000', updatedon = now(),updatedby = 'CDM-42564'
where placementid ='8a26cf18-8550-471f-9d6d-5ec102bfb740';

------------ Update Placement Validation table------------------

update tb_placement_validation set update_ts = now(), update_user_id = 'CDM-42564'
where placement_id = 338223
and placement_validation_id = 2166323
and delete_sw = 'N';

update tb_placement_validation set update_ts =now(), update_user_id = 'CDM-42564'
where placement_id = 338226
and placement_validation_id = 2166324
and delete_sw = 'N';

update tb_placement_validation set update_ts =now(), update_user_id = 'CDM-42564'
where placement_id = 338107
and placement_validation_id = 2166320
and delete_sw = 'N';


------ Updating date in intakeservreqcourtorder -------------

update intakeservreqcourtorder
set courtorderdate = '2024-09-05', updatedby = 'CDM-42564', updatedon = now()
where intakeservreqcourtorderid in ('d4a482ae-25dd-454d-bc58-f0c622b9abee','f4715b4a-6fbe-49eb-bb2c-050144251dc5','988f3e2d-d1e6-4357-b2b9-680f2337740c')
and servicecaseid ='6962171c-25a3-48d9-a879-1c5233c69ace' and activeflag = 1;

update cjams.intakeservicerequestcourthearing 
set hearingdatetime ='2024-09-05 11:00:00.000', updatedby ='CDM-42564', updatedon = now()
where servicecaseid ='6962171c-25a3-48d9-a879-1c5233c69ace' and intakeservicerequestcourthearingid in
('75bf5910-5d8f-4b42-bde9-45faeaa32b91','e00a52ad-e812-484c-b3ed-51b77a010aad','2a5c9478-2c3d-4800-8fcd-cea31ed4239b')
and activeflag = 1;

----------- Update gap agreement dates ------------------


update gapagreementrate 
set startdate = '2024-09-05 04:00:00.000',
updatedby = 'CDM-42564',
updatedon = now() 
where  
gapagreementid in ('5dc436ce-4aa6-4850-b22f-d38674d27574','1693dddd-9c32-4c6a-9921-9e98dcbd879a','7259d362-dc8b-4299-9522-9cb81b92d313')
and gapagreementrateid in ('26cedecd-435e-4dad-9a47-1a4d072ca602','2c766923-43f5-42cf-86e4-89e13d6e9385','5ea75b46-497a-41ae-a142-470a09e042af')
and activeflag = 1;

update gapratesrevision
set ratestartdate = '2024-09-05 04:00:00.000',
updatedby = 'CDM-42564',
updatedon = now(),
approvaldate = now()
where gaprateid in ('26cedecd-435e-4dad-9a47-1a4d072ca602','2c766923-43f5-42cf-86e4-89e13d6e9385','5ea75b46-497a-41ae-a142-470a09e042af')
and activeflag = 1;