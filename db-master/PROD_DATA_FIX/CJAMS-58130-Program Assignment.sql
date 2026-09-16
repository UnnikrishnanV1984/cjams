/*
 Issue Description: CJAMS-58130
-- Category/ Module: Person Program
-- Root cause: Invalid case number assinged to Kinship program assignment. Created RCA ticket to find root cause - CIDM-10258
-- Fix Provided: Datafix has been promoted to update the case number.
-- Pull request# N/A
-- Reason why no related code fix:  Created RCA ticket to find root cause - CIDM-10258

*/


update personprogramarea 
set objectid='5fb02c0a-bbc0-4b4e-8711-c0d7b4aebfcc',
    entityid='251030460247',
    updatedon=now(),
    updatedby ='CJAMS-58130'
where personprogramid ='8081b04c-7f49-40a6-b79a-b956d7ef8bc2' and activeflag = 1;

update personprogramarea 
set objectid='5fb02c0a-bbc0-4b4e-8711-c0d7b4aebfcc',
    entityid='251030460247',
    updatedon=now(),
    updatedby ='CJAMS-58130'
where personprogramid ='c65eb7d7-8985-4308-8dbe-881db3383d28' and activeflag = 1;