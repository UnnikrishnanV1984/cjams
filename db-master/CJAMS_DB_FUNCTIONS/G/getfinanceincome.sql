-- FUNCTION: getfinanceincome( uuid);

-- DROP FUNCTION getfinanceincome( uuid);

CREATE OR REPLACE FUNCTION cjams.getfinanceincome(personid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$


----------------------------------
-- Aurora Issue fixes
-----------------------------------



DECLARE
    
    v_personid uuid;
    
	v_result json;
    


	
BEGIN
    
    v_personid := personid :: uuid;


SELECT json_agg(pi) into v_result FROM 
	(
	select 
		i.incomeid, 
		i.personid, 
		i.startdate, 
		i.enddate, 
		i.datasourcetypekey, 
		i.incomesourcetypekey, 
		(select tcis.income_source_tx as incomesourcetype  from tb_client_income_source tcis where tcis.income_source_id::character varying = i.incomesourcetypekey),
		i.incomefrequencytypekey, 
		(select rv.description as incomefrequencytype  from referencevalues rv where rv.ref_key = i.incomefrequencytypekey and  rv.referencetypeid = 193),
		i.amount, 
		i.verificationtypekey,
		(select rv.description as verificationtype  from referencevalues rv where rv.ref_key = i.verificationtypekey and  rv.referencetypeid = 192),
		i.notes, 
		i.monthlyamount,
    i.incomedisregardflag,
		i.insertedon as entrydate,
		coalesce((select up.fullname from userprofile up where up.securityusersid = i.insertedby), i.insertedby) as enteredby,
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
  ) rce) as "childcareexpenses",
        tcis.earned_sw
		from personincome i 
		inner join tb_client_income_source tcis on i.incomesourcetypekey=tcis.income_source_id::character varying
		where i.personid = v_personid and i.activeflag = 1   		
	) pi;
	
RETURN v_result;

END;



$function$
