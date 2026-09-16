-- CDM-22896 Expungement/duplicate client
/*
-- Issue Description: 
	For this CPS-AR CW2938011 the Expungement Forecast Date is 06/07/2022, 
 
	But another CPS-AR 20200153019848 came in 6/1/20 although the individual has 2 client ID #'s.  
	   
-- Category/ Module: CPS-AR Investigation (Expungement)
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Duplicate Clients

CPS-AR CW2938011 - 39b63233-be94-4c2b-97b5-c1144bde12bf (expungement Date: 06/07/2022)
4398663 (MAHBUBA HUSSAIN) - 82cb17b2-63cb-4e7a-a4c7-4195a664671b
4398662	(AFSARA	N NOWRIN) -	6256efb8-fcb2-4242-a9c3-9b4f592de015
4398664	(ABDUL BEPARY) - 958cdd74-d58b-4e46-b9f3-eed49278de3e

CPS-AR 20200153019848 - 5e9cad1d-cd50-44ca-915f-855dbea9297e (expungement Date: 06/01/2023)
200012561 (Mahbuba Hussain)- 3b7ae54d-af8e-493a-bf3e-342a9489ea7f
200012567 (Afsara Nowrin) - 326af463-816d-479b-bea1-07da8e69f8ce
200012564 (Abdul Bepary) - e3358a50-2b75-4774-ac93-88efa0663ad2
*/

-- To prevent expungement of CPS-AR CW2938011
INSERT INTO cjams.donotexpunge
	(	donotexpungeid, 
		intakeserviceid, 
		donotexpunge, 
		donotexpungejustification, 
		releasedon, 
		releasejustification, 
		insertedon, 
		insertedby, 
		updatedon, 
		updatedby, 
		activeflag
	)
VALUES
	(	gen_random_uuid(), 
		'39b63233-be94-4c2b-97b5-c1144bde12bf', 
		true, 
		'CPS-AR 20200153019848 is a Subsequent case, but having different Client ID for the same Alleged Maltreator.', 
		NULL, 
		NULL, 
		now(), 
		'CDM-22896', 
		now(), 
		'CDM-22896', 
		1
	);
