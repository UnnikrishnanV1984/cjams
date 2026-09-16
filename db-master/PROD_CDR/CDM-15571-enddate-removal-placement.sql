-- Removal
update cjams.intakeservreqchildremoval
set exitdate = '2021-05-10 00:00:00',
returntime = '2021-05-10 16:00:00',
removalexitreason = 'REUNIF',
updatedby = 'CDM-15571',
updatedon = now()
where removalid = 252038
and activeflag = 1 ;

-- Placement
update placement  
set enddatetime = '2021-05-10 00:00:00',
endtime = '12:00',
exitreasontypekey = 'PLCCE',
exittypekey = 'PLCC',
updatedon = now(),
updatedby = 'CDM-15571'
where placementid = 'b4e2d5d2-9a93-40a9-bbda-68b3c5ffac12'
and activeflag = 1 ;


-- Placement Revision
update cjams.placementrevision  
set exitdate = '2021-05-10 00:00:00',
exittime = '12:00',
exitreasontypkey = 'PLCCE',
exittypekey = 'PLCC',
updatedon = now(),
updatedby = 'CDM-15571'
where placementid = 'b4e2d5d2-9a93-40a9-bbda-68b3c5ffac12'
and exitdate is not null ;

-- OOH
update cjams.personprogramarea
set enddate = '2021-05-10 00:00:00',
updatedby = 'CDM-15571',
updatedon = now()
where personprogramid = '083791f3-c415-4ac4-96b4-040155ed8b1b'
and activeflag = 1 ;

-- IV-E
update cjams.tb_client_eligibility
set end_dt = '2021-05-10',
update_user_id = 'CDM-15571',
update_ts = now()
where removal_id = 252038
and delete_sw = 'N' ;

