create
or replace
function getpopulationreport(searchobj json) returns table
	(populationreport json) language plpgsql as $function$ declare v_providername varchar(100);

v_providerunit varchar(100);

v_primaryadmissionreason varchar(100);

v_folderworker_firstname varchar(100);

v_folderworker_lastname varchar(100);

v_folderoffice varchar(100);

v_fieldworker_firstname varchar(100);

v_fieldworker_lastname varchar(100);

v_status varchar(100);

v_datefilter varchar(3);

v_startdate timestamp(3);

v_enddate timestamp(3);

v_ethnicity varchar(100);

v_date timestamp(3);

v_residencecounty varchar(100);

v_jurisdictioncounty varchar(100);

v_jurisdictionoffice varchar(100);

v_pageoffset int;

v_pagesize int;

v_nolimit boolean;
begin
v_providername := searchObj ->> 'providername';

v_providerunit := searchObj ->> 'providerunit';

v_primaryadmissionreason := searchObj ->> 'primaryadmissionreason';

v_folderworker_firstname := searchObj ->> 'folderworker_firstname';

v_folderworker_lastname := searchObj ->> 'folderworker_lastname';

v_folderoffice := searchObj ->> 'folderoffice';

v_fieldworker_firstname := searchObj ->> 'fieldworker_firstname';

v_fieldworker_lastname := searchObj ->> 'fieldworker_lastname';

v_status := searchObj ->> 'status';

v_datefilter := searchObj ->> 'datefilter';

v_startdate := searchObj ->> 'startdate';

v_enddate := searchObj ->> 'enddate';

v_ethnicity := searchObj ->> 'ethnicity';

v_date := searchObj ->> 'date';

v_residencecounty := searchObj ->> 'residencecounty';

v_jurisdictioncounty := searchObj ->> 'jurisdictioncounty';

v_jurisdictionoffice := searchObj ->> 'jurisdictionoffice';

v_pageoffset := searchObj ->> 'pageoffset';

v_pagesize := searchObj ->> 'pagesize';

v_nolimit := searchObj ->> 'nolimit';

if( v_datefilter = 'T'
and v_startdate is not null
and v_enddate is not null) then return QUERY select
	coalesce(json_agg(p), '[]'::json)
