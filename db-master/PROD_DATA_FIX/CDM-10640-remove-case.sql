UPDATE servicecase SET statustypekey = 'Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-10640',updatedon = now() WHERE servicecaseid = '6e51a81d-3f42-4bb2-acd2-f382fc2de265';

Update servicecasedisposition SET activeflag = 0, updatedby = 'CDM-10640',updatedon = now() where servicecasedispositionid = 'cf055385-cc5a-427a-857b-f2a771c75627';

update intakeservreqchildremoval set removalexitreason= null, exitdate = null, updatedby = 'CDM-10640',updatedon = now() where intakeservreqchildremovalid = 'c33483db-7775-415b-ad26-e2749fbd1582';

update placement set enddatetime = null, updatedby = 'CDM-10640', updatedon = now() where placementid = 'b57bc388-2383-44dd-a4fd-5402be0fdad5';
