-- FUNCTION: cjams.addupdatefinanceassets(json)

-- DROP FUNCTION cjams.addupdatefinanceassets(json);

CREATE OR REPLACE FUNCTION cjams.addupdatefinanceassets(
	reqobj json)
    RETURNS json
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$ 
declare
v_personassetid uuid;
v_num int;
v_record json;
returnStatus text;
v_amountowed numeric;
v_facevalue numeric;
v_beneficiaryname varchar;
v_assettypekey varchar;
v_marketvaluetypekey varchar;
v_verificationtypekey varchar;
v_locationname varchar;
v_cityname varchar;
v_statetypekey varchar;
v_personid uuid;
v_notes varchar;
v_disregardflag int;
v_accountno varchar;
v_disposaldate timestamp;
v_purchasedate timestamp;
v_zip5no int;
v_result json;
v_securityuserid varchar;
v_countytypekey varchar;
v_addressline1 varchar;
v_addressline2 varchar;

begin
	
	v_record = reqobj;	
	v_personassetid := v_record ->> 'personassetid';
	v_purchasedate := v_record ->> 'purchasedate';
	v_disposaldate := v_record ->> 'disposaldate'; 
	v_assettypekey := v_record ->> 'assettypekey';
	v_disregardflag := case when (v_record ->> 'disregardflag') = 'Y' THEN 1 else 0 END;
	v_accountno :=  v_record ->> 'accountno';
	v_beneficiaryname :=  v_record ->> 'beneficiaryname';
	v_verificationtypekey :=  v_record ->> 'verificationtypekey';
	v_notes :=  v_record ->> 'notes';
	v_marketvaluetypekey :=  v_record ->> 'marketvaluetypekey';
	v_facevalue :=  v_record ->> 'facevalue';
	v_amountowed :=  v_record ->> 'amountowed';
	v_locationname :=  v_record ->> 'locationname';
	v_cityname :=  v_record ->> 'cityname';
	v_statetypekey :=  v_record ->> 'statetypekey';
	v_zip5no :=  v_record ->> 'zip5no';
	v_personid :=  v_record ->> 'personid';
	v_countytypekey := v_record ->> 'countytypekey';
	v_addressline1 := v_record ->> 'addressline1';
	v_addressline2 := v_record ->> 'addressline2';
	returnStatus := 'Success';
	v_securityuserid := v_record ->> 'currentuser';
	if v_personassetid is null then
	v_personassetid = gen_random_uuid();
	end if;	

	SELECT count(*) into v_num FROM personasset WHERE personassetid = v_personassetid;

	IF (v_num) >= 1
		THEN
		
		UPDATE personasset
		SET  assettypekey= v_assettypekey, marketvaluetypekey=v_marketvaluetypekey, amountowed=v_amountowed, facevalue=v_facevalue, beneficiaryname=v_beneficiaryname, 
		verificationtypekey=v_verificationtypekey, locationname=v_locationname, cityname=v_cityname, countytypekey= v_countytypekey, statetypekey=v_statetypekey, zip5no=v_zip5no, purchasedate=v_purchasedate, disposaldate=v_disposaldate, accountno=v_accountno, updatedon=now(), updatedby=v_securityuserid,disregardflag=v_disregardflag, notes=v_notes, personid=v_personid
		where personassetid= v_personassetid;
			
		else
		 	
			INSERT INTO personasset
			(personassetid, assettypekey, marketvaluetypekey, amountowed, facevalue, beneficiaryname, verificationtypekey, locationname, cityname, countytypekey, statetypekey, zip5no,purchasedate, disposaldate, accountno,insertedon, insertedby, updatedon, updatedby, activeflag, disregardflag, notes, personid, addressline1, addressline2)
			VALUES(v_personassetid, v_assettypekey, v_marketvaluetypekey, v_amountowed, v_facevalue, v_beneficiaryname, v_verificationtypekey, v_locationname, v_cityname, v_countytypekey, v_statetypekey, v_zip5no, v_purchasedate, v_disposaldate, v_accountno, now(), v_securityuserid, now(), v_securityuserid, 1, v_disregardflag, v_notes,v_personid, v_addressline1, v_addressline2);
						
		END IF;
--END LOOP;

select array_to_json(array_agg(row_to_json(t)))
from (
SELECT pa.personassetid,pa.assettypekey, pa.purchasedate, pa.disposaldate, pa.disregardflag, 
 pa.accountno, pa.beneficiaryname, pa.verificationtypekey, pa.notes, pa.marketvaluetypekey, pa.facevalue, pa.amountowed,
pa.locationname, pa.cityname, pa.statetypekey, pa.countytypekey, pa.zip5no, pa.addressline1, pa.addressline2
from personasset pa
WHERE pa.personassetid = v_personassetid and pa.activeflag = 1
 ) t into v_result;

RETURN v_result;
	
end
 $BODY$;

