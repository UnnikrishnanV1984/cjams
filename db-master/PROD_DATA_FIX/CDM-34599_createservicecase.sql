-- CDM-34599-Incorrect case connected to referral
-- Issue Description: Remove / Delete  New case -  231030196606 Connect the Referral - I231011278835 to the old closed Service case 3296243 
-- Need data fix to Delete the service case 231030196606 and link the case with 3296243.
-- So user can proceed with intake override. 
-- Resolution: Updated the servicecaseid to null in intakeservicerequest and updated activeflag to 0  in servicecase 
-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A


update 	intakeservicerequest 
set		servicecaseid = NULL , updatedby = 'CDM-34599', updatedon = now()
WHERE 	servicerequestnumber = '231021171650' and activeflag = 1;

update 	servicecasedisposition 
set 	activeflag = 0, updatedby = 'CDM-34599', updatedon = now() 
where 	servicecaseid = '204420e5-709f-43bd-a554-48b1b17827a1' and activeflag = 1;

update 	cjams.routing 
set 	activeflag =0,  updatedby = 'CDM-34599', updatedon = now() 
where 	routingid in ('204420e5-709f-43bd-a554-48b1b17827a1') and activeflag = 1;

UPDATE cjams.servicecase
SET activeflag=0, updatedon=now(), updatedby='CDM-34599'
WHERE servicecaseid='204420e5-709f-43bd-a554-48b1b17827a1'::uuid and servicecasenumber='231030196606';

select * from createservicecase('d2aa6cbd-3b6b-428c-87c4-93c5b96b9dde', '6f7e9069-5319-4a0e-b861-9fa852f814e5',0,'68ded231-16ad-4c93-a496-273eb0a62c02','intake');

update servicecasedisposition                     
set statusdate = '2023-10-02 09:23:00', effectivedate = '2023-10-02 09:23:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='d2aa6cbd-3b6b-428c-87c4-93c5b96b9dde'
                     ) and intakeserreqstatustypekey = 'Open' and "comments" = 'Case Reopened';