from
	(
	select
		count(*) over() as reccoount,
		rv.description as unit,
		pr.bedsapproved as bed,
		cast(pl.providerid as character varying) as providerid,
		pr.providername,
		p.cjamspid as clientid,
		p.lastname as clientlastname,
		p.firstname as clientfirstname,
		cast(concat(coalesce(p.lastname),coalesce(' '||(p.suffix), ''),', ',coalesce(p.firstname)) as character varying) as clientname,
		p.dob,
		p.racetypekey as race,
		p.gendertypekey as sex,
		cast(age(pl.releasedate, pl.addate) as character varying) as los,
		pl.projectedreleasedate,
		pra.county as countyjurisdction,
		pat.description as admissiontype,
		pprt.description as primaryadmissionreason,
		pl.addate as admissiondate,
		pl.releasedate as releasedate,
		pl.releasetonametext as releaseto,
		plr.departeddate as transferdate,
		plr.releasedto as transferto
	from
		placement pl
	join provider pr on
		pr.providerid = pl.providerid
		and pr.activeflag = 1
	join intakeservicerequestactor isra on
		isra.intakeservicerequestactorid = pl.intakeservicerequestactorid
		and isra.activeflag = 1
	join actor a on
		a.actorid = isra.actorid
		and a.activeflag = 1
		and a.actortype = 'Youth'
	join person p on
		p.personid = a.personid
		and p.activeflag = 1
	join personaddress pra on
		pra.personid = p.personid
		and pra.activeflag = 1
	join userprofile up on
		up.securityusersid = pl.updatedby
	join userprofileaddress upa on
		upa.securityusersid = up.securityusersid
	join placementleavereturn plr on
		plr.placementid = pl.placementid
		and plr.leavetypekey in ('TDF',
		'TNF')
	left join placementadmissiontype pat on
		pat.placementadmissiontypekey = pl.placementadmissiontypekey
		and pat.activeflag = 1
	left join placementprimaryadmissionreasontype pprt on
		pprt.placementprimaryadmissionreasontypekey = pl.placementprimaryadmissionreasontypekey
	left join county jc on
		jc.countyname = pl.jcounty
	left join (
		select
			r.description,
			r.ref_key
		from
			referencetype rt
		join referencevalues r on
			rt.referencetypeid = r.referencetypeid
			and r.activeflag = 1
		where
			rt.tablename = 'providerunittype'
			and rt.activeflag = 1 ) rv on
		rv.ref_key = pr.providerunit
	where
		pl.activeflag = 1
		and
		case
			when v_providername is not null then pr.providername ilike '%' || v_providername || '%'
			else true
		end
		and
		case
			when v_providerunit is not null then pr.providerunit = v_providerunit
			else true
		end
		and
		case
			when v_primaryadmissionreason is not null then pl.placementprimaryadmissionreasontypekey = v_primaryadmissionreason
			else true
		end
		and
		case
			when v_folderworker_firstname is not null then up.firstname ilike '%' || v_folderworker_firstname || '%'
			else true
		end
		and
		case
			when v_folderworker_lastname is not null then up.lastname ilike '%' || v_folderworker_lastname || '%'
			else true
		end
		and
		case
			when v_folderoffice is not null then upa.city ilike '%' || v_folderoffice || '%'
			else true
		end
		and
		case
			when v_fieldworker_firstname is not null then up.firstname ilike '%' || v_fieldworker_firstname || '%'
			else true
		end
		and
		case
			when v_fieldworker_lastname is not null then up.lastname ilike '%' || v_fieldworker_lastname || '%'
			else true
		end
		and
		case
			when v_status = 'open' then pl.lrstatus = 'open'
			or pl.lrstatus is null
			else true
		end
		and
		case
			when v_status = 'leave' then pl.lrstatus = 'leave'
			else true
		end
		and
		case
			when v_status = 'closed' then pl.lrstatus = 'closed'
			else true
		end
		and
		case
			when v_status = 'OL' then pl.lrstatus = 'open'
			or pl.lrstatus is null
			or pl.lrstatus = 'leave'
			else true
		end
		and
		case
			when v_ethnicity is not null then p.ethnicgrouptypekey ilike '%' || v_ethnicity || '%'
			else true
		end
		and
		case
			when v_date is not null then pl.startdatetime = v_date
			else true
		end
		and
		case
			when v_residencecounty is not null then pl.county = cast(v_residencecounty as uuid)
			else true
		end
		and
		case
			when v_jurisdictioncounty is not null then jc.countyid = cast(v_jurisdictioncounty as uuid)
			else true
		end
		and
		case
			when v_jurisdictionoffice is not null then pl.jlocation ilike '%' || v_jurisdictionoffice || '%'
			else true
		end
		and plr.departeddate between v_startdate and v_enddate
	limit
	(case
		when v_nolimit is false then v_pagesize
		else null
	end ) offset
	(case
		when v_nolimit is false then v_pageoffset
		else null
	end))p;
else return QUERY select
	coalesce(json_agg(p), '[]'::json)
