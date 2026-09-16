/*
 * CDM-39463 - Unable to enddate assignment
 * Customer Email ID:kathleen.king@maryland.gov
 * Description - 241021914384:Case assignment should be closed. Supervisor sent this case to another supervisor 
 * requesting closure on worker's behalf while out. This resulted in it going back and RE-end-dating my family 
 * responsibility instead of end dating hers. (My original end-date would have 
 * been 2/29/24 when I transferred the case to her tree.)
 * Need data fix as below: 
 * 1. End-date the Family assignment for Stephanie Weber with 05/29/2024
 * 2. Update the the Family assignment end-date for Kathleen King from 05/29/2024 to 02/29/2024.
 * 
 */

update caseassignment set enddate= '2024-05-29 00:00:00',updatedby ='CDM-39463',updatedon = now() where caseassignmentid = 'bab6a6a1-cd11-418c-8b0b-aa2dd408b942';
update caseassignment set enddate= '2024-02-29 00:00:00',updatedby ='CDM-39463',updatedon = now() where caseassignmentid = '8e092842-672e-401e-b35d-f1fb6355d666';
