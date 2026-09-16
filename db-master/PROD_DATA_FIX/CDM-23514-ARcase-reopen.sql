/*
   Issue Description: CDM-23514
   Category/ Module  :  data fix to reopen AR
   Pull request# for code fix: 5806
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservicerequest set exitdate = null,updatedby ='CDM-23514', updatedon = now(), intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da'
where intakeserviceid = 'e72eb63a-ec76-41f1-bce6-d10749000701';

update  Intakeservicerequestdispositioncode set activeflag = 0,updatedby ='CDM-23514', updatedon = now() where intakeservicerequestdispositioncodeid = '996a01fa-c271-4c5f-92b6-a3de646f6e18';
