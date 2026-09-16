/* Issue Description:CDM-14280 - Removing placement recors
   Category/ Module  :  placement 
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/


update placement set activeflag =0, updatedby ='CDM-14280', updatedon =now() where placementid  = '45f55ff2-71e3-481e-a1e0-2fb9b0d5960e';
update livingarrangement set activeflag =0, updatedby ='CDM-14280', updatedon =now() where placementid  = '45f55ff2-71e3-481e-a1e0-2fb9b0d5960e';
update routing set activeflag =0, updatedby ='CDM-14280', updatedon =now() where objectid  = '45f55ff2-71e3-481e-a1e0-2fb9b0d5960e'
and eventcode  = 'PLTR';