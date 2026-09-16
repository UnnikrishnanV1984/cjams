/*
   Issue Description: CDM-27679
   Category/ Module  :  User asked to revert the maltreatment not applicable check box 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update investigationmaltreatment set isnotapplicable = 0, updatedby = 'CDM-27679', updatedon = now()
investigationid = '020b4fa6-7859-47be-9512-e8d63ef57f6d' and activeflag = 1;

