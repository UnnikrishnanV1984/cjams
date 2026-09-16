/*
-- Issue Description: 
	Data Fix needed for overdue reason
    Original Ticket - CDM-44407
    Case - 251023023322
    overdue reason for other children,
    Other children unavailable
-   Family was contacted but unavailable to meet within mandate 
-- Category/ Module: LRR
-- Root cause: LRR Reasons are missing in the case and data fix needed to update the overdue reson for the other children
   Other children: "Other children unavailable > Family was contacted but unavailable to meet within mandate
-- Fix Provided: Data fix has been done to update the LRR Reporting Window.
-- Is Code fix needed: Yes
-- Code fix ticket number: CDM-44407
-- Reason why no related code fix: N/A
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason4 = 'OOCN',
    cpsresponsetimerreason5 = 'OFMN',
    updatedby ='CIDM-10561',
    updatedon =now()
where intakeserviceid = '9391de3d-2ca7-4311-bc26-63dcf4becc94'
and cpsresponsetimeractionsid = 'ddafa812-fbbf-40da-9d91-bdb1c58e8952'
and activeflag = 1;