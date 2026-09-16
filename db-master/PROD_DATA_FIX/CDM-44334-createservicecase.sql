-- CDM-44334-Dummy case connected to referral
-- Issue Description: Remove / Delete  New case-251023022081 Connect the Referral - I251013251092 to the new Service case  
-- Need data fix to Delete the service case 251023022081 and link the new case.
-- Resolution: Updated the servicecaseid to null in intakeservicerequest and updated activeflag to 0  in servicecase 
-- Category/ Module: Case Management
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

select * from createservicecase('192bb3e6-cbfa-431b-bd22-9f2a9638fb26', null,1,'e4bcec66-b8ef-476f-915c-375f6c71a5d1','intake');

update servicecase
set startdate = '2025-03-25 16:13:38', insertedon ='2025-03-25 16:13:38'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='192bb3e6-cbfa-431b-bd22-9f2a9638fb26'
                     );
                     
update servicecasedisposition                     
set statusdate = '2025-03-25 16:13:38'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='192bb3e6-cbfa-431b-bd22-9f2a9638fb26'
                     );
