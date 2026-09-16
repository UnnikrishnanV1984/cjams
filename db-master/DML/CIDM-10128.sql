--PSYCHOTROPIC roles to be updated with full names to match with sailpoint
--CIDM-10128

update role set openamrole='CJAMS_CW_PSYCHOTROPIC_PHARMACIST',updatedby='CIDM-10128',updatedon=now() 
where name ='CJAMS_CW_PSYCH_PHARMACIST' and  roletypekey='CWPSYPHARM' and activeflag=1;



update role set openamrole='CJAMS_CW_PSYCHOTROPIC_PSYCHIARIST',updatedby='CIDM-10128',updatedon=now()
where name ='CJAMS_CW_PSYCH_PSYCHIARIST' and  roletypekey='CWPSYPSYCH' and activeflag=1;



update role set openamrole='CJAMS_CW_PSYCHOTROPIC_COORDINATOR',updatedby='CIDM-10128',updatedon=now()
where name ='CJAMS_CW_PSYCH_COORDINATOR' and  roletypekey='CWPSYCOORD' and activeflag=1;