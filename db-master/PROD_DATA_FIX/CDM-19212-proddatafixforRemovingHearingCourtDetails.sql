
/*
   Issue Description: CDM-19212
   Category/ Module  : Removing Hearing Court Details
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

  
/*    
INSERT INTO cjams.hearingclients
(hearingclientid, courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, courtcasenotx, otherclientflag, datavalidflag, clientmergeid, annualnoticebenefitdt, old_id, etl_userid, etl_load_date)
VALUES('806a5d57-3c0f-4332-8b15-5d399fd60a1f'::uuid, 'c5e16bf9-4b31-431b-9acc-5c666957ca36'::uuid, 'ce22087c-0181-4136-89fa-0020f7ad36b1', '2021-12-09 21:45:13.000', 'ce22087c-0181-4136-89fa-0020f7ad36b1', '2021-12-09 21:45:13.000', 1, 'c21baf75-2d13-4cda-bd6a-40fa054ba028'::uuid, '', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.hearingclients
(hearingclientid, courthearingid, updatedby, updatedon, insertedby, insertedon, activeflag, personid, courtcasenotx, otherclientflag, datavalidflag, clientmergeid, annualnoticebenefitdt, old_id, etl_userid, etl_load_date)
VALUES('3720948e-c4d1-47c9-8891-24d6eb14d73b'::uuid, 'c5e16bf9-4b31-431b-9acc-5c666957ca36'::uuid, 'ce22087c-0181-4136-89fa-0020f7ad36b1', '2021-12-09 21:45:13.000', 'ce22087c-0181-4136-89fa-0020f7ad36b1', '2021-12-09 21:45:13.000', 1, 'eba0b472-ec18-4b61-af37-5c410cbf5314'::uuid, '', 0, NULL, NULL, NULL, NULL, NULL, NULL);
*/
    
    
delete hearingclients where hearingclientid in ('806a5d57-3c0f-4332-8b15-5d399fd60a1f','3720948e-c4d1-47c9-8891-24d6eb14d73b')
    
  