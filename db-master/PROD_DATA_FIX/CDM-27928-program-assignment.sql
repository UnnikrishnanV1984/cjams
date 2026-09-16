/* 
    Issue Description : CDM-27928
    Category/ Module : Program assignment
    Root cause : User wants to delete duplicate program assignment
*/

-- Client ID: 1236890
-- Client Name: SHIRLEY SMITH


UPDATE
    personprogramarea
SET
    activeflag = 0,
    updatedby = 'CDM-27928',
    updatedon = now()
WHERE
    personprogramid in (
        '7526f2cf-eade-455f-97d3-6d29b8e0fea1',
        'db463d12-8bbe-42ce-8a97-7236aa8d6df5'
    );
