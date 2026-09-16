/*
-- Issue Description: 
	Data Fix needed for overdue reason
    Original Ticket -CJAMS-68805
    Case - 251023023322
    overdue reason for other children,
    Other children unavailable
-   Family was contacted but unavailable to meet within mandate 
-- Category/ Module: LRR
-- Root cause: LRR Reasons are missing in the case and data fix needed to update the overdue reson for the other children
   Other children: "Other children unavailable > Family was contacted but unavailable to meet within mandate
-- Fix Provided: Data fix has been done to update the LRR Reporting Window.
-- Is Code fix needed: Yes
-- Code fix ticket number:CJAMS-68805
-- Reason why no related code fix: N/A
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason2 = 'VFCM', updatedby ='CJAMS-68805', updatedon =now()
where intakeserviceid='8186c7a0-7c67-4a27-91ef-e445531fefe4' and activeflag = 1;