UPDATE role SET openamrole ='CJAMS_LDSS_FISCAL_STAFF'
,updatedon =Now(),updatedby ='admin' 
WHERE roletypekey = 'FNSFW' 
AND description = 'Finance Worker' 
AND openamrole = 'CS_FINANCIAL_WORKER' 
AND id = '1052';