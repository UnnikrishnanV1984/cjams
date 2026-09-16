/*
   Issue Description: CJAMS-61679
   Category/ Module  :placement removal
   Root cause: user wants to change
   Pull request# for code fix: 
   Reason why no related code fix: 
  1) Remove two duplicate Foster Care - Non-Foster Home setting living arrangements as highlighted with red
  2) MDThink will revert the Foster Care - Non-Foster Home setting living arrangement with start date on 09/26/2024 08:49 PM (highlighted with yellow) back to approved status so you 
  can exit the respective Foster Care - Non-Foster Home setting living arrangement with the correct date.
*/

--Removal of two duplicate Foster Care - Non-Foster Home setting living arrangements as highlighted with red
Update placement
set activeflag=0, updatedon = now(), updatedby = 'CJAMS-61679'
where placementid in ('e656e46b-40d2-4d43-a53b-330eb6cb94b4','f9818671-4993-447a-9ece-c4afc1ac709f');

Update livingarrangement
set activeflag=0, updatedon = now(), updatedby = 'CJAMS-61679'
where placementid in ('e656e46b-40d2-4d43-a53b-330eb6cb94b4','f9818671-4993-447a-9ece-c4afc1ac709f');

Update placementrevision
set activeflag=0, updatedon = now(), updatedby = 'CJAMS-61679'
where placementid in ('e656e46b-40d2-4d43-a53b-330eb6cb94b4','f9818671-4993-447a-9ece-c4afc1ac709f');

Update routing
set activeflag=0, updatedon = now(), updatedby = 'CJAMS-61679'
where objectid in('e656e46b-40d2-4d43-a53b-330eb6cb94b4','f9818671-4993-447a-9ece-c4afc1ac709f');

-- approved status
update placementrevision
set status = 'Approved',
    updatedby = 'CJAMS-61679',
	updatedon = now()
where placementid = 'fd266ad4-f144-4f64-b86d-975b47a76a94'
and placementrevisionid in ('4a89ae2b-3ce1-4c30-bf95-9413e3765ac7','539818f0-62c3-4b83-8004-37489f69ca3b');

update routing 
set routingstatustypeid = 16,
    updatedon = now(), 
    updatedby = 'CJAMS-61679',
 routeddescription = 'Child PlacementApproved'
where objectid = 'fd266ad4-f144-4f64-b86d-975b47a76a94'
and routingid = 'f0ac22ab-3d78-4415-ba31-086c2166e422'
and activeflag = 1;
