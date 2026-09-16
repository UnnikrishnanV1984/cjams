/*
   Issue Description: CDM-23968
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 5930
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
UPDATE intakeservreqchildremoval 
SET exitdate=null,  
    updatedby='CDM-23968',
    updatedon=now() 
WHERE intakeservreqchildremovalid = '70766a14-4f68-4fc7-97c3-c9f175ef0895';

UPDATE personprogramarea 
SET enddate = null, 
    updatedby = 'CDM-23968', 
    updatedon = now() 
WHERE personprogramid = 'a9f06911-c76e-4348-8a3a-f31257b1d193';

update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-23968' 
where placementid = 'a3694281-d830-4037-85f5-cc6c8fa3fdf2' and activeflag = 1;

update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-23968' 
where placementid = 'a3694281-d830-4037-85f5-cc6c8fa3fdf2' and activeflag = 1;

update tb_placement_validation set placement_exit_dt = null, update_user_id = 'CDM-23968', update_ts = now() 
where placement_id  = 1337602;