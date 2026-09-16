drop function if exists getmdmpersondetailslist(uuid,bigint,bigint);

CREATE OR REPLACE FUNCTION getmdmpersondetailslist(v_personid uuid, v_lipagesize bigint, v_lipagenumber bigint)
 RETURNS json
 LANGUAGE plpgsql
AS $function$


DECLARE 

   	v_pagenumber int;
	v_pageoffset int;
    mdmdata json;
	
BEGIN 

 
IF COALESCE(v_liPageSize, 0) < 1 THEN                     
	v_liPageSize := 10;
END IF;

IF COALESCE(v_liPageNumber, 0) < 1 
THEN
	v_liPageNumber := 1;	
end if;

v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;



select json_agg(b) into mdmdata from (select 
(select row_to_json(clientinfo) from (select p.personid,mgd.mdmgolderpersondetailsid,mgd.insertedon,
p.firstname,p.middlename,p.lastname,
p.prefx as prefixcode,
p.suffix as suffixcode,
concat_ws(' ',p.prefx,p.firstname,p.middlename,p.lastname,p.suffix) as fullname,
p.alienregistrationtext,p.ssnno,p.dob,p.gendertypekey,
(select gt.typedescription from gendertype gt where gt.gendertypekey=p.gendertypekey limit 1) as gender,maritalstatustypekey,
(select rv.value_text from referencevalues rv where rv.ref_key=p.maritalstatustypekey and rv.referencetypeid=118 limit 1) as maritalstatus,
primarylanguageid,
(select rv.value_text from referencevalues rv where rv.ref_key=p.primarylanguageid and rv.referencetypeid=27 limit 1) as primarylanguage,
 ( select concat_ws(' ',address,city,(select rv.value_text from referencevalues rv where rv.referencetypeid=211 and rv.ref_key=pa.state),county,zipcode)
from personaddress pa where pa.personid=p.personid and pa.personaddresstypekey='RES' and pa.adrenddate is null and pa.activeflag=1 limit 1) as residentialaddress,
 ( select concat_ws(' ',address,city,(select rv.value_text from referencevalues rv where rv.referencetypeid=211 and rv.ref_key=pa.state),county,zipcode)
from personaddress pa where pa.personid=p.personid and pa.personaddresstypekey='MAI' and pa.adrenddate is null and pa.activeflag=1 limit 1 ) as mailingaddress,
 ( select phonenumber from personphonenumber pp  where activeflag=1  
 and pp.personid=p.personid and pp.personphonetypekey='1667' limit 1) as homephonenumber,
  ( select phonenumber from personphonenumber pp  where activeflag=1  
 and pp.personid=p.personid and pp.personphonetypekey='1664' limit 1) as cellphonenumber,
   ( select email from personemail pe  where activeflag=1  
 and pe.personid=p.personid and pe.personemailtypekey='P' limit 1) as emailaddress
 from person p where p.personid=mdm.personid ) clientinfo) as clientinfo ,
 
 (select json_agg(clientinfo) from (select mpd.personid,mpd.is_mdm_sync,mpd.insertedon,mpd.mdmgolderpersondetailsid,

(select json_agg(fn) from ( select mpn.firstname,mpn.mdmgoldenpersonnamesid,mpn.updatedon,mpn.firstname_sw as active_sw,mpn.firstnameapp_date as acceptedon,mpn.insertedon
from mdmgoldenpersonnames mpn where mpn.personid = mpd.personid  and mpn.nametypecode='LEGAL' order by mpn.insertedon desc limit 3) fn ) as firstname ,
(select json_agg(mn) from ( select mpn.middlename,mpn.mdmgoldenpersonnamesid,mpn.updatedon,mpn.middlename_sw as active_sw,mpn.middlenameapp_date as acceptedon,mpn.insertedon
from mdmgoldenpersonnames mpn where mpn.personid = mpd.personid and mpn.nametypecode='LEGAL'  order by  mpn.insertedon desc limit 3) mn ) as middlename ,
(select json_agg(lastnames) from ( select  mpn.lastname,mpn.mdmgoldenpersonnamesid,mpn.updatedon,mpn.lastname_sw as active_sw,mpn.lastnameapp_date as acceptedon,mpn.insertedon
from mdmgoldenpersonnames mpn where mpn.personid = mgd.personid and mpn.nametypecode='LEGAL'  order by  mpn.insertedon desc limit 3) lastnames ) as lastname ,
(select json_agg(fn) from ( select  mpn.prefixcode,mpn.mdmgoldenpersonnamesid,mpn.updatedon,mpn.prefix_sw as active_sw,mpn.prefixapp_date as acceptedon,mpn.insertedon
from mdmgoldenpersonnames mpn where mpn.personid = mpd.personid and mpn.nametypecode='LEGAL' order by  mpn.insertedon desc limit 3) fn ) as prefixcode ,
(select json_agg(fn) from ( select   mpn.suffixcode,mpn.mdmgoldenpersonnamesid,mpn.updatedon,mpn.suffix_sw as active_sw,mpn.suffixapp_date as acceptedon,mpn.insertedon
from mdmgoldenpersonnames mpn where mpn.personid = mpd.personid and mpn.nametypecode='LEGAL'  order by mpn.insertedon desc limit 3) fn ) as suffixcode ,
(select json_agg(db) from ( select mpdd.dob,mpdd.mdmgolderpersondetailsid,mpdd.updatedon,mpdd.dob_sw as active_sw,mpdd.dobapp_date as acceptedon,mpdd.insertedon
from mdmgoldenpersondetails mpdd where mpdd.personid = mpd.personid order by mpdd.insertedon desc limit 3) db ) as dob,
(select json_agg(ssn) from ( select mpdd.ssnno,mpdd.mdmgolderpersondetailsid,mpdd.updatedon,mpdd.ssn_sw as active_sw,mpdd.ssnapp_date as acceptedon,mpdd.insertedon
from mdmgoldenpersondetails mpdd where mpdd.personid = mpd.personid order by mpdd.insertedon desc limit 3) ssn ) as ssnno,
(select json_agg(gendertype) from ( select mpdd.gendertypekey,mpdd.mdmgolderpersondetailsid,mpdd.updatedon,mpdd.genderapp_sw as active_sw,(select rv.value_text from referencevalues 
 rv where rv.referencetypeid=301 and rv.ref_key=trim(mpdd.gendertypekey) limit 1) as genderdesc,mpdd.genderapp_date as acceptedon,mpdd.insertedon
from mdmgoldenpersondetails mpdd where mpdd.personid = mpd.personid order by mpdd.insertedon desc limit 3) gendertype ) as gendertypekey,
(select json_agg(maritalstatus) from ( select mpdd.maritalstatustypekey,mpdd.mdmgolderpersondetailsid,mpdd.updatedon,mpdd.marital_sw as active_sw,mpdd.maritalapp_date as acceptedon,mpdd.insertedon,
 (select rv.value_text from referencevalues rv where rv.referencetypeid=118 and rv.ref_key=mpdd.maritalstatustypekey limit 1) as maritalstatusdesc
from mdmgoldenpersondetails mpdd where mpdd.personid = mpd.personid order by mpdd.insertedon desc limit 3) maritalstatus ) as maritalstatustypekey,
(select json_agg(lang) from ( select mpdd.languagecd,mpdd.mdmgolderpersondetailsid,mpdd.updatedon,mpdd.language_sw as active_sw,(select rv.value_text from referencevalues rv 
 where rv.referencetypeid=27 and rv.ref_key= mpdd.languagecd limit 1) as languagedesc,mpdd.languageapp_date as acceptedon,mpdd.insertedon
from mdmgoldenpersondetails mpdd where mpdd.personid = mpd.personid order by mpdd.insertedon desc limit 3) lang ) as languagecd,
(select json_agg(email) from ( select mpe.emailaddress,mpe.mdmgoldenpersonemailsid,mpe.updatedon,mpe.email_sw as active_sw,mpe.emailapp_date as acceptedon,mpe.insertedon
from mdmgoldenpersonemails mpe where mpe.personid = mpd.personid and mpe.emailtype='PERSONAL' order by mpe.insertedon desc limit 3) email ) as email,
(select json_agg(residentialaddress) from (select mpad.addressline1,mpad.addressline2,mpad.addresscity,mpad.addressstate,mpad.addresszip,mpad.mdmgoldenpersonaddressid,mpad.updatedon,mpad.residential_sw as active_sw,mpad.residentialapp_date as acceptedon,mpad.insertedon from mdmgoldenpersonaddress mpad  where mpad.addresstype='RES' and mpad.personid=mpd.personid order by mpad.insertedon desc limit 3) residentialaddress ) as residentialaddress,
(select json_agg(mailingaddress) from (select mpad.addressline1,mpad.addressline2,mpad.addresscity,mpad.addressstate,mpad.addresszip,mpad.mdmgoldenpersonaddressid,mpad.updatedon,mpad.mailing_sw as active_sw, mpad.mailingapp_date as acceptedon,mpad.insertedon  from mdmgoldenpersonaddress mpad  where mpad.addresstype='MAI' and mpad.personid=mpd.personid  order by  mpad.insertedon desc limit 3) mailingaddress ) as mailingaddress,
(select json_agg(homephone) from (select mpad.phonenumber,mpad.mdmgoldenpersonphonesid,mpad.updatedon,mpad.home_sw as active_sw, mpad.homeapp_date as acceptedon,mpad.insertedon from 
mdmgoldenpersonphones mpad  where mpad.phonetype='PERSONAL' and mpad.personid=mpd.personid
order by mpad.insertedon desc limit 3) homephone ) as homephone,
(select json_agg(cellphone) from (select mpad.phonenumber,mpad.mdmgoldenpersonphonesid,mpad.updatedon,mpad.cell_sw as active_sw, mpad.cellapp_date as acceptedon,mpad.insertedon from 
mdmgoldenpersonphones mpad  where mpad.phonetype='BUSINESS' and mpad.personid=mpd.personid
order by mpad.insertedon desc limit 3) cellphone ) as cellphone
from mdmgoldenpersondetails mpd 
where mpd.personid = mgd.personid 
order by mpd.insertedon desc limit 1) clientinfo) as mdminfo
 from person mdm 
 inner join mdmgoldenpersondetails mgd on mgd.personid = mdm.personid 
 where mdm.personid=v_personid order by mgd.insertedon desc limit 1
 )b ;


return mdmdata;

END;


$function$