from
	(
	select
		count(*) over() as reccoount,
		rv.description as unit,
		pr.bedsapproved as bed,
		cast(pl.providerid as character varying) as providerid,
		pr.providername,
		p.cjamspid as clientid,
		p.lastname as clientlastname,
		p.firstname as clientfirstname,
		cast(concat(coalesce(p.lastname),coalesce(' '||(p.suffix), ''),', ',coalesce(p.firstname)) as character varying) as clientname,
		p.dob,
		p.racetypekey as race,
		p.gendertypekey as sex,
		cast(age(pl.releasedate, pl.addate) as character varying) as los,
		pl.projectedreleasedate,
		pra.county as countyjurisdction,
		pat.description as admissiontype,
		pprt.description as primaryadmissionreason,
		pl.addate as admissiondate,
		pl.releasedate as releasedate,
		pl.releasetonametext as releaseto,
		plr.departeddate as transferdate,
		plr.releasedto as transferto
	from
		placement pl
	join provider pr on
		pr.providerid = pl.providerid
		and pr.activeflag = 1
	join intakeservicerequestactor isra on
		isra.intakeservicerequestactorid = pl.intakeservicerequestactorid
		and isra.activeflag = 1
	join actor a on
		a.actorid = isra.actorid
		and a.activeflag = 1
		and a.actortype = 'Youth'
	join person p on
		p.personid = a.personid
		and p.activeflag = 1
	join personaddress pra on
		pra.personid = p.personid
		and pra.activeflag = 1
	join userprofile up on
		up.securityusersid = pl.updatedby
	join userprofileaddress upa on
		upa.securityusersid = up.securityusersid
	left join placementleavereturn plr on
		plr.placementid = pl.placementid
		and plr.leavetypekey in ('TDF',
		'TNF')
	left join placementadmissiontype pat on
		pat.placementadmissiontypekey = pl.placementadmissiontypekey
		and pat.activeflag = 1
	left join placementprimaryadmissionreasontype pprt on
		pprt.placementprimaryadmissionreasontypekey = pl.placementprimaryadmissionreasontypekey
	left join county jc on
		jc.countyname = pl.jcounty
	left join (
		select
			r.description,
			r.ref_key
		from
			referencetype rt
		join referencevalues r on
			rt.referencetypeid = r.referencetypeid
			and r.activeflag = 1
		where
			rt.tablename = 'providerunittype'
			and rt.activeflag = 1 ) rv on
		rv.ref_key = pr.providerunit
	where
		pl.activeflag = 1
		and
		case
			when v_providername is not null then pr.providername ilike '%' || v_providername || '%'
			else true
		end
		and
		case
			when v_providerunit is not null then pr.providerunit = v_providerunit
			else true
		end
		and
		case
			when v_primaryadmissionreason is not null then pl.placementprimaryadmissionreasontypekey = v_primaryadmissionreason
			else true
		end
		and
		case
			when v_folderworker_firstname is not null then up.firstname ilike '%' || v_folderworker_firstname || '%'
			else true
		end
		and
		case
			when v_folderworker_lastname is not null then up.lastname ilike '%' || v_folderworker_lastname || '%'
			else true
		end
		and
		case
			when v_folderoffice is not null then upa.city ilike '%' || v_folderoffice || '%'
			else true
		end
		and
		case
			when v_fieldworker_firstname is not null then up.firstname ilike '%' || v_fieldworker_firstname || '%'
			else true
		end
		and
		case
			when v_fieldworker_lastname is not null then up.lastname ilike '%' || v_fieldworker_lastname || '%'
			else true
		end
		and
		case
			when v_status = 'open' then pl.lrstatus = 'open'
			or pl.lrstatus is null
			else true
		end
		and
		case
			when v_status = 'leave' then pl.lrstatus = 'leave'
			else true
		end
		and
		case
			when v_status = 'closed' then pl.lrstatus = 'closed'
			else true
		end
		and
		case
			when v_status = 'OL' then pl.lrstatus = 'open'
			or pl.lrstatus is null
			or pl.lrstatus = 'leave'
			else true
		end
		and
		case
			when v_datefilter = 'A'
			and v_startdate is not null
			and v_enddate is not null then pl.addate between v_startdate and v_enddate
			else true
		end
		and
		case
			when v_datefilter = 'R'
			and v_startdate is not null
			and v_enddate is not null then pl.releasedate between v_startdate and v_enddate
			else true
		end
		and
		case
			when v_ethnicity is not null then p.ethnicgrouptypekey ilike '%' || v_ethnicity || '%'
			else true
		end
		and
		case
			when v_date is not null then pl.startdatetime = v_date
			else true
		end
		and
		case
			when v_residencecounty is not null then pl.county = cast(v_residencecounty as uuid)
			else true
		end
		and
		case
			when v_jurisdictioncounty is not null then jc.countyid = cast(v_jurisdictioncounty as uuid)
			else true
		end
		and
		case
			when v_jurisdictionoffice is not null then pl.jlocation ilike '%' || v_jurisdictionoffice || '%'
			else true
		end
	limit
	(case
		when v_nolimit is false then v_pagesize
		else null
	end ) offset
	(case
		when v_nolimit is false then v_pageoffset
		else null
	end))p;
end if;
end;

$function$ ;
