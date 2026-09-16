 /* 
    Issue Description: CDM-34342
   Category/ Module  : DECISION
   Root cause: user wants to update the table servicecase statustypekey and dispositioncode to open . 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
 update servicecase SET statustypekey ='Open',
 dispositioncode = 'Open',
 enddate = null,updatedon=now(),updatedby ='CDM-34342'
 where servicecasenumber = '3275524';