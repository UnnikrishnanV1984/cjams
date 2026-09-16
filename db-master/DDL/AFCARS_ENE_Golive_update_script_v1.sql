-- AFCARS - E&E DDLs

-- To update E&E Go-Live dates
--	24043	Washington

select applicationname, localagencytypekey, golivedate, updatedby, updatedon 
	from cjams.interfacegolivedates
where localagencytypekey = '24043'
	and applicationname = 'ENE' ;

update cjams.interfacegolivedates
	set golivedate = current_date,
		updatedby = 'cwadmin',
		updatedon =  now()
where localagencytypekey = '24043'
	and applicationname = 'ENE' ;
		
		