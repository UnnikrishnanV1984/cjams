/*
-- Service case: 261023743372   
-- Category/ Module: Contact Note 
-- Root cause: Wrong date got updated by user and requested to correct the contactdate with 04/25/2026
-- Fix Provided: Data fix was provided by updating the contactdate with 04/25/2026 as requested
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update progressnote
set contactdate='2026-04-25 00:00:00', starttime='2026-04-25 20:00:00', updatedby='CJAMS-69308', updatedon=now()
where witsid='16175535' and progressnoteid='f84679e8-4553-432e-bd0a-979aa75dfd5b';

select *  from cjams.cpsresponsetimerupdate('f4c652b0-50de-4e6e-9271-2861456cc936'::uuid, 'CJAMS-69308'::character varying);
