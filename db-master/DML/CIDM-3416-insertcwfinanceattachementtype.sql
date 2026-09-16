INSERT INTO cjams.attachmentclassificationtype
(sequencenumber, attachmentclassificationtypekey,activeflag,editable, typedescription, datavalue, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id, subcategory)
VALUES(812,'CW-Finance', 1, 0, 'CW-Finance', 812,current_timestamp, NULL, NULL, 'CIDM-3416', 'CIDM-3416',now(),now(), NULL, 'CfE Site Expenditure Proposal');

insert  into progressnotetypeconfig (progressnotetypekey,teamtypekey,activeflag,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate )
values('CfE Site Expenditure Proposal','CW',1,'CIDM-3416',now(),'CIDM-3416',now(),now());


insert into progressnotetype (progressnotetypekey, activeflag, description ,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate,parentid ,progressnoteclassificationtypekey )
values('CfE Site Expenditure Proposal',1,'CfE Site Expenditure Proposal','CIDM-3416',now(),'CIDM-3416',now(),now(),null,'user');
