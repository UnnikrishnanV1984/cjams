select * from createservicecase('c923b727-8dc5-48f6-b6c0-5eac6f326617', null, 1, '2749e1a9-7e03-45ec-9127-cbdd9870b55d','IHM','intake');

UPDATE cjams.intakeservicerequestagency
SET  updatedon=now(), activeflag=0
WHERE intakeservicerequestagencyid='c936554e-220c-4283-a031-200a8a1cdeeb';