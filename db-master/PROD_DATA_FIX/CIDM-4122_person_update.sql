

/*
   Issue Description: CIDM-4122
   Category/ Module  : Person record updates. Need to get the MDM payload and execute to update the same in MDM side
*/

-- 1) SELECT json_agg(a) from sp_get_person_mdm('cf081c07-f2fa-41e6-964b-f307cf186da6') a;
update person 
set updatedby = 'CIDM-4122', updatedon = now(), firstname = 'GODALLAHTRUTH'
where personid = 'cf081c07-f2fa-41e6-964b-f307cf186da6';

-- 2) SELECT json_agg(a) from sp_get_person_mdm('13a88b92-7a5f-4803-a697-f66263069a93') a;
update person 
set updatedby = 'CIDM-4122', updatedon = now(), ssnno = '705435543', cisclientid = '409058136'
where personid = '13a88b92-7a5f-4803-a697-f66263069a93';

update personidentifier 
set updatedby = 'CIDM-4122', updatedon = now(), personidentifiervalue = '705435543'
where personidentifierid = '5e5ebcb7-fc7b-4c19-8306-383114654473';

-- 3) SELECT json_agg(a) from sp_get_person_mdm('3be1ef51-65e9-4200-b6f9-9be904859e61') a;
update person 
set updatedby = 'CIDM-4122', updatedon = now(), dob = '1991-07-18 00:00:00'
where personid = '3be1ef51-65e9-4200-b6f9-9be904859e61';

-- 4) SELECT json_agg(a) from sp_get_person_mdm('d77da323-1d78-4c53-97eb-69dadb9fd693') a;
update person 
set updatedby = 'CIDM-4122', updatedon = now(), dob = '2008-11-21 00:00:00'
where personid = 'd77da323-1d78-4c53-97eb-69dadb9fd693';

-- 5) SELECT json_agg(a) from sp_get_person_mdm('d9b4a0e3-38f0-474c-97b8-8c181978cce4') a;
update person 
set updatedby = 'CIDM-4122', updatedon = now(), lastname = 'Radcliff'
where personid = 'd9b4a0e3-38f0-474c-97b8-8c181978cce4';

-- 6) SELECT json_agg(a) from sp_get_person_mdm('2d9cee3d-87f5-4722-a399-0cabea3b23c8') a;
update person 
set updatedby = 'CIDM-4122', updatedon = now(), lastname = 'SHEPHERD-BENTON'
where personid = '2d9cee3d-87f5-4722-a399-0cabea3b23c8';

-- 7) SELECT json_agg(a) from sp_get_person_mdm('90bb0871-2e21-4e4b-a23e-f6ee7160e4f7') a;
update person 
set updatedby = 'CIDM-4122', updatedon = now(), lastname = 'MOLINA'
where personid = '90bb0871-2e21-4e4b-a23e-f6ee7160e4f7';

-- 8a) SELECT json_agg(a) from sp_get_person_mdm('f8baf6d2-a29b-484b-bde0-54def7629827') a;
-- 8b) SELECT json_agg(a) from sp_get_person_mdm('3a6e6495-28fe-430c-88d1-5716bc580faa') a;
update person 
set updatedby = 'CIDM-4122', updatedon = now(), firstname = 'Artraya', dob = '1978-02-27 00:00:00'
where personid = 'f8baf6d2-a29b-484b-bde0-54def7629827';

update person 
set updatedby = 'CIDM-4122', updatedon = now(), dob = '1978-02-27 00:00:00'
where personid = '3a6e6495-28fe-430c-88d1-5716bc580faa';