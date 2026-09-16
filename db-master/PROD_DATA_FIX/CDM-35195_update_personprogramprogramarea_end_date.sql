/*
   Issue Description: CDM-35195  
   Category/ Module  :  personprogramarea
   Root cause: user closed case before closing perperson program area 
   Fix Provided: Provided a data fix to end the open Program Assignment for the CPS IR case 2021085095760 for the CJAMS ID 4108290 as per the CPS case completion date 5/28/21. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select *from personprogramarea where personprogramid='e0a37495-4372-47bf-ba62-c4fb55dea27b' and activeflag=1;


update personprogramarea 
set enddate = '2021-05-28 00:00:00',
updatedby = 'CDM-35195', 
updatedon = now() 
where personprogramid = 'e0a37495-4372-47bf-ba62-c4fb55dea27b' 
and activeflag=1;