-- CSMS go-live dates (B-130478 / CIDM-4511)

-- To update CSMS Go-Live dates
-- 24043 Washington (1448) -- Nov 8th 2021

select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where localagencytypekey = '24043'
	and applicationname = 'CSMS' ;

update cjams.interfacegolivedates
	set golivedate = '2021-11-08'::date,
		updatedby = 'B-130478',
		updatedon =  now()
where localagencytypekey = '24043'
	and applicationname = 'CSMS' ;

-- 24001 Allegany (1427) - Dec 6th 2021
-- 24021 Frederick (1437) - Dec 6th 2021
-- 24023 Garrett (1438) - Dec 6th 2021
select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where localagencytypekey in ( '24001', '24021', '24023' )
	and applicationname = 'CSMS' ;

update cjams.interfacegolivedates
	set golivedate = '2021-12-06'::date,
		updatedby = 'B-130478',
		updatedon =  now()
where localagencytypekey in ( '24001', '24021', '24023' )
	and applicationname = 'CSMS' ;
