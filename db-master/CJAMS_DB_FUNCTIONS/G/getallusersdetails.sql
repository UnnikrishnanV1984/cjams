DROP FUNCTION IF EXISTS cjams.getallusersdetails(integer, integer, character varying);
DROP FUNCTION IF EXISTS cjams.getallusersdetails(integer, integer);

CREATE OR REPLACE FUNCTION cjams.getallusersdetails(p_limit integer DEFAULT 100, p_offset integer DEFAULT 0)
 RETURNS TABLE(firstname character varying, lastname character varying, middlename character varying, username character varying, dhsid character varying, mobilenumber character varying, workphonenumber character varying, localdepartmentname character varying, supervisorname character varying, supervisoremail character varying, workeremail character varying, county character varying, countycode character varying, agencycode character varying, teamcode character varying, teamname character varying, openamrole character varying[], positioncode character varying, positiontitle character varying, assupervisoremail character varying, location character varying, zipcode character varying, city character varying, sitecode character varying, agency character varying, address text, userstatus text)
 LANGUAGE plpgsql
AS $function$
-- 3/21/2025 - CIDM-10293 - Created procedure to retrieve all user details with pagination
-- 3/31/2025 - CIDM-10293 - Updated to resolve teammemberid conditionally based on agency type
-- 4/01/2025  Anil Dharni - CIDM-10293- Modified the SP to accept agencycode as the parameter
-- 5/08/2025  Anil Dharni - CIDM-10293- Modified getallusers to return all the values that are being
                                    -- sent as part of the create payload including openamrole
-- 5/08/2025  Anil Dharni - CIDM 10293 Added UNION to return all users (both active and inactive)
-- 5/08/2025  Anil Dharni - CIDM 10293 Added Union All to return all roles available for a user
BEGIN
    RETURN QUERY
    SELECT DISTINCT
        u.firstname, 
        u.lastname, 
        u.middlename,
        u.fullname as username,
        NULL::character varying AS dhsid,
        u2.phonenumber AS mobilenumber,
        u4.phonenumber as workphonenumber,
        t3.teamname AS localdepartmentname,
        sup.fullname AS supervisorfullname,
        sup.email AS supervisoremail,
        u.email AS workeremail,
        c.countyname AS county,
        u.primarycountycd AS countycode,
		t3.teamtypekey AS agencycode,
		t3.teamnumber AS teamcode,
		t3.teamname AS teamname,
        COALESCE(
            (
                SELECT array_agg(DISTINCT r_openamrole ORDER BY r_openamrole)
                FROM (
                    SELECT r2.openamrole AS r_openamrole
                    FROM rolemapping rm2
                    INNER JOIN role r2 ON r2.id = rm2.roleid 
                    WHERE rm2.activeflag = 1
                      AND r2.activeflag = 1
                      AND rm2.principalid = mu.id::varchar

                    UNION ALL

                    SELECT
					  distinct r2.openamrole  AS r_openamrole
					FROM cjams.userresource ur
					 INNER JOIN role r2 ON r2.id = ur.roleid
                    WHERE
					  ur.activeflag = 1 and ur.activeflag = 1
                      AND r2.activeflag = 1
                      AND ur.userid::varchar = mu.id::varchar
                ) roles_union
            ),
            ARRAY[r.openamrole]
        ) AS roles,
		t2.positioncode,
		t2.description::character varying AS positiontitle,
        assup.email AS assupervisoremail,
        NULL::character varying AS location, 
        addr.zipcode,
        addr.city as city,
        NULL::character varying AS sitecode,
        t4.description::character varying AS agency, 
        COALESCE(addr.address, '') || ', ' || 
        COALESCE(addr.city, '') || ', ' || 
        COALESCE(addr.county, '') || ', ' ||  
        COALESCE(addr.state, '') || ' ' || 
        COALESCE(addr.zipcode, '') AS address,
        CASE WHEN u.activeflag = 1 THEN 'Active' ELSE 'Inactive' END AS userstatus
    FROM userprofile u 
    INNER JOIN cjams.muser mu 
        ON mu.securityusersid = u.securityusersid
    INNER JOIN rolemapping rm
        on mu.id::varchar = rm.principalid and case when u.activeflag = 1 then rm.activeflag = 1
        else rm.id in 
        (select id from rolemapping rm1 where rm1.principalid = mu.id::varchar order by insertedon desc limit 1) end
    INNER JOIN role r
        ON r.id = rm.roleid
    INNER JOIN teamtype t4 
        ON t4.teamtypekey = rm.teamtypekey 
    LEFT JOIN teammemberassignment t 
        ON u.securityusersid = t.securityusersid 
    LEFT JOIN as_teammemberassignment tma 
        ON u.securityusersid = tma.securityusersid 
    LEFT JOIN teammember t2 
        ON t2.teammemberid = 
            CASE 
                WHEN rm.teamtypekey = 'AS' THEN tma.teammemberid
                ELSE t.teammemberid
            END
    LEFT JOIN team t3 
        ON t3.teamid = t2.teamid 
    LEFT JOIN county c 
        ON t3.countyid::uuid = c.countyid 
        and c.activeflag=1
    LEFT JOIN userprofilephonenumber u2 
        ON u.securityusersid = u2.securityusersid 
        AND LOWER(u2.userprofiletypekey) = 'cell' and u2.activeflag=1
    LEFT JOIN userprofilephonenumber u4 
        ON u.securityusersid = u4.securityusersid 
        AND LOWER(u4.userprofiletypekey) = 'work'  and u4.activeflag=1
    LEFT JOIN userprofile sup 
        ON sup.securityusersid = u.supervisorid 
    LEFT JOIN cjams.userprofile assup 
        ON assup.securityusersid = u.assupervisorid 
    LEFT JOIN cjams.userprofileaddress addr 
        ON addr.securityusersid = u.securityusersid and addr.activeflag=1
    ORDER BY lastname, firstname
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
