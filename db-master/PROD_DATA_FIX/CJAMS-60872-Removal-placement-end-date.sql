/*
   Issue Description: CJAMS-60872
   Category/ Module  :  update the Living Arrangement, placement, childremoval end date 
   Root cause: user error, user wants to update the endate for Living Arrangement, placement, childremoval.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update livingarrangement 
set livingenddate = '2025-07-07 00:00:00', updatedon = now(), updatedby = 'CJAMS-60872' 
where placementid = '01029201-6b87-4ef3-9e4e-607cbcec8767';

update placement 
set enddatetime = '2025-07-07 00:00:00', updatedon = now(), updatedby = 'CJAMS-60872' 
where placementid = '01029201-6b87-4ef3-9e4e-607cbcec8767';

update
    placementrevision
set
    exitdate = '2025-07-07',
    updatedby = 'CJAMS-60872',
    updatedon = now()
where
    placementid = '01029201-6b87-4ef3-9e4e-607cbcec8767'
    and activeflag = 1;

update intakeservreqchildremoval 
set exitdate = '2025-07-07 15:00:00.000', updatedon =  now(), updatedby = 'CJAMS-60872' 
where intakeservreqchildremovalid  = '4f9c9edd-d0ec-459b-a54e-d274815333f0';

--select * from personprogramarea p where personid = '65260e05-e612-4e42-9563-73db666d3296' and objectid = 'b486d76e-ece7-4b3b-ae27-d0671e940e2b'
update personprogramarea set enddate = '2025-07-07 15:00:00.000', updatedon =  now(), updatedby = 'CJAMS-60872' where personprogramid = '51544a19-3eee-425f-bb70-77b48f6aa35d';

update
    tb_client_eligibility
set
    end_dt = '2025-07-07',
    update_user_id  = 'CJAMS-60872',
    update_ts  = now()
where
    removal_id = 285365 and delete_sw = 'N' ;