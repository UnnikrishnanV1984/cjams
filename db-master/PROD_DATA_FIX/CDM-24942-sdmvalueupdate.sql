/*
  Issue Description:CDM-24942
   Category/ Module  :  Sdmbox.
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
UPDATE intakeservicerequestsdm  SET isneguc_leftalonewithoutsupport =true ,
updatedby ='CDM-24942',
updatedon = now()
where intakeserviceid  ='5e34c2ed-ac8f-4768-b301-50b9f9ebea4b' and intakeservicerequestsdmid  ='b15a97e9-8824-4115-88b0-ed332d88b706' ;