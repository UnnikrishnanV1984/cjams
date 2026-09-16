

CREATE OR REPLACE FUNCTION cjams.fn_placmnt_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE VAR_PLACEMENT_ID UUID;--
BEGIN
 IF NEW.enddatetime IS NULL THEN

    --IF NEW.startdatetime IS NOT NULL THEN
	
	INSERT INTO caresoutboundtrigger
	( old_id,
                     fk_id,
                    transactionon,
                    transactiontypekey,
                    statusflag,
                    activeflag)
	SELECT
                    (select servicecasenumber from servicecase where servicecaseid=new.servicecaseid),
                     (select cjamspid from person where personid=new.personid),
                     CURRENT_TIMESTAMP,
                     '10',
                     'N',
                     1
					 from placement pl 
					 where pl.placementid=new.placementid;
                
    --END IF;--
	


END IF;--

 if NEW.enddatetime IS NOT NULL THEN


    --IF NEW.enddatetime IS NOT NULL THEN

	INSERT INTO caresoutboundtrigger
	( old_id,
                     fk_id,
                    transactionon,
                    transactiontypekey,
                    statusflag,
                    activeflag)
	SELECT
                    (select servicecasenumber from servicecase where servicecaseid=new.servicecaseid),
                     (select cjamspid from person where personid=new.personid),
                     CURRENT_TIMESTAMP,
                     '70',
                     'N',
                     1
					 from placement pl 
					 where pl.placementid=new.placementid;
	
END IF;--

 if NEW.enddatetime IS NULL THEN

    --IF NEW.startdatetime IS NOT NULL THEN

	INSERT INTO csesoutboundtrigger
	( old_id,
                     fk_id,
                    transactionon,
                    transactiontypekey,
                    statusflag,
                    activeflag)
	SELECT
                    (select servicecasenumber from servicecase where servicecaseid=new.servicecaseid),
                     (select cjamspid from person where personid=new.personid),
                     CURRENT_TIMESTAMP,
                     '10',
                     'N',
                     1
					 from placement pl 
					 where pl.placementid=new.placementid;

    --END IF;--

END IF;--

 if NEW.enddatetime IS NOT NULL THEN

    --IF NEW.enddatetime IS NOT NULL THEN

	INSERT INTO csesoutboundtrigger
	( old_id,
                     fk_id,
                    transactionon,
                    transactiontypekey,
                    statusflag,
                    activeflag)
	SELECT
                    (select servicecasenumber from servicecase where servicecaseid=new.servicecaseid),
                     (select cjamspid from person where personid=new.personid),
                     CURRENT_TIMESTAMP,
                     '70',
                     'N',
                     1
					 from placement pl 
					 where pl.placementid=new.placementid;

    --END IF;--

END IF;--

 
 VAR_PLACEMENT_ID := (SELECT PLACEMENTID FROM livingarrangement WHERE PLACEMENTID = NEW.PLACEMENTID and activeflag= 1 limit 1) ;--

IF VAR_PLACEMENT_ID IS NULL THEN

   Insert into 
 	livingarrangement 
 	(livingid, livingarrangementtypekey,livingstartdate,livingenddate,primarycaregiver, addresstypekey,addressformattypekey
	, streetnumber
	--, streetname
	, boxno,
	addresspredirtypekey,
	streetname,
	streetsuffixtypekey,
	addresspostdirtypekey, 
	addressunittypekey,
	addressunit,
	cityname,
	countytypekey,
	statetypekey,
	zip5no,
	zip4no,
	homephone,
	workphone,
 	livingcomment,
 	personid,
 	insertedon,
 	insertedby,
 	updatedon,
 	updatedby,placementid)
 	(Select gen_random_uuid() ,
 	'32944',
 	NEW.startdatetime , 
 	NEW.enddatetime , 	
 	f_ename('2953',pr.provider_id),
 	coalesce(pa.ADR_TYPE_CD,' '), 
 	coalesce(pa.ADR_FORMAT_CD,' ') ,
 	pa.ADR_STREET_NO, 
	-- pa.ADR_STREET_TX, 
 	pa.ADR_BOX_NO ,
 	coalesce(pa.ADR_PRE_DIR_CD,' ') ,
 	coalesce(pa.ADR_STREET_NM,' ') ,
 	coalesce(pa.ADR_STREET_SUFFIX_CD,' ') ,
 	coalesce(pa.ADR_POST_DIR_CD,' '),
 	coalesce(pa.ADR_UNIT_TYPE_CD ,' '),
 	coalesce(pa.ADR_UNIT_NO_TX ,' '),
 	coalesce(pa.ADR_CITY_NM ,' '),
 	coalesce(pa.ADR_COUNTY_CD ,' '),
 	coalesce(pa.ADR_STATE_CD ,' '),
 	pa.ADR_ZIP5_NO , 
 	pa.ADR_ZIP4_NO ,
 	pr.ADR_HOME_PHONE_TX ,
 	pr.ADR_WORK_PHONE_TX  ,
 	'See Placement Record for more details' ,
	NEW.personid	,
 	current_timestamp,
 	NEW.insertedby ,
 	current_timestamp,
 	NEW.updatedby ,
	NEW.placementid

	--from tb_provider_addresses pa, tb_provider pr
 	--where pa.parent_key_id = NEW.provider_id and 

	from  tb_provider pr left join tb_provider_addresses pa
 	ON pa.parent_key_id :: integer = NEW.altproviderid and 
 	pa.parent_key_id :: integer = pr.provider_id and pa.delete_sw = 'N' and pa.adr_type_cd = '3357' and pa.adr_default_sw = 'Y'
	WHERE
 	NEW.altproviderid = pr.provider_id and
 	NEW.altproviderid is not null and	
 	NEW.startdatetime is not null and NEW.enddatetime is null  and 
 	(NEW.voidflag is null or NEW.voidflag = 1) and NEW.activeflag = 1 and pr.delete_sw ='N'
 	);--

ELSE
	IF NEW.startdatetime IS NOT NULL THEN
		UPDATE livingarrangement  SET livingstartdate = NEW.startdatetime, livingenddate = NEW.enddatetime WHERE PLACEMENTID = NEW.PLACEMENTID ;--
	END IF;--
END IF;--
RETURN NEW;
END;


$function$
;


drop trigger IF EXISTS  tr_placmnt_upd on cjams.placement ;

create trigger tr_placmnt_upd after update
    of enddatetime on
    cjams.placement for each row execute procedure fn_placmnt_upd();
