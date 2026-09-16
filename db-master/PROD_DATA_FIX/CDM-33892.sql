/*
 * CDM-33892 - Lost HOH/Alleged Maltreator
 * Customer Email ID:susan.kansler@maryland.gov
 * Customer Name:Susan Kansler
 * Focus Area:Persons: Household
 * Description - 1020691210:Hello, I cannot close my case as the HOH/Alleged Maltreator, Tanika Durant is no longer populated in the persons tab. 
 * However, if I try to re-add her I get a pop up that states, "Person entered already exists in this Case"
 * CJAMS PID# 1854245 is missing in CPS Case 231020691210 as well the intake I231010765820.
 */

select isprimary, * from intakeservicerequestactor where intakeservicerequestactorid = '0c0ffe4e-84ab-408e-a80a-4a7976b035a9';
UPDATE cjams.intakeservicerequestactor
SET isprimary=true, updatedby='CDM-33892', updatedon=now() 
WHERE intakeservicerequestactorid='0c0ffe4e-84ab-408e-a80a-4a7976b035a9'::uuid; 
