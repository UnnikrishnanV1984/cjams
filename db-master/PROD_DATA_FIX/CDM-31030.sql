 /*
  Issue Description: CDM-31030 April Salisbury not in approval drop down list
   Category/ Module  :  user profile
   Root cause: user role is not updated correctly
   Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

select * from cjams.teammember where teammemberid='a422dc44-808c-48b0-aa26-048ee89ffba5' and activeflag=1;

update cjams.teammember set roletypekey='CWSP', updatedby='CDM-31030', updatedon=now() where teammemberid='a422dc44-808c-48b0-aa26-048ee89ffba5' and activeflag=1;

select roletypekey,* from cjams.teammember where teammemberid='a422dc44-808c-48b0-aa26-048ee89ffba5' and activeflag=1;
