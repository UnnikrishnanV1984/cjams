/*
   Issue Description: CDM-34292
   Category/ Module  : Response timer
   Root cause: Response timer overdue because of wrong sdm value selected
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/

update  intakeservicerequestsdm 
set isnoimmed_physicalabuse =false,
isnoimmed_neglectresponse =true ,
updatedby= 'CDM-34292',updatedon =now() 
where intakeserviceid='799a54ad-350b-41a2-8bcd-0634f786c663' 
and intakeservicerequestsdmid ='8f30e047-f448-4480-a055-254a14a6051c';