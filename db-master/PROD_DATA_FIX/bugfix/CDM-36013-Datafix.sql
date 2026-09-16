/*
 * CDM-36013 - child removal date
 * Customer Email ID: arletha.king@maryland.gov
 * Customer Name: Arletha King 
 * Focus Area:Child Removal
 * Description - 3282116:Remove the draft child removal record from CJAMS
 */

-- Removal of Draft child record 
UPDATE intakeservreqchildremoval
SET activeflag=0, updatedby='CDM-36013', updatedon=now() 
where intakeservreqchildremovalid='951b8418-5816-4388-a55a-3166e03f9d32';

UPDATE intakeservreqchildremoval_history
SET activeflag=0, updatedby='CDM-36013', updatedon=now() 
where intakeservreqchildremovalid='951b8418-5816-4388-a55a-3166e03f9d32';