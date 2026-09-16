/*
   Issue Description: CDM-33225
   Category/ Module  : Investigation Maltreatment 
   Root cause: Duplicate maltreat records inserted on same time 
   Fix Provided: Did data fix to remove the duplicate one
*/

update cjams.investigationmaltreatment set activeflag =0 , updatedby ='CDM-33225', updatedon = now()
where maltreatmentid ='07731fa7-be6b-4f14-9f8a-f999875cb9d3';

update cjams.Investigationallegation set activeflag =0 , updatedby ='CDM-33225', updatedon = now()
where maltreatmentid ='07731fa7-be6b-4f14-9f8a-f999875cb9d3';