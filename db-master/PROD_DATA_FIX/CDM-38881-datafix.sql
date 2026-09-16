/* 
    Issue Description: CDM-38881
  Category/ Module  : Placement
  Root cause: Data fix, updated the Living arrangement exit type , also removed the child removal end date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update placement set exittypekey='CIP', updatedon = now(), 
updatedby = 'CDM-38881' where placementid='7fda7864-0676-4e18-9beb-4fc641ab2b12';

update placement set exittypekey='CIP', updatedon = now(), 
updatedby = 'CDM-38881' where placementid='e68e08de-b5b8-46ce-8e35-9345eaf6791d';
    

update
    placementrevision
set
    exittypekey = 'CIP',
    -- Change in Placement 
    updatedby = 'CDM-38882',
    updatedon = now()
where
    placementid = '7fda7864-0676-4e18-9beb-4fc641ab2b12' 
    and placementrevisionid ='f3a013d4-f26c-4e9e-a02f-82b66f829c1b';

update
    placementrevision
set
    exittypekey = 'CIP',
    -- Change in Placement 
    updatedby = 'CDM-38882',
    updatedon = now()
where
    placementid = 'e68e08de-b5b8-46ce-8e35-9345eaf6791d' 
    and placementrevisionid ='64e98d15-c116-49df-954c-0b2166966341';
    

UPDATE intakeservreqchildremoval 
SET exitdate = Null,
    returndate = Null,
    returntime = Null,
    returntransts = NULL,
    removalexitreason = NULL, 
    updatedby ='CDM-38882',
    updatedon = now()
WHERE intakeservreqchildremovalid = '1d5fe7f2-5384-478f-b842-754f8f265078';

UPDATE tb_client_eligibility 
SET 
     end_dt = Null,
     update_user_id = 'CDM-38882',
     update_ts = now()
WHERE removal_id ='254689' and delete_sw = 'N';
