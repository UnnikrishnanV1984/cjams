/* 
 Issue Description: CDM-41720
 Category/ Module  :These cases and service case need to be removed from tree.
 Assign Case ---> To be Assigned
 CASE NUMBER : 211030008786
 Customer Email ID: tina.fazenbaker@maryland.gov
 Root cause:  Data fix to remove cases and service case from the tr
 Already is routed true for  CASE NUMBER : 211030008786
 Status type key should be ASSGN for  servicecasenumber : '211030008786'
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/


update servicecase set statustypekey  = 'ASSGN', updatedon = now(), updatedby = 'CDM-41720'
where servicecasenumber = '211030008786' and servicecaseid = '8e0d6fd4-2b5e-42ad-b8a7-cb8656adc881';
