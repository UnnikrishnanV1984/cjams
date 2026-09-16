
/*
 Issue Description: CDM-10053
-- Category/ Module: Placement 
-- Root cause: Need a data cleanup to display the missing luggage question data on the placement screen.
-- Fix Provided: Datafix has been promoted to update the records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Updating placement data

with placementdata as ( 
select tab.*	
	,prv1.placementluggage,
	prv1.plluggagepurchased,
	prv1.plluggagecomments
from (
		-- LAs
		select 
			'LA' as placementtype,
			(select c.countyname 
				from caseassignment ca  
				join county c on c.countyid:: character varying = ca.toldssid::character varying
			where ca.objectid = pl.servicecaseid
				and lower(ca.responsibilitytypekey) = 'family'
				and ca.activeflag = 1
			order by ca.insertedon desc
			limit 1
			)  as "LDSS", 
			pr.cjamspid as "CHILD PID",
			sc.servicecasenumber as "CASE ID",
			pr.firstname as "YOUTH FIRST NAME",
			pr.lastname as "YOUTH LAST NAME",
			pr.dob::date as "YOUTH DATE OF BIRTH",
			pl.startdatetime::date as "PLACEMENT/LIVING ARRANGEMENT START DATE",
			pl.enddatetime::date as "PLACEMENT/LIVING ARRANGEMENT END DATE",
			(select rf.value_text
				from referencevalues rf 
			where rf.referencetypeid = 76
				and btrim(rf.ref_key) = btrim(la.livingarrangementtypekey)
			) as "PLACEMENT/LIVING ARRANGEMENT TYPE",
			( select to_char(ro.updatedon, 'yyyy-MM-dd HH12:MI AM') 
				from routing ro
			  where ro.routingstatustypeid = 16 
				and ro.eventcode::text = 'PLTR'::text 
				and ro.activeflag = 1 
				and ro.objectid::text = pl.placementid::character varying::text
				and ro.toroleid <> 'IVESV' 
			  order by ro.insertedon 
			  limit 1
			) as "PLACEMENT/LIVING ARRANGEMENT APPROVAL TIME STAMP",
			(case when la.livingarrangementluggage is null then
				'Missing'
			  when la.livingarrangementluggage = true then
			  	'Yes'
			  when la.livingarrangementluggage = false then
			  	'No'
			end) as "DID THE CHILD HAVE LUGGAGE AT TIME OF PLACEMENT/LIVING ARRANGEMENT?",
			(case when la.livingarrangementluggage = true then 
				'-'
			else
				(case when la.laluggagepurchased is null then
					'Missing'
				  when la.laluggagepurchased = true then
				  	'Yes'
				  when la.laluggagepurchased = false then
				  	'No'
				end) 
			end) as "WAS NEW LUGGAGE PURCHASED AT THE TIME OF THE PLACEMENT/LIVING ARRANGEMENT?",
			(case when la.laluggagepurchased = true then 
				'-'
			else
				la.laluggagecomments
			end)  as "COMMENTS",
			to_char(pl.insertedon, 'yyyy-MM-dd HH12:MI AM') as "Placement Create Tiemsatmp",
			pl.placementid,
			pl.alternateid,
			null as placementrevisionid
		from placement pl,
			livingarrangement la,
			person pr,
			servicecase sc 
		where pl.placementid = la.placementid
			and pl.personid = pr.personid
			and pl.servicecaseid = sc.servicecaseid
			and pl.activeflag = 1
			and la.activeflag = 1
			and pr.activeflag = 1
			and sc.activeflag = 1
			and pl.altproviderid is null -- LAs
			and ( SELECT count(*) AS count
					   FROM routing
				  WHERE routing.routingstatustypeid = 16 
					AND routing.eventcode::text = 'PLTR'::text 
					AND routing.activeflag = 1 
					AND routing.objectid::text = pl.placementid::character varying::text
				 ) > 0 
			and pl.startdatetime::date >= '2024-10-16'::date
	union all		
	-- Provider Placements
	select 
		'PR' as placmentype,
		(select c.countyname 
			from caseassignment ca  
			join county c on c.countyid:: character varying = ca.toldssid::character varying
		where ca.objectid = pl.servicecaseid
			and lower(ca.responsibilitytypekey) = 'family'
			and ca.activeflag = 1
		order by ca.insertedon desc
		limit 1
		)  as "LDSS", 
		pr.cjamspid as "CHILD PID",
		sc.servicecasenumber as "CASE ID",
		pr.firstname as "YOUTH FIRST NAME",
		pr.lastname as "YOUTH LAST NAME",
		pr.dob::date as "YOUTH DATE OF BIRTH",
		pl.startdatetime::date as "PLACEMENT/LIVING ARRANGEMENT START DATE",
		pl.enddatetime::date as "PLACEMENT/LIVING ARRANGEMENT END DATE",
		(select sv.service_nm 
			from prov.tb_services sv 
		where sv.service_id = pl.service_id 
		) as "PLACEMENT/LIVING ARRANGEMENT TYPE",
		( select to_char(ro.updatedon, 'yyyy-MM-dd HH12:MI AM') 
			from routing ro
		  where ro.routingstatustypeid = 16 
			and ro.eventcode::text = 'PLTR'::text 
			and ro.activeflag = 1 
			and ro.objectid::text = pl.placementid::character varying::text
			and ro.toroleid <> 'IVESV' 
		  order by ro.insertedon 
		  limit 1
		) as "PLACEMENT/LIVING ARRANGEMENT APPROVAL TIME STAMP",
		(case when pl.placementluggage is null then
			'Missing'
		  when pl.placementluggage = true then
		  	'Yes'
		  when pl.placementluggage = false then
		  	'No'
		end) as "DID THE CHILD HAVE LUGGAGE AT TIME OF PLACEMENT/LIVING ARRANGEMENT?",
		(case when pl.placementluggage = true then 
			'-'
		else
			(case when pl.plluggagepurchased is null then
				'Missing'
			  when pl.plluggagepurchased = true then
			  	'Yes'
			  when pl.plluggagepurchased = false then
			  	'No'
			end) 
		end) as "WAS NEW LUGGAGE PURCHASED AT THE TIME OF THE PLACEMENT/LIVING ARRANGEMENT?",
		(case when pl.plluggagepurchased = true then 
				'-'
			else
				pl.plluggagecomments
			end) as "COMMENTS",
		to_char(pl.insertedon, 'yyyy-MM-dd HH12:MI AM') as "Placement Create Tiemsatmp",	
		pl.placementid,
		pl.alternateid,
		(select prv.placementrevisionid 
			from placementrevision prv
		where prv.placementid = pl.placementid
			-- and prv.activeflag = 1
			and prv.placementluggage is not null
		order by prv.insertedon desc
		limit 1) as placementrevisionid
	from placement pl,
		person pr,
		servicecase sc 
	where pl.personid = pr.personid
		and pl.servicecaseid = sc.servicecaseid
		and pl.activeflag = 1
		and pr.activeflag = 1
		and sc.activeflag = 1
		and pl.altproviderid is Not null -- Provider Placement
		and ( SELECT count(*) AS count
				   FROM routing
			  WHERE routing.routingstatustypeid = 16 
				AND routing.eventcode::text = 'PLTR'::text 
				AND routing.activeflag = 1 
				AND routing.objectid::text = pl.placementid::character varying::text
			 ) > 0 
		and pl.startdatetime::date >= '2024-10-16'::date 
) tab
left join placementrevision prv1 on prv1.placementrevisionid = tab.placementrevisionid
-- Unit test 
where tab."PLACEMENT/LIVING ARRANGEMENT TYPE" <> 'Runaway'
 	and tab."DID THE CHILD HAVE LUGGAGE AT TIME OF PLACEMENT/LIVING ARRANGEMENT?" = 'Missing'
order by tab."LDSS",
	tab."CASE ID",
	tab."CHILD PID",
	tab."PLACEMENT/LIVING ARRANGEMENT START DATE"
    )
    

update placement
set placementluggage = placementdata.placementluggage,
plluggagepurchased = placementdata.plluggagepurchased,
plluggagecomments = placementdata.plluggagecomments,
updatedon = now(), updatedby = 'CIDM-10053'
from placementdata	
where placement.placementid = placementdata.placementid and placementdata.placementtype = 'PR';

-- updating living arrangement
   

with ladata as ( 
select tab.*	
	,prv1.placementluggage,
	prv1.plluggagepurchased,
	prv1.plluggagecomments
from (
		-- LAs
		select 
			'LA' as placementtype,
			(select c.countyname 
				from caseassignment ca  
				join county c on c.countyid:: character varying = ca.toldssid::character varying
			where ca.objectid = pl.servicecaseid
				and lower(ca.responsibilitytypekey) = 'family'
				and ca.activeflag = 1
			order by ca.insertedon desc
			limit 1
			)  as "LDSS", 
			pr.cjamspid as "CHILD PID",
			sc.servicecasenumber as "CASE ID",
			pr.firstname as "YOUTH FIRST NAME",
			pr.lastname as "YOUTH LAST NAME",
			pr.dob::date as "YOUTH DATE OF BIRTH",
			pl.startdatetime::date as "PLACEMENT/LIVING ARRANGEMENT START DATE",
			pl.enddatetime::date as "PLACEMENT/LIVING ARRANGEMENT END DATE",
			(select rf.value_text
				from referencevalues rf 
			where rf.referencetypeid = 76
				and btrim(rf.ref_key) = btrim(la.livingarrangementtypekey)
			) as "PLACEMENT/LIVING ARRANGEMENT TYPE",
			( select to_char(ro.updatedon, 'yyyy-MM-dd HH12:MI AM') 
				from routing ro
			  where ro.routingstatustypeid = 16 
				and ro.eventcode::text = 'PLTR'::text 
				and ro.activeflag = 1 
				and ro.objectid::text = pl.placementid::character varying::text
				and ro.toroleid <> 'IVESV' 
			  order by ro.insertedon 
			  limit 1
			) as "PLACEMENT/LIVING ARRANGEMENT APPROVAL TIME STAMP",
			(case when la.livingarrangementluggage is null then
				'Missing'
			  when la.livingarrangementluggage = true then
			  	'Yes'
			  when la.livingarrangementluggage = false then
			  	'No'
			end) as "DID THE CHILD HAVE LUGGAGE AT TIME OF PLACEMENT/LIVING ARRANGEMENT?",
			(case when la.livingarrangementluggage = true then 
				'-'
			else
				(case when la.laluggagepurchased is null then
					'Missing'
				  when la.laluggagepurchased = true then
				  	'Yes'
				  when la.laluggagepurchased = false then
				  	'No'
				end) 
			end) as "WAS NEW LUGGAGE PURCHASED AT THE TIME OF THE PLACEMENT/LIVING ARRANGEMENT?",
			(case when la.laluggagepurchased = true then 
				'-'
			else
				la.laluggagecomments
			end)  as "COMMENTS",
			to_char(pl.insertedon, 'yyyy-MM-dd HH12:MI AM') as "Placement Create Tiemsatmp",
			pl.placementid,
			pl.alternateid,
			null as placementrevisionid
		from placement pl,
			livingarrangement la,
			person pr,
			servicecase sc 
		where pl.placementid = la.placementid
			and pl.personid = pr.personid
			and pl.servicecaseid = sc.servicecaseid
			and pl.activeflag = 1
			and la.activeflag = 1
			and pr.activeflag = 1
			and sc.activeflag = 1
			and pl.altproviderid is null -- LAs
			and ( SELECT count(*) AS count
					   FROM routing
				  WHERE routing.routingstatustypeid = 16 
					AND routing.eventcode::text = 'PLTR'::text 
					AND routing.activeflag = 1 
					AND routing.objectid::text = pl.placementid::character varying::text
				 ) > 0 
			and pl.startdatetime::date >= '2024-10-16'::date
	union all		
	-- Provider Placements
	select 
		'PR' as placmentype,
		(select c.countyname 
			from caseassignment ca  
			join county c on c.countyid:: character varying = ca.toldssid::character varying
		where ca.objectid = pl.servicecaseid
			and lower(ca.responsibilitytypekey) = 'family'
			and ca.activeflag = 1
		order by ca.insertedon desc
		limit 1
		)  as "LDSS", 
		pr.cjamspid as "CHILD PID",
		sc.servicecasenumber as "CASE ID",
		pr.firstname as "YOUTH FIRST NAME",
		pr.lastname as "YOUTH LAST NAME",
		pr.dob::date as "YOUTH DATE OF BIRTH",
		pl.startdatetime::date as "PLACEMENT/LIVING ARRANGEMENT START DATE",
		pl.enddatetime::date as "PLACEMENT/LIVING ARRANGEMENT END DATE",
		(select sv.service_nm 
			from prov.tb_services sv 
		where sv.service_id = pl.service_id 
		) as "PLACEMENT/LIVING ARRANGEMENT TYPE",
		( select to_char(ro.updatedon, 'yyyy-MM-dd HH12:MI AM') 
			from routing ro
		  where ro.routingstatustypeid = 16 
			and ro.eventcode::text = 'PLTR'::text 
			and ro.activeflag = 1 
			and ro.objectid::text = pl.placementid::character varying::text
			and ro.toroleid <> 'IVESV' 
		  order by ro.insertedon 
		  limit 1
		) as "PLACEMENT/LIVING ARRANGEMENT APPROVAL TIME STAMP",
		(case when pl.placementluggage is null then
			'Missing'
		  when pl.placementluggage = true then
		  	'Yes'
		  when pl.placementluggage = false then
		  	'No'
		end) as "DID THE CHILD HAVE LUGGAGE AT TIME OF PLACEMENT/LIVING ARRANGEMENT?",
		(case when pl.placementluggage = true then 
			'-'
		else
			(case when pl.plluggagepurchased is null then
				'Missing'
			  when pl.plluggagepurchased = true then
			  	'Yes'
			  when pl.plluggagepurchased = false then
			  	'No'
			end) 
		end) as "WAS NEW LUGGAGE PURCHASED AT THE TIME OF THE PLACEMENT/LIVING ARRANGEMENT?",
		(case when pl.plluggagepurchased = true then 
				'-'
			else
				pl.plluggagecomments
			end) as "COMMENTS",
		to_char(pl.insertedon, 'yyyy-MM-dd HH12:MI AM') as "Placement Create Tiemsatmp",	
		pl.placementid,
		pl.alternateid,
		(select prv.placementrevisionid 
			from placementrevision prv
		where prv.placementid = pl.placementid
			-- and prv.activeflag = 1
			and prv.placementluggage is not null
		order by prv.insertedon desc
		limit 1) as placementrevisionid
	from placement pl,
		person pr,
		servicecase sc 
	where pl.personid = pr.personid
		and pl.servicecaseid = sc.servicecaseid
		and pl.activeflag = 1
		and pr.activeflag = 1
		and sc.activeflag = 1
		and pl.altproviderid is Not null -- Provider Placement
		and ( SELECT count(*) AS count
				   FROM routing
			  WHERE routing.routingstatustypeid = 16 
				AND routing.eventcode::text = 'PLTR'::text 
				AND routing.activeflag = 1 
				AND routing.objectid::text = pl.placementid::character varying::text
			 ) > 0 
		and pl.startdatetime::date >= '2024-10-16'::date 
) tab
left join placementrevision prv1 on prv1.placementrevisionid = tab.placementrevisionid
-- Unit test 
where tab."PLACEMENT/LIVING ARRANGEMENT TYPE" <> 'Runaway'
 	and tab."DID THE CHILD HAVE LUGGAGE AT TIME OF PLACEMENT/LIVING ARRANGEMENT?" = 'Missing'
order by tab."LDSS",
	tab."CASE ID",
	tab."CHILD PID",
	tab."PLACEMENT/LIVING ARRANGEMENT START DATE"
    )
   
update livingarrangement
set livingarrangementluggage = ladata.placementluggage,
laluggagepurchased = ladata.plluggagepurchased,
laluggagecomments = ladata.plluggagecomments,
updatedon = now(), updatedby = 'CIDM-10053'
from ladata
where livingarrangement.placementid = ladata.placementid  and ladata.placementtype = 'LA';


