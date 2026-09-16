/*
Issue Description:CJAMS-64021 Placement Needed
Category/Module: Placement 
Root cause: The placement was accidentally ended when the child was hospitalized.Data fix is needed to remove the respective living arrangement end date and the rejected trial home visit living arrangement.
Fix provided: Data fix has been done to remove the living arrangement end date and the rejected trial home visit living arrangement.
Data/Code fix ticket#: CJAMS-64021
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User ended placement incorrectly and data fix needed to remove the enddate.
*/


---Removing enddate for the placement id 16642a8b-3ad4-4d04-84c4-09612b45a90f
update placement 
set enddatetime = null, 
    endtime = null, 
    exitreasontypekey = null,
    exittypekey = null, 
    updatedon = now(), 
    updatedby = 'CJAMS-64021'
where placementid = '16642a8b-3ad4-4d04-84c4-09612b45a90f'
and activeflag = 1;

update placementrevision 
set exitdate = null, 
    exittime = null, 
    exitreasontypkey = null,
    exittypekey = null, 
    updatedon = now(), 
    updatedby = 'CJAMS-64021' 
where placementid ='16642a8b-3ad4-4d04-84c4-09612b45a90f' 
and (exitdate is not null or exittime is not null);

---Deleting the rejected placement a7f0b3f2-743a-4324-a979-08ad4f07bcba

update placement
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64021'
where placementid = 'a7f0b3f2-743a-4324-a979-08ad4f07bcba'
and activeflag = 1;


update placementrevision
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64021'
where placementid = 'a7f0b3f2-743a-4324-a979-08ad4f07bcba'
and activeflag = 1;


update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64021'
where objectid = 'a7f0b3f2-743a-4324-a979-08ad4f07bcba'
and activeflag = 1;