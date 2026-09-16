update intakesnapshot SET updatedby = 'CDM-10227', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'-> 0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I202000488826' and activeflag = 1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-10227', updatedon = now() where intakenumber = 'I202000488826' 
	and  intakeserviceid = '7b2af380-aa6f-4197-aefb-fe5321ff59aa' and servicerequestnumber = '20200294043867';
update intakedastaging 	set status = 'Closed', updatedby = 'CDM-10227', updatedon = now() where intakenumber = 'I202000488826' and activeflag = 1;