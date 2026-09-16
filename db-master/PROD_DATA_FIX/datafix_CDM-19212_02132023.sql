/*
	Issue Description: CDM-19212	Court
	email : shara.hayden@maryland.gov
	3286122:How to remove siblings from court hearing and court order who have achieved permanency.

	Court Order:
	1. remove the Court Order record for Angel & Princess Gonzalez on 06/25/2021 and 12/07/2021
	2. remove the Court Order record for Brianna Alecia Gonzalez & Prince Gonzalez on 02/12/2021

*/

update hearingclients
set activeflag = 0,
	updatedby = 'CDM-19212',
	updatedon = now()
where hearingclientid in (
'11ca9898-5586-4a57-984a-0186414750ba',  
'db2bc073-77f4-4225-8b9d-e8dd46f432d5', 
'99b55cb3-779e-4519-9d76-fe674a19d73a', 
'd10cda4a-911a-48b8-b6cc-7411363fc77e',
'8a486e7b-e95f-40b8-bbb4-14fa26266ea8', 
'e499a9fc-27e8-45e8-8a27-73c15fe586cb'
);
update intakeservicerequestpetitionactor
set activeflag = 0,
	updatedby = 'CDM-19212',
	updatedon = now()
where intakeservicerequestpetitionid = 'e2355903-666d-44c2-a7ce-983143b286fd' and 
intakeservicerequestpetitionactorid in (
'48bf437c-1bd3-40ed-bbb7-ac485ecebacb',
'14b9f9f9-9b8f-4e7f-83c2-2d7a1c6e7363',
'dcadeac9-6d5d-4f72-8d66-30edf1001038',
'b3b73a97-4dda-476c-b29e-c17db4a1b996'
);
