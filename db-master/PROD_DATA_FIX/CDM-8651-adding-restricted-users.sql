insert into restricteditems (objecttypekey, objectid, accessuserid, isadd,isedit,isdelete, insertedby, updatedby,insertedon, updatedon, activeflag)
select objecttypekey, objectid, 'db506305-117a-47c1-a726-a235c731a1d8', isadd,isedit,isdelete, 'CDM-8651', 'CDM-8651',now(), now(), activeflag
FROM restricteditems WHERE objectid='c40dc17a-1fa5-4d70-b74b-87c63bcf9ac6' and activeflag = 1 limit 1;

insert into restricteditems (objecttypekey, objectid, accessuserid, isadd,isedit,isdelete, insertedby, updatedby,insertedon, updatedon, activeflag)
select objecttypekey, objectid, '2749e1a9-7e03-45ec-9127-cbdd9870b55d', isadd,isedit,isdelete, 'CDM-8651', 'CDM-8651',now(), now(), activeflag
FROM restricteditems WHERE objectid='c40dc17a-1fa5-4d70-b74b-87c63bcf9ac6' and activeflag = 1 limit 1;
