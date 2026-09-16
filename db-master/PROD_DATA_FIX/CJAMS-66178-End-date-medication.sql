/*
Issue Description: CIDM-66178 End date Psychotropic medication for review screen
Category/Module: Psychotropic review Screen
Root cause: Case number not populating in the Psychotropic medication review screen due to the recent code changes done as the part of CIDM-10687 were duplicate case number issue was fixed.
Fix provided: Data fix has been done for this record to display the case details which were inserted as null in the database
Data/Code fix ticket#: CIDM-66178
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10773
*/

update personmedicpshychotropic
set medicationexpirationdate = '2026-03-05' , updatedby='CIDM-66178', updatedon= now()
where personmedicpshychotropicid='b6bccdf4-43e4-496d-ac07-f9c52d3f9fff' and activeflag = 1;