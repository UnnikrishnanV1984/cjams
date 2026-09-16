/*
   Issue Description: CDM-27528
   Category/ Module  : Prod data fix to update correct removal exit reason
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--No Record Found
select removalexitreason, * from intakeservreqchildremoval_history where intakeservreqchildremovalid ='7e47c589-2686-449a-8e93-7b495b33c7d8';


update cjams.intakeservreqchildremoval set removalexitreason ='EMANIND', updatedby ='CDM-27528', updatedon = now()
where intakeservreqchildremovalid ='7e47c589-2686-449a-8e93-7b495b33c7d8';
