/*
   Issue Description: CJAMS-67817
    Category/ Module  : Prod data fix to remove the duplicate agreement records
   Root cause:  Re-executing the file again
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update gapagreementrate 
set activeflag =0, updatedby = 'CJAMS-67817', updatedon = now()  
where gapagreementrateid in ('69735b1d-4908-4a20-ab27-500487a80d81') and activeflag = 1;

update gapratesrevision 
set activeflag =0, updatedby = 'CJAMS-67817', updatedon = now()  
where gaprateid in ('69735b1d-4908-4a20-ab27-500487a80d81') and activeflag = 1;


update routing 
set activeflag =0, updatedby = 'CJAMS-67817', updatedon = now() 
where objectid ='69735b1d-4908-4a20-ab27-500487a80d81' and activeflag=1;
