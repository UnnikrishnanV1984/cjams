/*
   Issue Description: CJAMS-64913
   Category/ Module  : Prod data fix to remove duplicate guardianship
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/







update guardianship set activeflag = 0, updatedby = 'CJAMS-64913', updatedon= now() where gapid in ('8ef8c256-3937-4f75-835a-7302f82eec05',
'063b9b9e-cd61-40b2-82c4-be95e2dda2c4','52616a5a-3af7-440f-bb1e-acbdd76f527a') and activeflag = 1;