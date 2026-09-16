/*
   Issue Description: CDM-15621
   Category/ Module  : Permanency plan
   Root cause:Everytime I complete a permanency plan for Brionna Long and send it to my supervisor, it shows up under Tavraus Long Jr on my supervisors page. 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/




update placement set intakeservicerequestactorid = 'abd9fdcc-034f-40ff-a389-cf66fa20e490', updatedon = now(), updatedby = 'CDM-15621'
        where placementid = 'c8945a4c-f753-464a-95f0-9054a45a6ac1';