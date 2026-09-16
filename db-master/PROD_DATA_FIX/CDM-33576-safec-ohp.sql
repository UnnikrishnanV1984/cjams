
/*
   Issue Description: CDM-33576
   Category/ Module  : Assessment 
   Root cause:  code issue it is always taking old data will do code fix as part of CIDM-7676 
   Fix Provide: Did data fix to update correct address 
*/

	update assessment 
    set submissiondata = replace(submissiondata::text, '20025 Gilbert Hills Hagerstown MD 21742', '12906 Pinehill Hagerstown MD 21740')::json
	WHERE assessmentid = 'ae3eda8b-5973-41f1-953a-3c55fc4dde17' AND activeflag = 1;

	update assessment 
    set submissiondata = replace(submissiondata::text, '20025 Gilbert Hills Hagerstown MD 21742', '12906 Pinehill Hagerstown MD 21740')::json
	WHERE assessmentid = '3c87a2c6-688a-4a1d-b6cc-784bbe1c585c' AND activeflag = 1;

	update assessment 
    set submissiondata = replace(submissiondata::text, '20025 Gilbert Hills Hagerstown MD 21742', '12906 Pinehill Hagerstown MD 21740')::json
	WHERE assessmentid = 'fb13497d-9a60-4fa5-ba57-8ea059db0c03' AND activeflag = 1;