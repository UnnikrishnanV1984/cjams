update intakedastaging set activeflag = 0, updatedby = 'CDM-10432', updatedon = now() where
	intakenumber in ('I202000184067', 'I202000386739', 'I202000388664', 'I202000488670', 
'I202000182301', 'I202000284471', 'I202000485178', 'I202000485197', 'I202000187765', 'I202000390883', 'I202000388252' ) and activeflag = '1';

update intakesnapshot set activeflag = 0, updatedby = 'CDM-10432', updatedon = now()  where
	intakenumber in ('I202000184067', 'I202000386739', 'I202000388664', 'I202000488670', 
'I202000182301', 'I202000284471', 'I202000485178', 'I202000485197', 'I202000187765', 'I202000390883', 'I202000388252' ) and activeflag = '1';

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-10432', updatedon = now()  where
	intakenumber in ('I202000184067', 'I202000386739', 'I202000388664', 'I202000488670', 
'I202000182301', 'I202000284471', 'I202000485178', 'I202000485197', 'I202000187765', 'I202000390883', 'I202000388252' ) and activeflag = '1';

update intakedastatus set activeflag = 0, updatedby = 'CDM-10432', updatedon = now()  where
	intakenumber in ('I202000184067', 'I202000386739', 'I202000388664', 'I202000488670', 
'I202000182301', 'I202000284471', 'I202000485178', 'I202000485197', 'I202000187765', 'I202000390883', 'I202000388252' ) and activeflag = '1';