--Don't execute in stage1

INSERT INTO cjams.auditlogtype (logtypekey,logtype,modulename,effectivedate,insertedby,insertedon) 
VALUES('PRGMAREA','PRGMAREA','personprogramarea',now(),'admin',now());