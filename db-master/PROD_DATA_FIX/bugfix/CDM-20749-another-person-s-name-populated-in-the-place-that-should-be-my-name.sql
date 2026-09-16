-- CDM-20749-another-person-s-name-populated-in-the-place-that-should-be-my-name
/*
-- Issue Description: 
	1.Another person name is populated instead of supervisor 
	
-- Root cause: 
---Fix : This case is updated as with personprogram id so that it shown with his own name 

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.personprogramarea set
insertedby = 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6',
updatedby = 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6',
updatedon=now()
where personprogramid = 'd5ccd8be-f8fc-4a22-b351-780e971cc5e4';