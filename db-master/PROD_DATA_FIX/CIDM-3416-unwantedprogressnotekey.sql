/*
   Issue Description: CIDM-3416
   Category/ Module  :  
   Root cause: Not required types
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update progressnotetypeconfig set activeflag = 0 , updatedby = 'CIDM-3416' , updatedon = now() where progressnotetypekey = 'CfE Site Expenditure Proposal';
update progressnotetype set activeflag = 0 , updatedby = 'CIDM-3416' , updatedon = now() where progressnotetypekey = 'CfE Site Expenditure Proposal';
