-- D-27409 removal type needs to be corrected to judicial removal

update intakeservreqchildremoval set removaltypekey='JD', updatedby='D-27409' where intakeservreqchildremovalid = 'cf6c52d3-9ecb-4755-831d-dbb99dc672bc' ;

--D-25702 remove intake 
update intakeservicerequest set activeflag = 0, updatedby='D-25702', updatedon=now() where intakenumber IN ('CW10221487' );
update intakedastatus set activeflag = 0, updatedby='D-25702', updatedon=now() where intakenumber IN ('CW10221487' );

--D-24850 - remove intake
UPDATE intakedastaging set activeflag = 0, updatedby = 'D-24850', updatedon = now() where intakenumber = 'I202000457086' and activeflag = 1;
UPDATE intakedastatus set activeflag = 0, updatedby = 'D-24850', updatedon = now() where intakenumber = 'I202000457086' and activeflag = 1;

-- D-25097 uploaded name changed
UPDATE documentproperties set insertedby = 'f9ee1a50-b172-4913-a82d-c3d8660dc0cb',
updatedby = 'f9ee1a50-b172-4913-a82d-c3d8660dc0cb'
WHERE insertedby = '7aabe9fe-8838-41a9-a953-f17e3c9c5de9' and servicecaseid = 'e2ff59f7-d7f6-4b04-8e27-f590e4905f74' ;

-- D-25132 uploaded name changed
UPDATE documentproperties set insertedby = 'f5d1f110-de85-4aef-a16f-3bd401896f0a',
updatedby = 'f5d1f110-de85-4aef-a16f-3bd401896f0a'
WHERE documentpropertiesid = '44d08977-068a-47b7-985e-f5f47f475473' ;


