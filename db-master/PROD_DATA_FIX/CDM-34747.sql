/*
 * CDM-34747 - Program Assignment
 * Customer Email ID:brittany.brendel@maryland.gov
 * Customer Name:Brittany Brendel
 * Severity:High
 * Focus Area:Assignments
 * Description - 3218850:I cannot end date this program assignment despite there being no active case with this client except the one we are currently opening. 
 * Need data fix to update the case number 3218850 to the Program Assignment for client Client ID: 4247881
 * Client Name: SUNNI EID
 */

select entityid, objecttypekey, objectid,  * from personprogramarea where personprogramid = '3d104b51-d593-441b-bab8-4485525a0b84';
UPDATE cjams.personprogramarea
SET entityid='3218850', objecttypekey='servicecase', objectid = '01ad4779-f159-4d1c-b1b2-3f76d1ec1eee', updatedby='CDM-34747', updatedon=now() 
WHERE personprogramid='3d104b51-d593-441b-bab8-4485525a0b84'; 

