/*
   Issue Description: CDM-36627
   Category/ Module  : Maltreatment / AR Summary
   Root cause: As requested by user, There is a duplicate maltreatment displayed in the AR Summary and data fix is needed to remove the duplicate record.
*/

update Investigationmaltreatment 
set    activeflag = 0,
       updatedby = 'CDM-36627',
       updatedon = now()
where  maltreatmentid = '7a09871d-201a-4920-b1f5-438fff639f82';

update investigationmaltreatmentactor 
set    activeflag = 0,
       updatedby = 'CDM-36627',
       updatedon = now()
where  investigationmaltreatmentactorid = '582e9cba-1b10-4624-9eb5-3f1465a6823e';

update investigationallegation 
set    activeflag = 0,
       updatedby = 'CDM-36627',
       updatedon = now()
where  maltreatmentid = '7a09871d-201a-4920-b1f5-438fff639f82' and 
       investigationmaltreatmentactorid = '582e9cba-1b10-4624-9eb5-3f1465a6823e';
