/*
   Issue Description: CDM-30438
   Category/ Module  : Incorrect Maltreator Identified
   Root cause: user requested to change the maltreator role  from Yunus Hamza to Fauzia Mohammad 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/



update
    intakeservicerequestactor
set
    personid = 'a5843457-22bf-4e83-afae-b1acccf6efcb',
    actorid = 'ea08f402-cc2d-41e1-8607-55bb6fbc005b',
    updatedby = 'CDM-30438',
    updatedon = now()
where
    actorid = '1d7bc68d-4983-4c38-8968-a66ae926d7e0'
    and intakeservicerequestpersontypekey = 'AM'
    and activeflag = 1
    and intakeservicerequestactorid = 'c230160e-73c1-406d-bd67-56d3dccf58dc';