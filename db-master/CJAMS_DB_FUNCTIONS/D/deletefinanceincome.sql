-- FUNCTION: deletefinanceincome( uuid, uuid);

-- DROP FUNCTION deletefinanceincome( uuid, uuid);

CREATE OR REPLACE FUNCTION deletefinanceincome( incomeid uuid, personid uuid )
    RETURNS json 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$



DECLARE
    
    v_incomeid uuid;
    v_stepparentid uuid;
    v_personid uuid;
	v_result json;
    


	
BEGIN
    
    v_incomeid := incomeid :: uuid;

    v_personid := personid :: uuid;

    select deemed_income_stepparent_id into v_stepparentid from tb_deemed_income_stepparent dis where dis.incomeid = v_incomeid;

update personincome pi set 

activeflag = 0

where pi.incomeid = v_incomeid;


update tb_deemed_income_stepparent dis set 

delete_sw = 0

where dis.deemed_income_stepparent_id = v_stepparentid;


update tb_deemed_income_clients dic set 

delete_sw = 0

where dic.deemed_income_stepparent_id = v_stepparentid;

update tb_child_care_expense cce set 

delete_sw = 0

where cce.incomeid = v_incomeid;


SELECT json_agg(pi) into v_result FROM 
	(
	select 
		i.incomeid, 
		i.personid, 
		i.startdate, 
		i.enddate, 
		i.datasourcetypekey, 
		i.incomesourcetypekey, 
		i.incomefrequencytypekey, 
		i.amount, 
		i.verificationtypekey,  
		i.notes, 
		i.monthlyamount,
		(select to_json(rdp) from (
  select 
        deemed_income_stepparent_id,
        case_id as caseid,
        assistance_unit_no,
        notin_assistance_unit_no,
        schedule_h_col_iii_no,
        monthly_gross_earnings_no,
        unearned_income_no,
        court_ordered_support_no,
        earning_disregard_no,
        total_deemed_income_no,
        (select dic.personid from tb_deemed_income_clients dic where dic.deemed_income_stepparent_id = dis.deemed_income_stepparent_id) as "verifiedparentpersonid"
          from tb_deemed_income_stepparent dis where dis.incomeid = i.incomeid and delete_sw = 1
  ) rdp) as "deemedparent",
    (select to_json(rce) from (
  select 
        child_care_expense_id,
        employment_sw as"employmenttypecode",
        amount_earned_no as "amountearned",
        children_under2_no as "childrenunder2",
        children_over2_no as "childrenover2"

   from tb_child_care_expense cce where cce.incomeid = i.incomeid and delete_sw = 1
  ) rce) as "childcareexpenses"
		from personincome i where i.personid = v_personid and i.activeflag = 1   		
	) pi;
	
RETURN v_result;

END;



$BODY$;

ALTER FUNCTION deletefinanceincome ( uuid, uuid)
    OWNER TO welfareadmin;
