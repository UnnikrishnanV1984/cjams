/*
 * CIDM-8068 - Duplicate CPS PA
 * Description - Found there is a duplicate CPS Program Assignment which need to be deleted. Keep only one CPS PA. This need to be done by the Dev Team.
 * Client ID: 2627331
 * CPS - servicerequestnumber: 20200267037235 - a8a2de25-7305-4492-b824-2708ed2eeab1
 * 
 */

select programkey, subprogramkey, startdate, enddate, activeflag, updatedby, updatedon, personprogramid
	from cjams.personprogramarea 
where personprogramid  = 'bb2ec258-17e2-42c5-b073-cfb926159a52'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CIDM-8068',
	updatedon = now()
where personprogramid = 'bb2ec258-17e2-42c5-b073-cfb926159a52'
	and activeflag = 1 ;
