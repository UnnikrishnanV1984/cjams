/*
   Issue Description: CDM-33546
   Category/ Module  : subsidy rate
   Root cause: User requested to remove the subsidy rate entered by mistake
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE gapagreementrate g set activeflag = 0,updatedby ='CDM-33546',updatedon =now() where  gapagreementrateid ='6e805ec2-3184-4cdd-a9a3-7926f6fadfc2';

UPDATE gapratesrevision set activeflag = 0,updatedby ='CDM-33546',updatedon =now(),approvaldate  =now() where  gaprateid  ='6e805ec2-3184-4cdd-a9a3-7926f6fadfc2';

UPDATE routing set activeflag = 0,updatedby ='CDM-33546',updatedon =now() where  objectid  ='6e805ec2-3184-4cdd-a9a3-7926f6fadfc2';