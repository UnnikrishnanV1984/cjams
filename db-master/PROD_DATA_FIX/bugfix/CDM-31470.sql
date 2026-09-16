/*
   Issue Description: CDM-31470
   Category/ Module  : review tab
   Root cause: user wants remove the Annual Review on 05/18/2023.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/ 
 update adoptioniverenewal set activeflag=0, updatedby='CDM-31470',updatedon=now() where adoptioniverenewalid='d9fa5528-dd3d-44ff-b244-adc09177dbf3' and activeflag=1;
 update routing set activeflag=0, updatedby='CDM-31470',updatedon=now() where objectid='d9fa5528-dd3d-44ff-b244-adc09177dbf3' and activeflag=1;