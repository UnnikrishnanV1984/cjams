/*
   Issue Description: CDM-44071
   Category/ Module  : Placement
   Root cause: user requeseted to remove duplicate placement. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placement 
set activeflag = 0, updatedby = 'CDM-44071', updatedon = now()
where placementid = '3a0a93d7-0fcd-42fe-8ba0-34ec2daff3db' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedby = 'CDM-44071', updatedon = now()
where placementid = '3a0a93d7-0fcd-42fe-8ba0-34ec2daff3db' and activeflag = 1;

update routing 
set activeflag = 0, updatedby = 'CDM-44071', updatedon = now()
where objectid = '3a0a93d7-0fcd-42fe-8ba0-34ec2daff3db' and activeflag = 1;

update livingarrangement 
set activeflag = 0, updatedby = 'CDM-44071', updatedon = now()
where placementid = '3a0a93d7-0fcd-42fe-8ba0-34ec2daff3db' and activeflag = 1;
