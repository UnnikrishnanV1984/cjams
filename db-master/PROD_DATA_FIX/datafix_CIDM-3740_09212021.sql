-- CIDM-3740 - AFCARS - updating the E&E go live dates 
/*
Master Data: 
Script to update E&E go live dates in cjams.interfacegolivedates table 
*/

-- To update E&E Go-Live dates

/*		
1	ALLEGANY COUNTY		4/17/2021 - 24001		1427 	Allegany
2	ANNE ARUNDEL COUNTY	4/17/2021 - 24003		1428 	Anne Arundel
4	CALVERT COUNTY		4/17/2021 - 24009		1431 	Calvert
6	CARROLL COUNTY		4/17/2021 - 24013		1433 	Carroll
8	CHARLES COUNTY		4/17/2021 - 24017		1435 	Charles
10	FREDERICK COUNTY	4/17/2021 - 24021		1437 	Frederick
11	GARRETT COUNTY		4/17/2021 - 24023		1438 	Garrett
14	KENT COUNTY			4/17/2021 - 24029		1441 	Kent
18	SAINT MARYS COUNTY	4/17/2021 - 24037		1446 	St. Mary's
*/

select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where localagencytypekey in ( '24001', '24003', '24009', '24013', '24017', '24021', '24023', '24029', '24037' )
	and applicationname = 'ENE' ;

update cjams.interfacegolivedates
	set golivedate = '2021-04-17'::date,
		updatedby = 'CIDM-3740',
		updatedon =  now()
where localagencytypekey in ( '24001', '24003', '24009', '24013', '24017', '24021', '24023', '24029', '24037' )
	and applicationname = 'ENE' ;
	
/*
9	DORCHESTER COUNTY		8/7/2021 - 24019		1436 	Dorchester
13	HOWARD COUNTY			8/7/2021 - 24027		1440 	Howard
16	PRINCE GEORGE'S COUNTY	8/7/2021 - 24033		1443 	Prince George's
20	TALBOT COUNTY			8/7/2021 - 24041		1447 	Talbot
*/

select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where localagencytypekey in ( '24019', '24027', '24033', '24041' )
	and applicationname = 'ENE' ;

update cjams.interfacegolivedates
	set golivedate = '2021-08-07'::date,
		updatedby = 'CIDM-3740',
		updatedon =  now()
where localagencytypekey in ( '24019', '24027', '24033', '24041' )
	and applicationname = 'ENE' ;
	
	
/*
3	BALTIMORE COUNTY	9/18/2021 - 24005		1430 	Baltimore County
5	CAROLINE COUNTY		9/18/2021 - 24011		1432 	Caroline
7	CECIL COUNTY		9/18/2021 - 24015		1434 	Cecil
17	QUEEN ANNE'S COUNTY	9/18/2021 - 24035		1444 	Queen Anne's
19	SOMERSET COUNTY		9/18/2021 - 24039		1445 	Somerset
*/

select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where localagencytypekey in ( '24005', '24011', '24015', '24035', '24039' )
	and applicationname = 'ENE' ;

update cjams.interfacegolivedates
	set golivedate = '2021-09-18'::date,
		updatedby = 'CIDM-3740',
		updatedon =  now()
where localagencytypekey in ( '24005', '24011', '24015', '24035', '24039' )
	and applicationname = 'ENE' ;
	
/*
1st Live
21	WASHINGTON COUNTY	3/13/2021 - 24043	1448 	Washington (Old value 2021-05-07)
*/
select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where localagencytypekey = '24043'
	and applicationname = 'ENE' ;

update cjams.interfacegolivedates
	set golivedate = '2021-03-13'::date,
		updatedby = 'CIDM-3740',
		updatedon =  now()
where localagencytypekey = '24043'
	and applicationname = 'ENE' ;
	

	
/*
Remaining Counties
24510		1429 	Baltimore City
24025		1439 	Harford
24031		1442 	Montgomery
24045		1449 	Wicomico
24047		1450 	Worcester

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
	-- 04/17
	-- and inf.localagencytypekey in ( '24001', '24003', '24009', '24013', '24017', '24021', '24023', '24029', '24037' )
	-- 08/07
	-- and inf.localagencytypekey in ( '24019', '24027', '24033', '24041' )
	-- 09/18
	-- and inf.localagencytypekey in ( '24005', '24011', '24015', '24035', '24039' )
	-- and inf.golivedate is not null 
order by inf.golivedate nulls last, ct.countyname ;

*/
