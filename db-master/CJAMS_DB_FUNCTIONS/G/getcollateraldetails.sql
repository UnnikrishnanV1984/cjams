DROP FUNCTION IF EXISTS  getcollateraldetails(uuid);
DROP FUNCTION IF EXISTS  getcollateraldetails(text,varchar);
DROP FUNCTION IF EXISTS  getcollateraldetails(varchar,varchar);
CREATE OR REPLACE FUNCTION cjams.getcollateraldetails(p_objectid varchar, p_objecttype character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$


declare l_collateraldetails json;
begin
	
	IF (lower(p_objecttype)='case' and uuid_or_null(p_objectid) is not null ) THEN 
	
 
    select json_agg(coll) into l_collateraldetails from (
    
SELECT col.collateralid, col.referralid, col.caseid, col.prefixtypekey, col.firstname,col.middlename, col.lastname, col.suffixtypekey, col.dob, 
col.ssn, col.primaryracetypekey,  col.relationshiptypekey,  col.testifyflag,  col.attestableinfo,  col.familyknowledge,  col."comments",  col.workphone, 
 col.workextn, col.homephone, col.pager, col.email, col.fax, col.mobile, col.url, col.othercontacts, col.insertedon, col.datenotified, col.clientnotes, col.legalclientid,
 col.expungementflag, col.datavalidflag, col.clientmergeid, col.agencyname,
 concat_ws(' ',coalesce(col.prefixtypekey,null),coalesce( col.firstname,null),coalesce(col.middlename,null),coalesce(col.lastname,null),coalesce(col.suffixtypekey,null) ):: character varying as fullname,
col.intakenumber,col.title,col.objecttype,
 (SELECT  json_agg(address)  as collateraladdress FROM(
 
 
				SELECT coladd.collateraladdressid, coladd.collateralid, coladd.addresstypekey, coladd.formattypekey,
				coladd.streetnumber, coladd.boxnumber, coladd.predirtypekey, coladd.streetnotes, coladd.address1 AS address1, coladd.streetsuffixtypekey,
				coladd.postdirtypekey, coladd.unittypekey, coladd.unitnumbertx, coladd.cityname, coladd.countytypekey,
				coladd.statetypekey, coladd.zip5no, coladd.zip4no, coladd.direction, coladd.foreignaddress, coladd.foreignstate,
				coladd.country, coladd.postalcode, coladd.defaultflag, coladd.startdate, coladd.enddate, coladd.address2
				
				FROM collateraladdress coladd                       
               where coladd.collateralid=col.collateralid
               and coladd.activeflag=1)				
						
                    address  )::json ,
                    
                    (SELECT  json_agg(roles)  as collateralroleconfig FROM(
 
 
				SELECT colrol.collateralroleconfigid, colrol.collateralid, colrol.actortypekey,rv.description
				
				FROM collateralroleconfig colrol 
				inner join referencevalues rv on rv.ref_key=colrol.actortypekey and rv.referencetypeid=175
               where colrol.collateralid=col.collateralid
               and colrol.activeflag=1)				
						
                    roles  )::json  

FROM collateral col 

where col.caseid::varchar=p_objectid and col.activeflag=1
        
        ) as coll;
        
return l_collateraldetails;  

else

    select json_agg(coll) into l_collateraldetails from (
    
SELECT col.collateralid, col.referralid, col.caseid, col.prefixtypekey, col.firstname,col.middlename, col.lastname, col.suffixtypekey, col.dob, 
col.ssn, col.primaryracetypekey,  col.relationshiptypekey,  col.testifyflag,  col.attestableinfo,  col.familyknowledge,  col."comments",  col.workphone, 
 col.workextn, col.homephone, col.pager, col.email, col.fax, col.mobile, col.url, col.othercontacts, col.insertedon, col.datenotified, col.clientnotes, col.legalclientid,
 col.expungementflag, col.datavalidflag, col.clientmergeid, col.agencyname,
 concat_ws(' ',coalesce(col.prefixtypekey,null),coalesce( col.firstname,null),coalesce(col.middlename,null),coalesce(col.lastname,null),coalesce(col.suffixtypekey,null) ):: character varying as fullname,
col.intakenumber,col.title,col.objecttype,
 (SELECT  json_agg(address)  as collateraladdress FROM(
 
 
				SELECT coladd.collateraladdressid, coladd.collateralid, coladd.addresstypekey, coladd.formattypekey,
				coladd.streetnumber, coladd.boxnumber, coladd.predirtypekey, coladd.streetnotes, coladd.address1 AS address1, coladd.streetsuffixtypekey,
				coladd.postdirtypekey, coladd.unittypekey, coladd.unitnumbertx, coladd.cityname, coladd.countytypekey,
				coladd.statetypekey, coladd.zip5no, coladd.zip4no, coladd.direction, coladd.foreignaddress, coladd.foreignstate,
				coladd.country, coladd.postalcode, coladd.defaultflag, coladd.startdate, coladd.enddate, coladd.address2
				
				FROM collateraladdress coladd                       
               where coladd.collateralid=col.collateralid
               and coladd.activeflag=1)				
						
                    address  )::json ,
                    
                    (SELECT  json_agg(roles)  as collateralroleconfig FROM( 
 
				SELECT colrol.collateralroleconfigid, colrol.collateralid, colrol.actortypekey,rv.description
				
				FROM collateralroleconfig colrol 
				inner join referencevalues rv on rv.ref_key=colrol.actortypekey and rv.referencetypeid=175
               where colrol.collateralid=col.collateralid
               and colrol.activeflag=1)				
						
                    roles  )::json  

FROM collateral col 

where col.intakenumber=p_objectid::character varying and col.activeflag=1
        
        ) as coll;
        
return l_collateraldetails;  
END IF; 
end;


$function$;