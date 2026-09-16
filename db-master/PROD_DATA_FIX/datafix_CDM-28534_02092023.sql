/*
	Issue Description: CDM-28534 - Imani Williams/Program assignment

	3205351:Imani Williams' program assignment should be Out of Home. "Out of Home" is not an option when attempting to assign the program assignment.
  
	select * from getpersonprogramarea('299543f3-6290-4c52-a8cd-3dd84b33f5a4','94ea6f70-37f0-4754-9050-d9f8f640b5bc');

	SELECT 
		   ppa.personprogramid, date(ppa.startdate) as startdate, date(ppa.enddate) as enddate,
		   ppa.personid, ppa.objecttypekey, ppa.objectid,
		   ppa.endreasonkey,ppa.programkey, ppa.subprogramkey,
		   ppa.datavalidflag, ppa.clientmergeid,ppa.ifpsatriskflag,
		   ppa.entityid As casenumber,
		   (SELECT apa.programname FROM agencyprogramarea apa WHERE apa.programkey = ppa.programkey AND apa.activeflag =1),
		   (SELECT rv.description AS subprogram FROM referencevalues rv WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1),
		   (SELECT rv.description AS endreason FROM referencevalues rv WHERE rv.ref_key = ppa.endreasonkey AND rv.referencetypeid = 357 AND rv.activeflag =1),
		   (SELECT (firstname ||' '|| lastname) AS updatedby FROM v_userprofile WHERE securityusersid = ppa.updatedby  LIMIT  1),
		   ppa.datatransferflag
		FROM personprogramarea ppa 		   
		WHERE ppa.personid = '94ea6f70-37f0-4754-9050-d9f8f640b5bc' AND ppa.activeflag =1 and ppa.sourcetype = 'CW' and ppa.entityid = '3205351'
		and ppa.programkey = 'OOH' 
		ORDER BY COALESCE(ppa.enddate, now()) DESC, ppa.startdate desc;
*/

/*email : 
jeannette.mcneil@maryland.gov
*/
	
select * from personprogramarea where personprogramid = '786e6ccc-e403-456c-a278-64d413ffa817';
	
update personprogramarea
set activeflag = 1,
	enddate = null,
	updatedby = 'CDM-28534',
	updatedon = now()
where personprogramid in ('786e6ccc-e403-456c-a278-64d413ffa817');