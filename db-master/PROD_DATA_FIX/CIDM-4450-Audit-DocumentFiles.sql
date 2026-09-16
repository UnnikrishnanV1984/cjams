/*
   Audit column not updated in cjams.documentproperties table
*/
	

update documentproperties
set updatedby = 'CIDM-4450', updatedon = insertedon 
where updatedby is null and updatedon is null;