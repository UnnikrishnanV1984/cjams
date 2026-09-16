-- CIDM-4610 - Scheduled job Prod_ENE_Outbound failed
/*
	05/06 E&E Outbound batch failed due to the below client's education data issue.
	Error: value too long for type character varying(50)

	The case assignment is with Baltimore City user Gregory Lounsbury (greg.lounsbury@maryland.gov)

*/
-- Update Person Eduction Address City Name 
-- Client ID: 200879383 (Kasha Scott) - 3468c8b8-43eb-43cc-9cf4-cba2e78f5088
-- personeducationid: 35b8b0cc-cf4c-4d81-b9af-9199301ff5a7
-- Baltimore, 2500 E Northern Pkwy, Baltimore, MD 21214

-- Client ID: 200772429 (Zainab Kehinde) - e08a1c94-e18c-48e6-87dc-ceee8d868907
-- personeducationid: 81697f58-81f3-4344-843a-b996fd7991ff	
-- Baltimore, 4931 New Town Blvd, Owings Mills, MD 21117

select personid, adrcityname, updatedby, updatedon  
	from personeducation 
where personeducationid in ( '81697f58-81f3-4344-843a-b996fd7991ff', '35b8b0cc-cf4c-4d81-b9af-9199301ff5a7' )
	and activeflag = 1 
	and length(adrcityname) > 50 ; 

update personeducation
set adrcityname = 'Baltimore',
	updatedby = 'CIDM-4610',
	updatedon = now()
where personeducationid = '35b8b0cc-cf4c-4d81-b9af-9199301ff5a7'
	and activeflag = 1 
	and length(adrcityname) > 50 ;

update personeducation
set adrcityname = 'Owings Mills',
	updatedby = 'CIDM-4610',
	updatedon = now()
where personeducationid = '81697f58-81f3-4344-843a-b996fd7991ff'
	and activeflag = 1 
	and length(adrcityname) > 50 ;

-- After
select personid, adrcityname, updatedby, updatedon, length(adrcityname)  
	from personeducation 
where personeducationid in ( '81697f58-81f3-4344-843a-b996fd7991ff', '35b8b0cc-cf4c-4d81-b9af-9199301ff5a7' )
	and activeflag = 1 ;
