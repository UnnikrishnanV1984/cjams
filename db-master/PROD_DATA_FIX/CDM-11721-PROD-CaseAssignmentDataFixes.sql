update cjams.caseassignment 
set toldssid ='1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', updatedon =now(), updatedby ='CDM-11721'
where caseassignmentid ='606bf93a-5f4b-4950-abce-44cdc8277dd5';

update cjams.caseassignment 
set objecttypekey ='servicecase', updatedon =now(), updatedby ='CDM-11721'
where caseassignmentid in ('7a22889e-dfbf-47bc-a41d-6315bcef6d09',
'3b0ea7a9-0ddd-4870-8e8c-1fadbe73b8ec');