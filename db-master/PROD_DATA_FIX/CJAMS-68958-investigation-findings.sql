/*
Issue Description: User requested a data fix for investigation finding - value as Indicated
Category/Module: completed case
Root cause: User wanted a data fix for investigation finding value to Indicated from Ruled Out
Fix provided: Data fix has been provided by updating the investigation finding to Indicated from Ruled Out
Code/Data fix ticket#: N/A
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
*/


update investigationfinding 
set investigationfindingtypekey ='ID', updatedby ='CJAMS-68958', updatedon =now()
where investigationfindingid ='0f4f25cd-9b17-420b-af05-3f2685b4088c' and activeflag =1;