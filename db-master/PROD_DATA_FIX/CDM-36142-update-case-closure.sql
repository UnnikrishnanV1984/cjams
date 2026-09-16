-- CDM-36142-- 
/*
-- Issue Description: 
 --Case Closure Date Data fix

-- Customer Email ID: lauren.harbaugh@maryland.gov
-- Root cause: Data fix to update date for the case closure
-- Resolution: Data fix is provided to close the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



select * from routing where routingid = 'd73ac410-7e74-4566-a93a-27080300e1d5';

select reviewcomments,insertedon,* from cjams.intakeservicerequestdispositioncode where intakeservicerequestdispositioncodeid='396e13a0-0243-40de-8c54-cf3d97219708';

update cjams.intakeservicerequestdispositioncode set insertedon='2023-12-11 08:18:54',
updatedby = 'CDM-36142', updatedon = now(),
reviewcomments='case closure occurred on 12/11/2023, system defect caused the closing date to incorrectly reflect 12/26/23. Date was corrected following correction of system defect.'
where intakeservicerequestdispositioncodeid='396e13a0-0243-40de-8c54-cf3d97219708';


update routing set insertedon = '2023-12-11 08:57:23',
updatedby = 'CDM-36142', updatedon = now()
where routingid = 'd73ac410-7e74-4566-a93a-27080300e1d5';