-- CDM-17788 - GAP RATE Approval Issue
/*
-- Issue Description: 
   GAP RATE Approval Issue for the follwoing Cases
	3240698 - KA'MANI JOHNSON
	3206693 - AMIRA HARRIS
	3282147 - Xzavior Jones
	3282147 - Karter Jones
	3280147 - Isabella Alampi
	3264883 - Saul Perez
	3264883 - Natalie Michelle Carney
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: deployed in Prod 10/22
*/

/*
Case ID: 3240698
Client ID: 3541944 (KA'MANI JOHNSON)- 92266e93-02f1-468f-bb80-cc1dccc074b7
GAP ID: 4370 - 6493d030-60bb-42ec-863a-6d3f4fcebcf5 - 5075712
gapagreementrateid: 13498fab-3233-4c86-9070-313cfd7b26c2

Case ID: 3206693
Client ID: 3352771 (AMIRA HARRIS) - 6cba8e1a-ba0f-4973-85b6-c19568417db4
GAP ID: 2842 - 51621173-f832-44cb-bdae-c52f825adbaf
gapagreementrateid: a8ef38d5-98fc-4306-b120-0f0dd812591a

Case ID: 3282147
Client ID: 3438939 (XZAVIOR	A JONES) - 3cabfa4b-bf25-465a-8ab5-87ef7d07ca41
GAP ID: 5139 - afa9ab76-09cd-4fa2-942a-5fe87c90e752
gapagreementrateid: 35f7d4d7-6004-47e5-95ad-bba3bf9ef608

Case ID: 3282147
Client ID: 4159819 (KARTER JONES) - 92426c7a-0290-4e20-862b-6d290286f835
GAP ID: 5138 - 2a274ef7-3d08-4300-a1f7-b4e55806f6b3
gapagreementrateid: 8fa52efe-ab4e-4107-a72e-03593913f59c

Case ID: 3280147
Client ID: 4141115 (ISABELLA ALAMPI) - 7ea0ef66-816e-4bb1-b229-f787773fcfc1
GAP ID: 1005569 - f9fbb95f-8601-4ec9-8486-fa9bc857d1fa
gapagreementrateid: c881eeac-a30e-4deb-b08a-026fd89b25df

Case ID: 3264883
Client ID: 3678325 (SAUL PEREZ) - b87efee2-3c71-4041-b79e-ffe0cd3c6714
GAP ID: 4654 - 049a6376-e2b5-4205-9d5b-bf0e2803e342
gapagreementrateid: 4e69aed6-b82e-4ae1-b81d-d8f7a7f8a6ca

Case ID: 3264883
Client ID: 3925534 (NATALIE	MICHELLE CARNEY) - b8fdd724-1e61-40ef-ad4a-9c4989c0ff17
GAP ID: 4655 - 0b26b4a8-df48-467f-ae7f-be15885faa76
gapagreementrateid: 9b4e0b2b-487e-49d3-ab9e-5a56a30add60
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid in 
	( 	'13498fab-3233-4c86-9070-313cfd7b26c2',
		'a8ef38d5-98fc-4306-b120-0f0dd812591a',
		'35f7d4d7-6004-47e5-95ad-bba3bf9ef608',
		'8fa52efe-ab4e-4107-a72e-03593913f59c',	
		'c881eeac-a30e-4deb-b08a-026fd89b25df',
		'4e69aed6-b82e-4ae1-b81d-d8f7a7f8a6ca',
		'9b4e0b2b-487e-49d3-ab9e-5a56a30add60'
	)
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17788',
	updatedon = now()
where gapagreementrateid in 
	(	'13498fab-3233-4c86-9070-313cfd7b26c2',
		'a8ef38d5-98fc-4306-b120-0f0dd812591a',
		'35f7d4d7-6004-47e5-95ad-bba3bf9ef608',
		'8fa52efe-ab4e-4107-a72e-03593913f59c',
		'c881eeac-a30e-4deb-b08a-026fd89b25df',
		'4e69aed6-b82e-4ae1-b81d-d8f7a7f8a6ca',
		'9b4e0b2b-487e-49d3-ab9e-5a56a30add60'	
	)
	and lower(status) = 'review' 
	and activeflag = 1 ;
