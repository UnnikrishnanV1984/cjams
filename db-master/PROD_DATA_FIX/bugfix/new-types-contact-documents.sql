INSERT INTO cjams.attachmentclassificationtype
(sequencenumber, attachmentclassificationtypekey,activeflag,editable, typedescription, datavalue, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id, subcategory)
VALUES(703,'CW-CJAMS', 1, 0, 'CW-CJAMS', 703,current_timestamp, NULL, NULL, 'B-89372', 'B-89372',now(),now(), NULL, 'CW-Comfort Calls');

INSERT INTO cjams.attachmentclassificationtype
(sequencenumber, attachmentclassificationtypekey,activeflag,editable, typedescription, datavalue, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id, subcategory)
VALUES(704,'CW-CJAMS', 1, 0, 'CW-CJAMS', 704,current_timestamp, NULL, NULL, 'B-89372', 'B-89372',now(),now(), NULL, 'CW-Icebreakers');

insert into progressnotetypeconfig (progressnotetypekey,teamtypekey,activeflag,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate )
values('Comfort Calls','CW',1,'B-89372',now(),'B-89372',now(),now());

insert into progressnotetypeconfig (progressnotetypekey,teamtypekey,activeflag,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate )
values('Icebreakers','CW',1,'B-89372',now(),'B-89372',now(),now());

insert into progressnotetype (progressnotetypekey, activeflag, description ,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate,parentid ,progressnoteclassificationtypekey )
values('Comfort Calls',1,'Comfort Calls','B-89372',now(),'B-89372',now(),now(),null,'user');

insert into progressnotetype (progressnotetypekey, activeflag, description ,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate,parentid ,progressnoteclassificationtypekey )
values('Icebreakers',1,'Icebreakers','B-89372',now(),'B-89372',now(),now(),null,'user');