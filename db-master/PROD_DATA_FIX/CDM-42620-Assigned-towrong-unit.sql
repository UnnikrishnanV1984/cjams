/*
    -- Issue Description: CDM-42620
    -- Category/ Module  : Assigned to wrong unit
    -- Root cause: User was assigned to wrong unit.
*/

update teammemberassignment
set updatedby='CDM-42620', updatedon=now(), teammemberid='c191c373-6728-49dd-9df7-0b043e8b5984'
where teammemberassignmentid='77cea88d-e6e7-467d-960a-8aa2e0d55d36' and activeflag=1;