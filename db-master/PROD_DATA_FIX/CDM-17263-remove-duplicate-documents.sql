update cjams.documentproperties 
set 
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-17263' 
where documentpropertiesid in ('abe2a109-cdf8-4064-90a7-ece3e2c3da26', 'fe68bc41-c015-4a85-8af1-f32189491795','381ff7d0-a1e7-4846-870d-7918d4bada11');