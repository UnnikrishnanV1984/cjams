
/*
   Issue Description: CDM-33015
   Category/ Module  : Person Program Area
   Root cause: user requested ti end date the ADP program assignment f
   Fix Provided : Did data fix to update end date 

*/

update cjams.personprogramarea set enddate ='2023-07-11 00:00:00', updatedby ='CDM-33015', updatedon =now()
where personprogramid ='d4b91254-88d3-40f5-8759-aee51b53e3ff';