
/* 
    Issue Description : CDM-30372	
    Category/ Module : Program assignment
    Root cause : User wants to delete duplicate program area
*/

UPDATE personprogramarea 
SET activeflag = 0
	, updatedby ='CDM-30372'
	, updatedon = now() 
WHERE personprogramid  = '637c5ef4-686e-4e0a-a9fa-2eaf749a1e9f';


UPDATE personprogramarea 
SET activeflag = 0
	, updatedby ='CDM-30372'
	, updatedon = now() 
WHERE personprogramid  = '3ecb81cb-3bb2-4d9c-97a6-f94c8222e250';
