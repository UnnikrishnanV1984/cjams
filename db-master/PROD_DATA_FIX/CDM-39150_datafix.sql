/*
   Issue Description: CDM-39150
   Category/ Module  : Application
   Root cause:Remove the child removal, OOH program assignment, and Provider Placement end date (with Placement Structure as Pre-Finalized Adoptive Home)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE intakeservreqchildremoval 
SET exitdate = Null,
    returndate = Null,
    returntime = Null,
    returntransts = NULL,
    removalexitreason = NULL,
    updatedby ='CDM-39150',
    updatedon = now()
WHERE removalid =183648;

UPDATE tb_client_eligibility 
SET 
     end_dt = null,
    update_user_id = 'CDM-39150',
    update_ts = now()
WHERE removal_id ='183648' and delete_sw = 'N';

UPDATE personprogramarea 
SET   enddate = null,
      updatedby ='CDM-39150',
      updatedon = now() 
WHERE personprogramid  ='792c7ff9-a047-488a-a228-efbae9ea33a1' and activeflag =1;