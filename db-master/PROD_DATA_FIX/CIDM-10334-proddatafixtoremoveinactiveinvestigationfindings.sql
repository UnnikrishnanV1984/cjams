/*
   Issue Description: CIDM-10334
   Category/ Module  : Prod data fix to remove investigation findings
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update investigationmaltreatment
				set activeflag = 0, updatedby = 'CIDM-10334', updatedon = now()		
				where maltreatmentid = 'dd89e558-aef8-44f5-96f1-daa249c56c7a' and activeflag = 1