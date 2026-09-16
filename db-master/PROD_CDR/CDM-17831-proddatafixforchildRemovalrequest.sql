
/*
   Issue Description: CDM-17831
   Category/ Module  :  Child person program area removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-17831', updatedon = now() where intakeservreqchildremovalid = '5df49058-45c4-4a28-89d9-78ece6428d7d';

-- 5df49058-45c4-4a28-89d9-78ece6428d7d
 update placement set intakeservreqchildremovalid = '9a826d28-2812-4fb8-9bfb-8e34b2986346', updatedby = 'CDM-17831', updatedon = now() where intakeservreqchildremovalid = '5df49058-45c4-4a28-89d9-78ece6428d7d';