/*
   Issue Description: CDM-20355
   Category/ Module  : Wrong client added
   Root cause: user added wrong child to the intakecase
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--ASSESSMENT DELETE 
UPDATE assessment SET activeflag = 0,
updatedby = 'CDM-20355',
updatedon = Now() 
WHERE assessmenttemplateid='9d458bdf-c061-4068-a63b-ba80bb58819a' 
AND  servicecaseid = '1ad69f45-95a3-43cc-8a00-9fe0f4dfda74'  
AND assessmentstatustypekey='Review'  
AND activeflag=1
AND assessmentid IN
			(
			'14a78491-0970-4443-a512-5df7d956581f');


--ASSESSMENT DELETE 
UPDATE assessment SET activeflag = 0,
updatedby = 'CDM-20355',
updatedon = Now() 
WHERE assessmenttemplateid='9d458bdf-c061-4068-a63b-ba80bb58819a' 
AND  servicecaseid = '126f0098-2d30-4a12-9f43-c51839bcfd6f'  
AND assessmentstatustypekey='Review'  
AND activeflag=1
AND assessmentid IN
			(
			'a4ae3c19-768b-49a7-b05b-ad0e37b8dc87');
 

