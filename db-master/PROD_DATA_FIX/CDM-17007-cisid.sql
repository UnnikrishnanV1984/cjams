
 /*
  Issue Description: CDM-17007 
   Category/ Module  :  Missing CIS number
   Root cause: CIS is not getting updatged from MDM
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
--CDM-17007
select cisclientid, * from cjams.person where cjamspid=4492604 and activeflag=1;

update cjams.person set cisclientid=443061621 , updatedby='CDM-17007' ,updatedon =now()  where cjamspid=4492604 and activeflag=1;