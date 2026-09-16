/*
   Issue Description: CDM-19888
   Category/ Module  : CPS case and purchase auth dates 
   Root cause: user wants to make changes in cases for program area and dates 
   Pull request# for code fix:4747
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
-- 1
update tb_service_log set end_dt = '2020-04-22', update_ts = now(), update_user_id = 'CDM-19888'
where service_log_id = '834303';

-- 2
update placement set activeflag = 0, updatedby = 'CDM-19888', updatedon = now()
where placementid = 'e637d406-704e-4c09-be77-0512d9c34a27';

update livingarrangement set activeflag = 0, updatedby = 'CDM-19888', updatedon = now()
where placementid = 'e637d406-704e-4c09-be77-0512d9c34a27';

-- 3
update tb_service_log set end_dt = '2015-09-01', update_ts = now(), update_user_id = 'CDM-19888'
where service_log_id = '649901';

-- 4
update tb_service_log set end_dt = '2021-05-25', update_ts = now(), update_user_id = 'CDM-19888'
where service_log_id = '834301';

-- 5
update personprogramarea set endreasonkey = '3400', updatedon = now(), updatedby = 'CDM-19888'
where personprogramid = '69bb8f86-1573-46a9-9e29-f48acbd392d0';

-- 6
update personprogramarea set enddate = '2021-09-30 00:00:00.000', updatedon = now(), updatedby = 'CDM-19888'
where personprogramid in ('f145b0ab-023b-4383-b8d1-422633ea8938', 'd6de8559-49f0-4f3d-a8a0-a2c9bc26909c');

update personprogramarea set endreasonkey = '3390', updatedon = now(), updatedby = 'CDM-19888'
where personprogramid in ('c76cba38-9e44-43e1-a854-788c561e36f9', '5618e95d-aab2-4c4e-9625-1ab0e911daaa');