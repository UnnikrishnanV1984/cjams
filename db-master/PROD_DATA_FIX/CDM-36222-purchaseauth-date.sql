
-- CDM-36222 - Incorrect Address on Funding Request Form
/* Issue Description:Incorrect Address on Funding Request Form.

-- Category/ Module:Services: Other

-- Root cause: User request to update address on funding request form
-- Fix Provided: Datafix has been updated for address on funding request form 
-- Pull request# N/A
*/


select * from userprofileaddress where countyid = '9f60d4f1-4004-474f-a432-a19da7b1efe0' and activeflag = 1;  


update userprofileaddress set address='207 South 3rd St.', city = 'Denton', state = 'MD', zipcode = '21629',
updatedby = 'CDM-36222', updatedon = now()
where countyid = '9f60d4f1-4004-474f-a432-a19da7b1efe0' and activeflag = 1;

select ldss_address , * from tb_slpa_snapshot where authorization_id = 2778196;

update tb_slpa_snapshot set ldss_address = '207 South 3rd St. Denton, MD 21629' where authorization_id = '2778196';