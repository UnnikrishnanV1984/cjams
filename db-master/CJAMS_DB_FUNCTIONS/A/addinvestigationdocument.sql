drop function if exists addinvestigationdocument(json);


CREATE OR REPLACE FUNCTION addinvestigationdocument(searchobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 
	v_objectid uuid;
    v_objecttypekey VARCHAR(50);
	 v_documenttypekey VARCHAR(50);
	  v_rootobjecttypekey VARCHAR(50);
	  	v_rootobjectid uuid;
   v_documentdate timestamp;
	v_insertedby uuid;
	v_updatedby uuid;
v_bucketname varchar(1000);
v_originalfilename varchar(260);
v_ecmsdocumentid VARCHAR(30);
v_title VARCHAR(100);
v_filename VARCHAR(500);
v_documentpropertiesid uuid;
v_actualdocumentdate timestamp;
v_attachmentclassificationtypekey VARCHAR(50);
v_attachmentclassificationsubtypekey VARCHAR(30);
v_attachmentdate timestamp;
v_attachmenttypekey VARCHAR(50);

    


	
BEGIN 
v_objectid := searchobj ->> 'objectid';
v_objecttypekey := searchobj ->> 'objecttypekey'; 
v_documenttypekey := searchobj ->> 'documenttypekey';  
v_rootobjecttypekey := searchobj ->> 'rootobjecttypekey';  
v_rootobjectid := searchobj ->> 'rootobjectid'; 
v_documentdate := searchobj ->> 'documentdate'; 
v_insertedby := searchobj ->> 'insertedby'; 
v_updatedby := searchobj ->> 'updatedby'; 
v_bucketname := searchobj ->> 's3bucketpathname'; 
v_originalfilename := searchobj ->> 'originalfilename'; 
v_ecmsdocumentid := searchobj ->> 'ecmsdocumentid';
v_title := searchobj ->>'title';
v_filename := searchobj ->>'filename';
v_documentpropertiesid := searchobj ->>'documentpropertiesid';
v_actualdocumentdate := searchobj  ->> 'actualdocumentdate';
v_attachmentclassificationtypekey := searchobj  ->>'attachmentclassificationtypekey';
v_attachmentclassificationsubtypekey := searchobj  ->>'attachmentclassificationsubtypekey';
v_attachmentdate := searchobj  ->>'attachmentdate';
v_attachmenttypekey := searchobj  ->>'attachmenttypekey';



insert into documentproperties (documentpropertiesid, objecttypekey,objectid,documenttypekey,documentdate,rootobjecttypekey,rootobjectid,insertedby,updatedby,originalfilename,s3bucketpathname, ecmsdocumentid, title, filename, actualdocumentdate) values 
(v_documentpropertiesid, v_objecttypekey,v_objectid,v_documenttypekey,v_documentdate,v_rootobjecttypekey,v_rootobjectid,v_insertedby,v_updatedby,v_originalfilename,v_bucketname,v_ecmsdocumentid,v_title, v_filename, v_actualdocumentdate );

				    
insert into documentattachment (documentpropertiesid, attachmenttypekey,attachmentclassificationtypekey,attachmentclassificationsubtypekey,attachmentdate, insertedby,updatedby) 
values (v_documentpropertiesid,v_attachmenttypekey,v_attachmentclassificationtypekey,v_attachmentclassificationsubtypekey,v_attachmentdate, v_insertedby, v_updatedby);


return 'Success';

END;

$function$;