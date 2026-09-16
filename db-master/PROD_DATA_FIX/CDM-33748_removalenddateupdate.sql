/*
   Issue Description: CDM-33748
   Category/ Module  :  Removing placement, removal end date
   Root cause: user requeseted to update placement, removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
UPDATE cjams.personprogramarea
SET enddate=null, updatedon=now(), updatedby='CDM-33748'
WHERE personid = 'b93a975e-b001-448e-8b1a-201239d3a28a' and programkey = 'OOH' 
and personprogramid = '7971e82b-0c7c-4274-bde3-8ad1f2e8295b';

UPDATE cjams.intakeservreqchildremoval
SET updatedby='CDM-33748', updatedon=now(), exitdate=null, removalexitreason=null
WHERE intakeservreqchildremovalid='84be2cc9-d12f-4108-84f4-410bdb350c37' and removalid=194875 and personid='b93a975e-b001-448e-8b1a-201239d3a28a';

UPDATE cjams.tb_client_eligibility
SET end_dt=null, update_user_id='CDM-33748', update_ts=now()
WHERE eligibility_id=167690 and client_id=4289701 and removal_id=194875;

UPDATE cjams.placement
SET enddatetime=null, updatedon=now(), updatedby='CDM-33748', exitreasontypekey=NULL, exittypekey=null,endtime=null, voidapprovaldate=null
WHERE placementid='e3c4ccda-36d4-4cdb-b4d0-b31e6abf8728';

update cjams.placementrevision 
set exitdate = null, exittime = null, exitreasontypkey = null,	exittypekey = null, updatedon = now(), updatedby = 'CDM-33748' 
where placementid = 'e3c4ccda-36d4-4cdb-b4d0-b31e6abf8728' and activeflag = 1;

