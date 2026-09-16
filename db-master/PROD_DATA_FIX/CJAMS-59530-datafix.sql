-- CJAMS-59530  Drop down reasons missing from Legislative Required Reporting window

/*
--	Issue Description: 
	User requested to update the Overdue Reason drop down 
-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to update the Overdue Reason drop down 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VFCM',
    updatedby ='CJAMS-59530',
    updatedon =now()
where intakeserviceid = '86f8a62a-3797-4fc2-832a-84ceb7d37b97'
and cpsresponsetimeractionsid = 'e7f331f6-4e6e-41b6-b758-c1d5c8d569e4'
and activeflag = 1;