DROP FUNCTION IF EXISTS cjams.iscwclient(bigint);
CREATE OR REPLACE FUNCTION cjams.iscwclient(v_cjamspid bigint)
RETURNS integer
LANGUAGE plpgsql
AS $function$
declare
    v_personid uuid;
    v_iscwclient integer;
Begin
    select personid
    into v_personid
    from cjams.person p
    where p.cjamspid = v_cjamspid
    and p.activeflag = 1; 

    if v_personid is not null then
        select (case when count(*) > 0 then 1 else 0 end)
        into v_iscwclient
        from (
        select 1
        from actor act
        where act.personid = v_personid
        and act.activeflag = 1
        and not lower(coalesce(act.objecttype, 'cw')) like 'as%'
        union all
        select 1
        from expunge.actor_expunge enct
        where enct.personid = v_personid
        and enct.activeflag = 1
        );
    else
        v_iscwclient := 0;
    end if; 

    if v_iscwclient IS NULL then
        v_iscwclient := 0;
    end if; 

    RETURN v_iscwclient;
END;
$function$;