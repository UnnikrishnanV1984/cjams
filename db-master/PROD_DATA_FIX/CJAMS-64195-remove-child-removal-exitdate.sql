/*
Issue Description:CJAMS-64195 Need to take out child removal exit date
                  251030547896:The child Kyrie Fortune's case was end dated as the child went home, but the kin was approved as a paid kin and we can not enter the paid kin unless the child removal end date is taken out.
Category/Module: Child Removal
Root cause: This is not an application issue. As per system design, the child removal will automatically ended if the placement/living arrangement exited with exit type is selected as Permanently Leaving Custody & Care.

Data/Code fix ticket#: CJAMS-64195
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix is needed as per the system design.
*/

update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    returntime = null,
    returndate = null,
    removalexitreason = null,
    updatedby = 'CJAMS-64195',
    updatedon = now()
where intakeservreqchildremovalid in ('7fbe550c-2e31-492b-a0ef-38a6efcabf81',
'e4fda664-d811-49d3-a958-eafdcddf8ffd',
'63521141-330b-447c-abb3-e85f9b5fb2d8')
and activeflag =1;

update personprogramarea 
set enddate = null, 
    updatedby ='CJAMS-64195', 
    updatedon = now()  
where personprogramid in ('b0185ee9-7a5a-4f56-9a8a-d33fc70f4862',
'52657fd1-b973-4f39-9280-fac30c205998',
'f79a13ef-79e1-4f20-ad89-93cc0844da89') 
and activeflag = 1;


update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-64195',
    update_ts = now()
where removal_id in ('370313',
'370311','370312')
and delete_sw = 'N';



update placement
set  exittypekey = 'CIPS',
     exitreasontypekey = null,
     updatedby = 'CJAMS-59833',
     updatedon = now()
where placementid in ('4e325d99-23b3-41d3-93ab-d9538baa691f','56528003-69f5-4934-bf3b-490d1edce428','ce03cd45-4032-44dd-be69-388361374f5a')
and activeflag=1;

update placementrevision
set exittypekey = 'CIPS',
    updatedby = 'CJAMS-59833',
    exitreasontypkey = null,
    updatedon = now()
where placementid in ('4e325d99-23b3-41d3-93ab-d9538baa691f', '56528003-69f5-4934-bf3b-490d1edce428', 'ce03cd45-4032-44dd-be69-388361374f5a')
and activeflag = 1;



