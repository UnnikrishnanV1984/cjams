/*
  Issue Description:  CDM-40143
   Category/ Module  :  Payments
   Root cause: User request to remove the Suspension on 06/22/2024 and edit the suspension start date from 6/1/2024 to 6/14/2024.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

INSERT INTO cjams.adoptioncasesuspensionrevision
(adoptionsuspensionrevisionid,adoptionsuspensionid,adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, etl_userid, etl_load_date)
VALUES(gen_random_uuid (),'a53413b2-687c-48e3-8730-ce13048a5510', 'f4b4e7cd-d89b-4a8e-a1b3-845eda031d06', '2024-06-25 08:43:05.000', NULL, '2024-06-14 04:00:00.000', NULL, 'The child  has been placed in foster in care. She was on run away for 4-6 week and not in the home.', '3047',now() , NULL, '2024-07-15 12:45:36.736', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', '2024-07-15 12:45:36.736', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 1, '2024-06-25 08:43:05.000', NULL, NULL, NULL, 'd1210fcf-b6c4-4ca3-82ec-7f0b205b39ff', NULL, NULL);

update adoptioncasesuspension
set suspensionbegindate ='2024-06-14 04:00:00', updatedon =now(), updatedby = 'CDM-40143', approvaldate = now()
where adoptionsuspensionid ='a53413b2-687c-48e3-8730-ce13048a5510';

--removing the record
update adoptioncasesuspension
set activeflag=0, updatedon =now(), updatedby ='CDM-40143'
where adoptionsuspensionid ='21f560cc-4f58-406d-8abd-cc7470a146c9';
--no record in adoptioncasesuspensionrevision