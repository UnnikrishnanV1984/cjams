/*
   Issue Description: CDM-21746
   Category/ Module  : Prod data fix to Remove Duplicate Removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update personprogramarea set activeflag = 0, updatedby = 'CDM-21746', updatedon= now()  where personprogramid = '94f49ae8-24e7-4f7f-912a-ad7fb21c23e7';
update intakeservreqchildremoval set activeflag = 0 , updatedby = 'CDM-21746', updatedon =  now() where intakeservreqchildremovalid = '05625768-d3eb-4e19-af74-0f847944fed4';
 