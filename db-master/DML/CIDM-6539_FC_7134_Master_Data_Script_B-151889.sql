-- CIDM-6539 
-- B-151889 - Add Category Code 7134 Transportation Services to the Service Log In-Home Picklist in CJAMS

-- Fiscal Category Code: 7134 - Transportation Services (ID: 50)

-- Program Assignment: In-Home Services/Family Preservation - a79ae0dd-69d0-472a-bedd-07a776f7d3db

Delete from cjams.programcategorylink where insertedby = 'CIDM-6539'; 

Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), 'a79ae0dd-69d0-472a-bedd-07a776f7d3db', 'CIDM-6539', now()::date, 'CIDM-6539', 
		now(), 1, NULL, 50, NULL, NULL
	);
	
select * 
from cjams.agencyprogramarea a
where agencyprogramareaid  
	in ( select agencyprogramareaid 
			from cjams.programcategorylink p 
		where fiscalcategoryid = 50 
			and activeflag  = 1
		)
and activeflag  = 1 ;	