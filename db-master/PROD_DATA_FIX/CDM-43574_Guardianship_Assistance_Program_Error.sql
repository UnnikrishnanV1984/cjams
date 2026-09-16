/*
-- Issue Description: 
The Guardianship Start date is incorrect.
 It is auto populated from the court details tab. It notes that custody and guardianship was completed on 7/18/24 court date when it actually was awarded on 10/24/24.
  This needs to be fixed in the court tab so that the correct date is auto populated in the permanency plan tab. 
-- case ID: 231030057016 
-- Start date: 10/24/2024
-- Negotiated Amount - 902.00$
Rate override check box should be selected
    
-- Category/ Module: GAP (Case Management) 
-- Root cause: User incorrectly entered the subsidy rate amount with per day rate and need to update to $902.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB

*/
-- update Guardianship Start Date from 2024-07-18 04:00:00 to 2024-10-24 04:00:00
/*
select startdate,enddate,* from gapagreement where gapagreementid= 'a7eb7b50-46d8-47a8-a6e2-1bdebdca4a10'--gapid = '8a477646-ad17-4d34-b0b1-d92c9c09f3ed'
*/

update 	gapagreement
set 	startdate = '2024-10-24 04:00:00', --2024-07-18 04:00:00
		updatedby = 'CDM-43574',
		updatedon  = now()
where 	gapagreementid = 'a7eb7b50-46d8-47a8-a6e2-1bdebdca4a10';



-- Update GAP Rate & Rate Revision
/*
select startdate,enddate,ssaapprovaldate,isoverride,* from gapagreementrate where gapagreementrateid  = '607354bd-7c2b-4537-b9dd-30e6682594c7';
*/

update gapagreementrate  
set paymentamout = 902.00,
	--ssaapprovaldate = '2024-10-04',
	isoverride  = true,
	updatedon = now(), 
	updatedby = 'CDM-43574'
where gapagreementrateid = '607354bd-7c2b-4537-b9dd-30e6682594c7'
	and gapagreementid = 'a7eb7b50-46d8-47a8-a6e2-1bdebdca4a10'
	and activeflag = 1 ;

--gapid: 8a477646-ad17-4d34-b0b1-d92c9c09f3ed
--gapagreementid: a7eb7b50-46d8-47a8-a6e2-1bdebdca4a10


/*
select paymentamt, approvaldate, approvalstatustypekey, activeflag, updatedby, updatedon,*
	from gapratesrevision
where gaprateid = '607354bd-7c2b-4537-b9dd-30e6682594c7' ;
*/
/*
select picklist_value_cd , value_tx, *
from cjams.tb_picklist_values tpv where btrim(picklist_value_cd ) in ('3047','3045')
*/
update gapratesrevision
set paymentamt = 902.00,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-43574'
where gaprateid = '607354bd-7c2b-4537-b9dd-30e6682594c7'
and activeflag = 1;

