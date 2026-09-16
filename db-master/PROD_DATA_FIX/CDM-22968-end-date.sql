/*
-- CDM-22968 --

-- Issue Description: 
 Unable to set the end date
  
-- Customer Email ID: arice@maryland.gov

-- Root cause: Data fix to set the end date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.intakeservreqchildremoval
set removalexitreason = 'REUNIF',
    exitdate = '2020-05-14 05:00:00',
    returntime = '2020-05-14 05:00:00',
    updatedby = 'CDM-22968',
    updatedon = now()
where intakeservreqchildremovalid = '691d1c75-732b-4a9b-84b5-5546c8febf15'
    and activeflag = 1 ;
    