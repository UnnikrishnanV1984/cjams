/*
   Issue Description: CDM-33707
   Category/ Module  : Adoption case  
   Root cause:  User request 
   Fix Provide: Did data fix to removed the person and added person to the case 
*/


--Removing the person from the case --3053825
update cjams.adoptioncaseactor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-33707'
where adoptioncaseactorid ='8f69c035-a08e-4594-830f-533d53912106';


--Replacing person --3053606
update cjams.adoptioncaseactor 
set personid  = '7ff77b7c-a5af-425d-90c5-f0dde21606e5',
updatedon = now(),
updatedby = 'CDM-33707'
where adoptioncaseactorid ='962735ec-a962-4261-923f-5d46e9f01026';