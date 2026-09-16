-- CIDM-8947 - FTDM meetings data error fixes
-- Please update meeting recording table placement uuid s data to match application
/*
-- Issue Description: 
	To fix FTDM meetings data errors.
   
-- Category/ Module: Meetings (Case Management) 
-- Root cause:CJAMS FTDM meetings and placement association requirement was changed, and the code fix was promoted to production.
-- Fix Provided: Datafix has been promoted to cleanup the FTDM meetings data errors.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix FTDM meetings data errors (CIDM-8947)
update meetingrecording
set placementid = NULL, 
	updatedby = 'CIDM-8947', 
	updatedon = now()
where activeflag = 1
	and placementid is not null
	and meetingrecordingid 
		in (
			'f92f241e-a7f6-4756-9886-55b86e875d50',
			'9c65d126-cc7d-40d9-9ac4-8148d88c0c07',
			'502028a2-ce3e-40af-a8d9-e250caa858b3',
			'8c934ff8-62d4-4e51-9990-19259a213774',
			'd468c675-38ad-47ce-9676-e4b6b6e77f7d',
			'209084df-677a-4340-b6e3-df8599fa3a0b',
			'34ebc773-5d29-4e9a-b446-0736b24c46a0',
			'76c291fb-8ed9-4f3e-9f2a-80e499e9c301',
			'6af355f3-51fd-48dc-b47c-73a80dcc3710',
			'8929ebd4-0ee7-4d20-b87b-50bce62faf47',
			'ef20a776-f3b8-4003-a060-8aa64059003c',
			'0ff604cd-c8d1-4ea6-9e30-d8c4d05f55cc',
			'b038b1d2-9f83-4d64-b41e-39468615223f',
			'c523b811-d47f-4967-9767-63c94b6090d4',
			'307e317d-8354-4070-96b2-20b214b061f1',
			'1c404972-c9ef-4cec-b163-41f6402c2f95',
			'7e232e07-1a61-4356-85d5-6af9b20ad562',
			'4fe45c1f-a1c1-4e75-ba9c-22099974c925',
			'29c46ade-6fb8-41a0-96f4-4bc56234e848',
			'6ecc4968-21e1-445d-a246-d411ef2ed0cd',
			'a2bcb6a7-bc44-4443-aef6-a81f9d68213d',
			'155c892f-bcec-4fc3-9a23-120ff5219227',
			'ca02623e-699b-4bd0-9d50-7e5e08e02e85'
			) ;
