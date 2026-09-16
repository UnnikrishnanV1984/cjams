-- CIDM-4425 - AFCARS E&E County Live date update
/*
Master Data: 
Script to update E&E go live dates in cjams.interfacegolivedates table 
*/
-- To update E&E Go-Live dates
/*		
13		24025	1439 	Harford			- 2021-11-13
16		24031	1442 	Montgomery		- 2021-11-13
23		24045	1449 	Wicomico		- 2021-11-13
24		24047	1450 	Worcester		- 2021-11-13
*/

select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where localagencytypekey in ( '24025', '24031', '24045', '24047')
	and applicationname = 'ENE'
	and golivedate is null ;

update cjams.interfacegolivedates
	set golivedate = '2021-11-13'::date,
		updatedby = 'CIDM-4425',
		updatedon =  now()
where localagencytypekey in ( '24025', '24031', '24045', '24047')
	and applicationname = 'ENE'
	and golivedate is null ;
	
/*		
3		24510	1429 	Baltimore City	- 2021-10-16
*/
select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where localagencytypekey = '24510'
	and applicationname = 'ENE' 
	and golivedate is null ;

update cjams.interfacegolivedates
	set golivedate = '2021-10-16'::date,
		updatedby = 'CIDM-4425',
		updatedon =  now()
where localagencytypekey = '24510'
	and applicationname = 'ENE' 
	and golivedate is null ;
	
/*
-- To verify
select inf.localagencytypekey, 
	inf.golivedate, 
	afc.statepicklistvaluetypekey,
	ct.countyname,
	inf.updatedby,
	inf.updatedon	
from cjams.interfacegolivedates inf,
	cjams.afcarsreference afc,
	cjams.county ct 	
where inf.localagencytypekey = afc.afcarsvaluetypekey
	and btrim(afc.statepicklistvaluetypekey) = btrim(ct.statecountycode) 
	and inf.applicationname = 'ENE' 
	and inf.activeflag = 1 
	and afc.statepicklistid = 328
	-- 03-13
	-- and inf.localagencytypekey = '24043'
	-- 04/17
	-- and inf.localagencytypekey in ( '24001', '24003', '24009', '24013', '24017', '24021', '24023', '24029', '24037' )
	-- 08/07
	-- and inf.localagencytypekey in ( '24019', '24027', '24033', '24041' )
	-- 09/18
	-- and inf.localagencytypekey in ( '24005', '24011', '24015', '24035', '24039' )
	-- 11/13
	-- and inf.localagencytypekey in ( '24025', '24031', '24045', '24047')
	-- 10/16
	-- and inf.localagencytypekey = '24510'
	-- and inf.golivedate is not null 
order by inf.golivedate nulls last, ct.countyname ;
*/
