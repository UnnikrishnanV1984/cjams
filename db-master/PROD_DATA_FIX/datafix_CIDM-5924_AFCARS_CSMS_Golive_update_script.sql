-- CIDM-5924 - To update CSMS go live dates for rest of the counties for AFCARS Fostercare

select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where applicationname = 'CSMS' 
	and golivedate is null ;

update cjams.interfacegolivedates
	set golivedate = '2022-09-19'::date,
		updatedby = 'CIDM-5924',
		updatedon =  now()
where applicationname = 'CSMS' 
	and golivedate is null ;
