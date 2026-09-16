--D-12496

UPDATE progressnotereasontype 
SET activeflag=1, insertedby = 'admin', insertedon = '2018-10-10 19:51:51', updatedby = 'admin', updatedon = Now() 
WHERE activeflag = 0
AND progressnotereasontypekey in ('TSR', 'TTM');

UPDATE progressnotetype 
SET activeflag=1, description = 'Fax', insertedby = 'admin', insertedon = '2018-10-10 19:51:51', updatedby = 'admin', updatedon = Now() 
WHERE progressnotetypekey = 'Fax'
and activeflag = 0 
and description = 'FAX';

INSERT INTO  progressnotetypeconfig(
	progressnotetypekey
	, progressnotesubtypekey
	, teamtypekey
	, activeflag
	, insertedby
	, insertedon
	, updatedby
	, updatedon
	, effectivedate
)
VALUES ('Fax'
		,''
		,'CW' 
		, 1 
		,'admin'
		,Now()
		,'admin'
		,Now()
		,Now()
);


