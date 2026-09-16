-- CDM-34617 - Rate Approval
/*
-- Issue Description: 
   Old Adoption rate in review status is preventing the submission of the new rate year.
      
-- Adoption Case ID: 3216115
-- Client ID: 3410833 (IVORY ALTHEA ALLEN) - 954e89a7-f9b4-4b2f-b27b-1b50fec1b57d
-- Adoption ID: 35514 - 2012-07-18 To 2027-09-28 - d534ff3f-9376-46a7-b11b-d535110286df
-- Provider ID: 5054314	(Althea Allen)
-- Delete 
-- Rate ID: 35f6fcba-5d99-456b-8326-bad0732abb61 - 2020-07-01 04:00:00	2021-06-30 08:00:00	833	Rejected	3045	

-- Update status as Approved
-- Rate ID: 96c7ecfc-0e38-4c52-897b-38bf88793dae - 2020-07-01 04:00:00	2021-06-30 04:00:00	835	Review	3047	

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Old duplicate adoption rate in review status is preventing the submission of the new rate year.
-- Fix Provided: Datafix has been promoted to remove the duplicate adoption rate in review status. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove duplicate adoption rate in review status (CDM-34617)

-- Delete 
-- Rate ID: 35f6fcba-5d99-456b-8326-bad0732abb61 - 2020-07-01 04:00:00	2021-06-30 08:00:00	833	Rejected	3045	
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, approvalstatustypekey, status, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementrateid = '35f6fcba-5d99-456b-8326-bad0732abb61'
	and activeflag = 1;

update adoptioncaserevision
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-34617'
where adoptionagreementrateid = '35f6fcba-5d99-456b-8326-bad0732abb61'
	and activeflag = 1;

select routingid, eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon
	from routing
where objectid = '35f6fcba-5d99-456b-8326-bad0732abb61'
	and eventcode = 'AARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-34617'
where objectid = '35f6fcba-5d99-456b-8326-bad0732abb61'
	and eventcode = 'AARR'
	and activeflag = 1 ;
		
		
-- Update status as Approved
-- Rate ID: 96c7ecfc-0e38-4c52-897b-38bf88793dae - 2020-07-01 04:00:00	2021-06-30 04:00:00	835	Review	3047	

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, approvalstatustypekey, status, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementrateid = '96c7ecfc-0e38-4c52-897b-38bf88793dae'
	and activeflag = 1;
		
update adoptioncaserevision
set status = 'Approved',
	updatedon = now(), 
	updatedby = 'CDM-34617'		
where adoptionagreementrateid = '96c7ecfc-0e38-4c52-897b-38bf88793dae'
	and activeflag = 1;
	