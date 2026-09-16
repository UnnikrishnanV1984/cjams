/* 
    Issue Description : CDM-28069
    Category/ Module : CJAMS 31228 Issue not corrected
    Root cause : User wants to delete  program assignment and update the case number
   user want to  Update the Investigate Response with Alternative Response and Enter the end date and updated by as the picture.
*/

-- Client ID: 200933524
-- Client Name: Harrison Leidig


UPDATE
    personprogramarea
SET
    activeflag = 0,
    updatedby = 'e4b5f055-b967-4b2b-9f44-04d76dbcc2d7',
    updatedon = now()
WHERE
    personprogramid = 'a39c2b23-5395-4d28-a5d7-4ff8f0a4cabf';


UPDATE
    personprogramarea
SET
    entityid = '221020233622',
    updatedby = 'e4b5f055-b967-4b2b-9f44-04d76dbcc2d7',
    updatedon = now()
WHERE
    personprogramid = '10b337d6-c472-492d-8286-d42005933709';


-- Client ID: 200933509
-- Client Name: Phillup Thomas

update
    personprogramarea
set
    subprogramkey = 'AR',
    enddate = '2022-08-22 00:00:00',
    updatedon = now(),
    updatedby = 'e4b5f055-b967-4b2b-9f44-04d76dbcc2d7'
where personprogramid = 'df2472cc-2925-4ac3-927f-fbcbdb48b6f4';