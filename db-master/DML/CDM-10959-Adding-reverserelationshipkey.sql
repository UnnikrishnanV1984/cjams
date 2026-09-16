-- Adding Reverse relationship for "No Relation" relationshiptypekey 
INSERT INTO cjams.reverserelationship values(cjams.gen_random_uuid(), 'NORLTN', null, 'NORLTN','NORLTN', 'admin', current_timestamp ,'admin', current_timestamp);
