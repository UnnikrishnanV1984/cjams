
    /*
  Issue Description:  CDM-33075
   Category/ Module  :  Assessment 
   Root cause: user request 
   Fix Provided : Did data fix to modify user requested dates  
   
*/


update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{panel5220306521670695ColumnsDateofCompletion2}', '"2023-07-18T04:00:00.000Z"')
where assessmentid = '105e143c-7972-4133-89d6-8daf75852550';

update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{placemententrydatetime}', '""')
where assessmentid = '105e143c-7972-4133-89d6-8daf75852550';
