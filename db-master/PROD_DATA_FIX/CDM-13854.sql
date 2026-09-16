--Need to Remove Duplicate from removal history 
--Checked placement table and it was not linked to  deleted id 

update  cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-13854', updatedon =now()  where intakeservreqchildremovalid='43d87420-44f5-4f06-a5af-7c4066ccab5c';