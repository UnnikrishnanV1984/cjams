/*
--	Issue Description: CJAMS-59532  Drop down reasons missing from Legislative Required Reporting window

-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to update the LEgislative report.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    updatedby ='CJAMS-59532',
    updatedon =now()
where intakeserviceid = '7239b60e-626a-4958-aadb-79efcb22f321'
and cpsresponsetimeractionsid = 'add9da8b-3e27-40bc-84c2-8d8585a70d9b'
and activeflag = 1;