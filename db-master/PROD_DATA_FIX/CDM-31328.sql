
/*
  Issue Description: CDM-31328 
   Category/ Module  :  Assign CIS Number
   Root cause:
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

--MDT-146480013
--cjamspid='200925227'
select cisclientid, * from cjams.person where cjamspid='200925227';

update cjams.person set cisclientid='449062431', updatedby='CDM-31328', updatedon=now() where cjamspid='200925227'
and personid='81391a3e-9af6-4402-b85f-82ca47058c3b';
