 /*
  Issue Description: CIDM-4247 , CIDM-4246 , CIDM-4245 , CIDM-4244
   Category/ Module  :  MDM update
   Root cause: MDM update
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


--1. 2100809 CIDM-4247
update person 
set lastname = 'Clifton',middlename='M',
updatedby = 'CIDM-4247', updatedon = now()
where personid = 'b50a5f9e-88a2-46c4-bf12-4c89f76fb772' and cjamspid=2100809;
-- SELECT json_agg(a) from sp_get_person_mdm('b50a5f9e-88a2-46c4-bf12-4c89f76fb772') a;

--2. 200566106 CIDM-4246
update person 
set ssnno = '213042303',
updatedby = 'CIDM-4246', updatedon = now()
where personid = '92749434-45c1-4a90-a3e3-cf9af19af112' and cjamspid=200566106;

update personidentifier 
set personidentifiervalue = '213042303',
updatedby = 'CIDM-4246', updatedon = now()
where personid = '92749434-45c1-4a90-a3e3-cf9af19af112' and personidentifiertypekey='SSN' and activeflag=1;

-- SELECT json_agg(a) from sp_get_person_mdm('92749434-45c1-4a90-a3e3-cf9af19af112') a;

--3. 200202651 ,2874842 CIDM-4245 

update person 
set lastname = 'DISNEY',
updatedby = 'CIDM-4245', updatedon = now()
where personid = 'e7bb9755-8779-46fd-948e-f1f668ab0264' and cjamspid=200202651;

update person 
set cisclientid = 422027256,
updatedby = 'CIDM-4245', updatedon = now()
where personid = 'bf421691-6be8-49a6-b08b-c94a5d006548' and cjamspid=2874842;

 
-- SELECT json_agg(a) from sp_get_person_mdm('e7bb9755-8779-46fd-948e-f1f668ab0264') a;

--4. 1660078 CIDM-4244 

update person 
set firstname='Cassandra',middlename='G', lastname='Dismal',
updatedby = 'CIDM-4244', updatedon = now()
where personid = 'cf7cb607-8225-41a7-b6e8-cce4749debc0' and cjamspid=1660078;

-- SELECT json_agg(a) from sp_get_person_mdm('cf7cb607-8225-41a7-b6e8-cce4749debc0') a;
