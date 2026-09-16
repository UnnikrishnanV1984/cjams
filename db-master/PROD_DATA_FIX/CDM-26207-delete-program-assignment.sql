/* 
    Issue Description : CDM-26207	
    Category/ Module : Program assignment
    Root cause : User wants to delete duplicate program area
*/

UPDATE personprogramarea 
SET activeflag = 0
	, updatedby ='CDM-26207'
	, updatedon = now() 
WHERE personprogramid  = 'cf05cb91-bc24-4d37-a6e5-4c374d368776';