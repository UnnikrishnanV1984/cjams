-- CIDM-4442 - Update only the City name in the Field
/*
	04/13 E&E Outbound batch failed due to the below client's education data issue.
	Error: value too long for type character varying(50)

	Case Number : 3127423
	Client ID: 1773794 (DANIEL L GATTIS-ADAMS) - 4d3489ac-31e9-43f5-9323-960aed50e30f
	The case assignment is with Baltimore City user Gregory Lounsbury (greg.lounsbury@maryland.gov)

*/
-- Update Person Eduction Address City Name 
-- Baltimore, 2301 Gwynns Falls Pkwy, Baltimore, MD 21217
select personid, adrcityname, updatedby, updatedon  
	from personeducation 
where personeducationid = '29de8944-0dc2-4175-92b2-df7b24e49b11'
	and activeflag = 1 
	and length(adrcityname) > 50 ; 

update personeducation
set adrcityname = 'Baltimore',
	updatedby = 'CIDM-4442',
	updatedon = now()
where personeducationid = '29de8944-0dc2-4175-92b2-df7b24e49b11'
	and activeflag = 1 
	and length(adrcityname) > 50 ;

-- After
select personid, adrcityname, updatedby, updatedon, length(adrcityname)  
	from personeducation 
where personeducationid = '29de8944-0dc2-4175-92b2-df7b24e49b11'
	and activeflag = 1 ;
