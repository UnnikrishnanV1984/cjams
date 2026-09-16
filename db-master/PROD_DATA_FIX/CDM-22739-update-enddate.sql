/*
-- CDM-22739- 

-- Issue Description: 
 Unable to remove the rejected living arrangementts
  
-- Customer Email ID: teresa.hewlin2@maryland.gov

-- Root cause: Data fix to set the activeflag to zero to remove the rejected living arrangements
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update placement set activeflag = 0, updatedon = now(), updatedby = 'CDM-22739'  where placementid in ('4e50c065-711e-4bf3-829b-0d259f2397a2','017352e8-57a6-4428-bcc6-1ff373bb8111') and activeflag =1;

update placementrevision set activeflag = 0, updatedon = now(), updatedby = 'CDM-22739'  where placementid in ('4e50c065-711e-4bf3-829b-0d259f2397a2','017352e8-57a6-4428-bcc6-1ff373bb8111') and activeflag =1;

update personprogramarea set enddate = null, updatedon = now(), updatedby = 'CDM-22739' where personprogramid = 'b0e0d894-5677-4d2f-88af-69ec3ef524b7';

update routing set activeflag =0, updatedby = 'CDM-22739', updatedon = now()  where routingid in ('7c194d2c-c3d3-419b-b4f7-9a2a90287ac7'
,'c196cc71-375c-4479-8b46-b1edbaf1670e') and activeflag =1;