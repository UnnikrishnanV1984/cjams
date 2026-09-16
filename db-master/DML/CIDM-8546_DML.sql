update cjams.referencevalues
set value_text ='Add addendum to narrative',
description  ='Add addendum to narrative',
updatedby ='CIDM-8546',
updatedon =now() 
where
ref_key ='ATNA' and
teamtypekey  ='CW' 
and referencetypeid  =600 ;

delete from cjams.routingstatustype where sequencenumber=860 and routingstatustypekey='navigate_to_narrative';

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(860, 'navigate_to_narrative', 1, 'Pending Approval', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

delete from cjams.routingstatustype where sequencenumber=861 and routingstatustypekey='return_to_worker_intakeoverride';

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(861, 'return_to_worker_intakeoverride', 1, 'In Progress', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);