
UPDATE cjams.person p
SET p.firstname = tbp.first_nm,
 p.lastname = tbp.last_nm,
 p.middlename = tbp.middle_nm,
 p.ssnno = tbp.ssn_no,
 p.dob = tbp.dob_dt,
 p.gendertypekey = case when g.typedescription = 'Female' then 'F' else case when g.typedescription = 'Male' then 'M' end  end
FROM
   cjams.tb_prov_approval_person tbp, gendertype g
WHERE
   tbp.provider_approval_id = 73648 and tbp.delete_sw = 'N' and tbp.person_type_cd = '3610' and  p.cjamspid = '200000042' and tbp.gender_cd = g.gendertypekey;
  
  

 
 
UPDATE cjams.person p
SET p.firstname = tbp.first_nm,
 p.lastname = tbp.last_nm,
 p.middlename = tbp.middle_nm,
 p.ssnno = tbp.ssn_no,
 p.dob = tbp.dob_dt,
 p.gendertypekey = case when g.typedescription = 'Female' then 'F' else case when g.typedescription = 'Male' then 'M' end  end
FROM
   cjams.tb_prov_approval_person tbp, gendertype g
WHERE
   provider_approval_id = 73648 and delete_sw = 'N' and person_type_cd = '3611' and  p.cjamspid = '200000043' and tbp.gender_cd = g.gendertypekey;
   
 
 