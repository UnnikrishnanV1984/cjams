/**
 * 
 * CDM-33624 - Child marked as seen but not seen yet
 * Customer Email ID:michelle.delovich@maryland.gov
 * Customer Name:Michelle Delovich
 * Focus Area:Persons: Household
 * 231020666537:Contact ID: 11032331, Contact ID: 11022287Child Kennedy was marked as seen but child was not seen.  
 * delete or modify these contact notes
 * At this case, and I do see the specified child on Contact ID 11022287, but not on Contact ID 11032331. 
 * Received SSA approval to remove the specified child from Contact ID 11022287.
 * 
 */

select contactparticipantid,* from contactparticipant where 
contactparticipantid = 'd97d5f86-dda1-47b7-af20-ad2dd779a5db' and 
intakeservicerequestactorid = '2ae64c32-ca89-4b61-bbf8-e256abe3a343';

UPDATE cjams.contactparticipant
SET activeflag=0, updatedby='CDM-33624', updatedon=now()  
WHERE contactparticipantid='d97d5f86-dda1-47b7-af20-ad2dd779a5db'::uuid; 