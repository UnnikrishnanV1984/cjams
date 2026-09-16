/*
-- CDM-19890 - 

-- Issue Description: 
 Israel Taiwo -211030011291 – Specialist entered 9/30/2021 for "Date last lived with specified relative". Date changed by system to 10/1/2021. I've seen this happening with a lot of cases. 
 Another recent case Marques Brinkley 3292017 - specialist entered 9/17/2021 and system changed to 9/18/2021.
-- Case ID: 211030011291

-- Root cause: Data fix updated for the caseID
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservreqchildremoval set activeflag=0, updatedon = now(), updatedby = 'CDM-19890' where intakeservreqchildremovalid='e1525769-c938-487e-a52f-c114a4ae7b7e';


select activeflag, routingstatustypeid, remarks, updatedby, updatedon from routing ro 
where ro.objectid = 'e1525769-c938-487e-a52f-c114a4ae7b7e'
and ro.activeflag = 1 ;

update routing ro
set ro.activeflag = 0,
ro.updatedby = 'CDM-19890',
ro.updatedon = now() 
where ro.objectid = 'e1525769-c938-487e-a52f-c114a4ae7b7e'
and ro.activeflag = 1 ;
