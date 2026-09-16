-- B-108432 - Addition of Fiscal Category Code 4170
/*

Notes - Contact Purpose:
----------------------------------------------------
MDC - Medical/Dental - Comprehensive Health Assessment 
MDN - Medical/Dental - Health Needs Met
MDP - Medical/Dental - Health Plan
MDI - Medical/Dental - Initial Health Screen
MDM - Medical/Dental - MA Card 
MDR - Medical/Dental - MA Card Request

*/

-- Before 
select progressnotereasontypekey, typedescription, insertedby, insertedon 
	from progressnotereasontype
where btrim(progressnotereasontypekey) in ('MDC', 'MDN', 'MDP', 'MDI', 'MDM', 'MDR')
	order by progressnotereasontypekey ;

insert into cjams.progressnotereasontype
	(	progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate,
		insertedby, updatedby, insertedon, updatedon, old_id, isas
	)
values
	(	gen_random_uuid(), 'MDC', 1, 'Medical/Dental - Comprehensive Health Assessment', now(), 
		'B-112569', 'B-112569', now(), now(), NULL, false
	);

insert into cjams.progressnotereasontype
	(	progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate,
		insertedby, updatedby, insertedon, updatedon, old_id, isas
	)
values
	(	gen_random_uuid(), 'MDN', 1, 'Medical/Dental - Health Needs Met', now(), 
		'B-112569', 'B-112569', now(), now(), NULL, false
	);
	
insert into cjams.progressnotereasontype
	(	progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate,
		insertedby, updatedby, insertedon, updatedon, old_id, isas
	)
values
	(	gen_random_uuid(), 'MDP', 1, 'Medical/Dental - Health Plan', now(), 
		'B-112569', 'B-112569', now(), now(), NULL, false
	);

insert into cjams.progressnotereasontype
	(	progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate,
		insertedby, updatedby, insertedon, updatedon, old_id, isas
	)
values
	(	gen_random_uuid(), 'MDI', 1, 'Medical/Dental - Initial Health Screen', now(), 
		'B-112569', 'B-112569', now(), now(), NULL, false
	);

insert into cjams.progressnotereasontype
	(	progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate,
		insertedby, updatedby, insertedon, updatedon, old_id, isas
	)
values
	(	gen_random_uuid(), 'MDM', 1, 'Medical/Dental - MA Card', now(), 
		'B-112569', 'B-112569', now(), now(), NULL, false
	);	

insert into cjams.progressnotereasontype
	(	progressnotereasontypeid, progressnotereasontypekey, activeflag, typedescription, effectivedate,
		insertedby, updatedby, insertedon, updatedon, old_id, isas
	)
values
	(	gen_random_uuid(), 'MDR', 1, 'Medical/Dental - MA Card Request', now(), 
		'B-112569', 'B-112569', now(), now(), NULL, false
	);
	
-- After
select progressnotereasontypekey, typedescription, insertedby, insertedon 
	from progressnotereasontype
where btrim(progressnotereasontypekey) in ('MDC', 'MDN', 'MDP', 'MDI', 'MDM', 'MDR')
	order by progressnotereasontypekey ;
	
/*
Document Category - Health (CW-Health)

Add Sub Categories:

Table: attachmentclassificationtype
----------------------------------------------------

sequencenumber	subcategory 
-----------------------------------------------------
813 			CW-Health-Infants & Toddlers Referral
814 			CW-Health-Comprehensive Health Assessment
815 			CW-Health-Comprehensive Mental Health Exam
816 			CW-Health-Health Needs Assessment
817 			CW-Health-Health Plan

*/

-- Before 
select sequencenumber, typedescription, subcategory, insertedby, insertedon
	from attachmentclassificationtype
where sequencenumber in (813, 814, 815, 816, 817) ;

insert into cjams.attachmentclassificationtype
	(	sequencenumber, attachmentclassificationtypekey, activeflag, datavalue, editable, 
		typedescription, effectivedate, expirationdate, "timestamp", insertedby, 
		updatedby, insertedon, updatedon, old_id, subcategory, repositoryid
	)
values
	(	813, 'CW-Health', 1, 813, 0, 
		'CW-Health', now(), NULL, NULL, 'B-112569', 
		'B-112569', now(), now(), NULL, 'CW-Health-Infants & Toddlers Referral', NULL
	);
	
insert into cjams.attachmentclassificationtype
	(	sequencenumber, attachmentclassificationtypekey, activeflag, datavalue, editable, 
		typedescription, effectivedate, expirationdate, "timestamp", insertedby, 
		updatedby, insertedon, updatedon, old_id, subcategory, repositoryid
	)
values
	(	814, 'CW-Health', 1, 814, 0, 
		'CW-Health', now(), NULL, NULL, 'B-112569', 
		'B-112569', now(), now(), NULL, 'CW-Health-Comprehensive Health Assessment', NULL
	);


insert into cjams.attachmentclassificationtype
	(	sequencenumber, attachmentclassificationtypekey, activeflag, datavalue, editable, 
		typedescription, effectivedate, expirationdate, "timestamp", insertedby, 
		updatedby, insertedon, updatedon, old_id, subcategory, repositoryid
	)
values
	(	815, 'CW-Health', 1, 815, 0, 
		'CW-Health', now(), NULL, NULL, 'B-112569', 
		'B-112569', now(), now(), NULL, 'CW-Health-Comprehensive Mental Health Exam', NULL
	);

insert into cjams.attachmentclassificationtype
	(	sequencenumber, attachmentclassificationtypekey, activeflag, datavalue, editable, 
		typedescription, effectivedate, expirationdate, "timestamp", insertedby, 
		updatedby, insertedon, updatedon, old_id, subcategory, repositoryid
	)
values
	(	816, 'CW-Health', 1, 816, 0, 
		'CW-Health', now(), NULL, NULL, 'B-112569', 
		'B-112569', now(), now(), NULL, 'CW-Health-Health Needs Assessment', NULL
	);

insert into cjams.attachmentclassificationtype
	(	sequencenumber, attachmentclassificationtypekey, activeflag, datavalue, editable, 
		typedescription, effectivedate, expirationdate, "timestamp", insertedby, 
		updatedby, insertedon, updatedon, old_id, subcategory, repositoryid
	)
values
	(	817, 'CW-Health', 1, 817, 0, 
		'CW-Health', now(), NULL, NULL, 'B-112569', 
		'B-112569', now(), now(), NULL, 'CW-Health-Health Plan', NULL
	);	
	
-- After 
select sequencenumber, typedescription, subcategory, insertedby, insertedon
	from attachmentclassificationtype
where sequencenumber in (813, 814, 815, 816, 817) ;
	
	