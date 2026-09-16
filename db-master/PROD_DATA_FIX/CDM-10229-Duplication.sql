update intakesnapshot SET updatedby = 'CDM-10229', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'-> 0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I202000282597' and activeflag = 1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-10229', updatedon = now() where intakenumber = 'I202000282597' 
	and  intakeserviceid = '4b40a2cc-5c2c-4301-9f59-128f27c8722b' and servicerequestnumber = '20200266036910';
update intakedastaging 	set status = 'Closed', updatedby = 'CDM-10229', updatedon = now() where intakenumber = 'I202000282597' and activeflag = 1;