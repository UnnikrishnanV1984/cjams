/*
   Issue Description: CDM-34466
   Category/ Module  : Prod data fix to update the removal end date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 2021-10-01 10:00:00
update intakeservreqchildremoval set exitdate = '2021-04-13 00:00:00', updatedby = 'CDM-34466', updatedon = now()
where intakeservreqchildremovalid = 'b9692f4c-e48f-4520-b2b4-8dd4cbb26205';

-- 2021-10-01 10:00:00
UPDATE cjams.personprogramarea SET enddate='2021-04-13 00:00:00', updatedby='CDM-34466', updatedon=now() 
WHERE personprogramid = '94515340-628d-4463-a58e-ccb66fad8f92';

-- 2021-10-01 10:00:00
update placement set enddatetime = '2021-04-13 00:00:00', updatedby='CDM-34466', updatedon=now()
where placementid = '46c81521-14e3-4c23-bd52-32608a734e8a';

-- 2021-10-01 10:00:00
update livingarrangement set livingenddate = '2021-04-13 00:00:00', updatedby='CDM-34466', updatedon=now()
where placementid = '46c81521-14e3-4c23-bd52-32608a734e8a';

-- 2021-10-01 10:00:00
update tb_client_eligibility set end_dt = '2021-04-13 00:00:00', update_ts =now(), update_user_id = 'CDM-34466'
where removal_id = '250996';
