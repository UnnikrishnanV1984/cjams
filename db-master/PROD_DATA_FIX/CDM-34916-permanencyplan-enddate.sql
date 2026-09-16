/*
   Issue Description: CDM-34916
   Category/ Module  : Permanency Plan
   Root cause: an error while filling annual review of guardianship casee ,it was due to the enddate of an old permanencypaln,so fix is  to change  enddatefor permanency plan
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update permanencyplan  set enddate  ='2010-11-01 00:00:00.000' ,updatedby ='CDM-34916',updatedon  =now() where permanencyplanid  ='3243f5ac-b117-4ba4-b4ff-374f2a4d44f8';
