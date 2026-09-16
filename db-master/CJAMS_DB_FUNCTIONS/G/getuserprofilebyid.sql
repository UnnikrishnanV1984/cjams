
drop function if exists cjams.getuserprofilebyid(securityuserid character varying);

CREATE OR REPLACE FUNCTION cjams.getuserprofilebyid(securityuserid character varying)
 RETURNS TABLE(vsecurityuserid character varying, firstname character varying, middlename character varying, lastname character varying, displayname character varying, fullname character varying, email character varying, 
        dob timestamp, cjamspid bigint, name_suffix character varying, supervisorid character varying, jobtitlecd character varying, userphonenumber json, supprofile json, supervisorphonenumber json)
 LANGUAGE plpgsql
AS $function$

begin
	
	return query
    select u.securityusersid, u.firstname, u.middlename, u.lastname, u.displayname, u.fullname, u.email, u.dob, u.cjamspid, u.name_suffix, u.supervisorid, u.jobtitlecd,
    (
        select json_agg(p) from (
            select userprofiletypekey, phonenumber, phoneextension 
            from userprofilephonenumber up 
            where up.securityusersid = u.securityusersid and up.activeflag = 1 --and up.effectivedate >= now() and (up.expirationdate is not null or up.expirationdate <= now())
        ) as p
    ) as userphonenumber,
    (
        SELECT json_agg (e) FROM
        ( 
            select sup.securityusersid, sup.firstname, sup.middlename, sup.lastname, sup.displayname, sup.fullname, sup.email, sup.dob, sup.cjamspid, sup.name_suffix, sup.supervisorid, sup.jobtitlecd
            from userprofile sup
            where sup.securityusersid = u.supervisorid and sup.activeflag=1 
        )as  e 
    ) as supprofile,
    (
        select json_agg(supphone) from (
            select userprofiletypekey, phonenumber, phoneextension 
            from userprofilephonenumber sup_ph
            where sup_ph.securityusersid = u.supervisorid and sup_ph.activeflag = 1 
        ) as supphone
    ) as supervisorphonenumber
    from userprofile u 
    where u.securityusersid = securityuserid and u.activeflag = 1;
END;

$function$
;