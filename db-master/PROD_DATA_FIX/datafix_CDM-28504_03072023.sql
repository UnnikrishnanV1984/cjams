/*
   Issue Description: CDM-28504 - Maltreater identification
   Category/ Module  :  data fix to reopen CPS-IR : 221020288068
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

-- Completed 
select * from intakeserreqstatustype where intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8';
-- Open
select * from intakeserreqstatustype where intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da';

-- inspect the summary page to get intakeserviceid = '57c9efab-c0a4-46ad-afac-acb7e8994600'
update intakeservicerequest set exitdate = null,updatedby ='CDM-28504', updatedon = now(), intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da'
where intakeserviceid = '57c9efab-c0a4-46ad-afac-acb7e8994600';

-- inspect the INVESTIGATION FINDINGS page - api/Intakeservicerequestdispositioncodes/GetHistory to get "dispstatus": "Completed", "intakeservicerequestdispositioncodeid":"b40b4ee7-e309-4ef0-b43f-ad5bfd0869e9"
update  Intakeservicerequestdispositioncode set activeflag = 0,updatedby ='CDM-28504', updatedon = now() where intakeservicerequestdispositioncodeid = 'b40b4ee7-e309-4ef0-b43f-ad5bfd0869e9';