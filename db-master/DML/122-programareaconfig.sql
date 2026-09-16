DELETE FROM programareaconfig WHERE subprogramkey = 'ROA';
INSERT INTO programareaconfig (programkey, subprogramkey, servicerequestsubtypekey,insertedby,updatedby, insertedon, updatedon)
 VALUES('AXYS','ROA','IHM','admin','admin',now(),now());
 
DELETE FROM programareaconfig WHERE subprogramkey = 'VPS';
 INSERT INTO programareaconfig (programkey, subprogramkey, servicerequestsubtypekey,insertedby,updatedby, insertedon, updatedon)
 VALUES('AXYS','VPS','IHM','admin','admin',now(),now());
 
DELETE FROM programareaconfig WHERE subprogramkey = 'IFPS';
  INSERT INTO programareaconfig (programkey, subprogramkey, servicerequestsubtypekey,insertedby,updatedby, insertedon, updatedon)
 VALUES('AXYS','IFPS','IHM','admin','admin',now(),now());