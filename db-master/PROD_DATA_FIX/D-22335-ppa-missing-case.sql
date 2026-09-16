UPDATE personprogramarea
SET entityid = '20190343014071'
WHERE 
personprogramid IN (
'ad4fa567-9905-4706-8f51-20e56779a2ec', '630095f8-d089-4c97-a640-9f376a63b438'
);

DELETE FROM personprogramarea
WHERE personprogramid = '70259647-66eb-42d2-8d78-da2b3c2aa951';