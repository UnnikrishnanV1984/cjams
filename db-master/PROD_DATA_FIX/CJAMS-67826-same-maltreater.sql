/*
   Issue Description: CJAMS-67826
   Category/ Module  : Investigation Maltreatment 
   Root cause: Duplicate maltreat records inserted on same time 
   Fix Provided: Did data fix to remove the duplicate one
*/

update cjams.investigationmaltreatment set activeflag =0 , updatedby ='CJAMS-67826', updatedon = now()
where maltreatmentid ='02636252-552c-4bcf-8f10-c4bdab0e35e9' and activeflag = 1;

update cjams.Investigationallegation set activeflag =0 , updatedby ='CJAMS-67826', updatedon = now()
where maltreatmentid ='02636252-552c-4bcf-8f10-c4bdab0e35e9' and activeflag = 1;