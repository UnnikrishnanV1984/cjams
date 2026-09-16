/*
   Issue Description: CDM-35234 Suspended accounts still showing
   Category/ Module  :  user management
   Root cause: Removal of people no longer employed with Montgomery County and confirmed all no longer have Sailpoint accounts. 
   User list:   emily.brewster-mccarthy@montgomerycountymd.gov
                daniel.isijola@montgomerycountymd.gov
                julia.woodruff@montgomerycountymd.gov
                alanis.allison@montgomerycountymd.gov
                donta.williams@montgomerycountymd.gov
                doris.cole@montgomerycountymd.gov
                shamara.quinonez@montgomerycountymd.gov
                danielle.richbow@montgomerycountymd.gov
                risa.boswell@montgomerycountymd.gov
                abraham.girmay@montgomerycountymd.gov
                ivy.reed@montgomerycountymd.gov
                nicholas.collins@montgomerycountymd.gov
                danielle.jean@montgomerycountymd.gov
                gillian.anderson@montgomerycountymd.gov
                barbara.fatzinger@montgomerycountymd.gov
                richbd01@montgomerycountymd.gov

   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-42076',
    updatedon = now() 
    where email in ('emily.brewster-mccarthy@montgomerycountymd.gov',
                    'daniel.isijola@montgomerycountymd.gov',
                    'julia.woodruff@montgomerycountymd.gov',
                    'alanis.allison@montgomerycountymd.gov',
                    'donta.williams@montgomerycountymd.gov',
                    'doris.cole@montgomerycountymd.gov',
                    'shamara.quinonez@montgomerycountymd.gov',
                    'danielle.richbow@montgomerycountymd.gov',
                    'risa.boswell@montgomerycountymd.gov',
                    'abraham.girmay@montgomerycountymd.gov',
                    'ivy.reed@montgomerycountymd.gov',
                    'nicholas.collins@montgomerycountymd.gov',
                    'danielle.jean@montgomerycountymd.gov',
                    'gillian.anderson@montgomerycountymd.gov',
                    'barbara.fatzinger@montgomerycountymd.gov',
                    'richbd01@montgomerycountymd.gov')
    and activeflag=1;

update muser 
    set activeflag = 0, 
    updatedby = 'CDM-42076', 
    updatedon = now() 
    where email in ('emily.brewster-mccarthy@montgomerycountymd.gov',
                    'daniel.isijola@montgomerycountymd.gov',
                    'julia.woodruff@montgomerycountymd.gov',
                    'alanis.allison@montgomerycountymd.gov',
                    'donta.williams@montgomerycountymd.gov',
                    'doris.cole@montgomerycountymd.gov',
                    'shamara.quinonez@montgomerycountymd.gov',
                    'danielle.richbow@montgomerycountymd.gov',
                    'risa.boswell@montgomerycountymd.gov',
                    'abraham.girmay@montgomerycountymd.gov',
                    'ivy.reed@montgomerycountymd.gov',
                    'nicholas.collins@montgomerycountymd.gov',
                    'danielle.jean@montgomerycountymd.gov',
                    'gillian.anderson@montgomerycountymd.gov',
                    'barbara.fatzinger@montgomerycountymd.gov',
                    'richbd01@montgomerycountymd.gov'
                                        )
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-42076', 
    updatedon = now() 
    where principalid in ('13311',
                          '4819',
                          '4699',
                          '4707',
                          '4738',
                          '4772',
                          '4818',
                          '39920',
                          '14918',
                          '15014',
                          '22744',
                          '26758',
                          '26791',
                          '29152',
                          '31178',
                          '14317')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-42076', 
    updatedon = now() 
    where userid in ('13311',
                     '4819',
                     '4699',
                     '4707',
                     '4738',
                     '4772',
                     '4818',
                     '39920',
                     '14918',
                     '15014',
                     '22744',
                     '26758',
                     '26791',
                     '29152',
                     '31178')
     and activeflag=1;

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-42076', 
    updatedon = now()
    where securityusersid in('626c6667-7de9-4374-b61a-916ec70c0b2c',
                             'eea0fc67-c449-4127-83da-a1d30096e463',
                             'ca57a50d-06d2-47a9-9a58-c4c80c679db5',
                             '8b96fa1c-b15c-418d-bee3-ce7680a3bd07',
                             'b6707ea7-f93d-47da-8ca7-df595c66951b',
                             'eeaa1297-b4d6-4dbf-a2f9-1895603a39ba',
                             '6a62f355-abfa-483f-9076-31b0c1851682',
                             '2479149e-fb72-4e0d-89b0-d1deb4b3eab1',
                             '6df260d5-64f6-494f-af2d-1084559e103a',
                             '8faad977-3e9e-41e7-b233-00dbcda9e7f5',
                             'bdeeaae0-98c6-4806-aa60-72e94073dab4',
                             'aa6fc5d5-693d-41f6-b52d-7eab7316548a',
                             'f0441f17-e33e-4e29-b3c3-cea37365b046',
                             '56a805df-cafd-40db-9915-990edc519a5d',
                             'ec5e2cb7-5b63-48cd-8cc5-3df23926be08')
    and activeflag=1;

update teammemberassignment
    set activeflag=0,
    updatedby = 'CDM-42076', 
    updatedon = now() 
    where securityusersid in('626c6667-7de9-4374-b61a-916ec70c0b2c',
                             'eea0fc67-c449-4127-83da-a1d30096e463',
                             'ca57a50d-06d2-47a9-9a58-c4c80c679db5',
                             '8b96fa1c-b15c-418d-bee3-ce7680a3bd07',
                             'b6707ea7-f93d-47da-8ca7-df595c66951b',
                             'eeaa1297-b4d6-4dbf-a2f9-1895603a39ba',
                             '6a62f355-abfa-483f-9076-31b0c1851682',
                             '2479149e-fb72-4e0d-89b0-d1deb4b3eab1',
                             '6df260d5-64f6-494f-af2d-1084559e103a',
                             '8faad977-3e9e-41e7-b233-00dbcda9e7f5',
                             'bdeeaae0-98c6-4806-aa60-72e94073dab4',
                             'aa6fc5d5-693d-41f6-b52d-7eab7316548a',
                             'f0441f17-e33e-4e29-b3c3-cea37365b046',
                             '56a805df-cafd-40db-9915-990edc519a5d',
                             'ec5e2cb7-5b63-48cd-8cc5-3df23926be08',
                             'e88119ae-69a3-4e31-843b-4a49fb3ac5b1')
    and activeflag=1;

update securityusers
    set activeflag = 0,
    updatedby = 'CDM-42076', 
    updatedon = now()
    where securityusersid in('626c6667-7de9-4374-b61a-916ec70c0b2c',
                             'eea0fc67-c449-4127-83da-a1d30096e463',
                             'ca57a50d-06d2-47a9-9a58-c4c80c679db5',
                             '8b96fa1c-b15c-418d-bee3-ce7680a3bd07',
                             'b6707ea7-f93d-47da-8ca7-df595c66951b',
                             'eeaa1297-b4d6-4dbf-a2f9-1895603a39ba',
                             '6a62f355-abfa-483f-9076-31b0c1851682',
                             '2479149e-fb72-4e0d-89b0-d1deb4b3eab1',
                             '6df260d5-64f6-494f-af2d-1084559e103a',
                             '8faad977-3e9e-41e7-b233-00dbcda9e7f5',
                             'bdeeaae0-98c6-4806-aa60-72e94073dab4',
                             'aa6fc5d5-693d-41f6-b52d-7eab7316548a',
                             'f0441f17-e33e-4e29-b3c3-cea37365b046',
                             '56a805df-cafd-40db-9915-990edc519a5d',
                             'ec5e2cb7-5b63-48cd-8cc5-3df23926be08')
    and activeflag=1;

update teammember 
set activeflag = 0, 
updatedby = 'CDM-42076', 
updatedon = now()
where teammemberid in  ('c25afdee-d465-4c45-a071-4fbc4ff938c1',
                        '04744f16-aaeb-405f-8bbc-02690c246953',
                        '34516a7b-94de-4744-8fea-ccf95488dd85',
                        '6510d611-29bc-4061-be80-858901ead272',
                        '6921c37d-551e-4f94-ab31-ab6287973e68',
                        '1f5ac7db-cad5-4314-9483-cc895bb31c32',
                        '98c28c64-a5a2-4b3e-adc1-771380f649d2',
                        'ddc80c33-1455-464b-a3a8-6ca7bdda9caf',
                        'd7c3f1ce-3603-43e5-88bb-80f0fbaed4de',
                        '62f28688-0be3-46af-9e9c-dc22e17229b8',
                        'db869a15-6ae7-4d2f-8c56-c65359e6b6e6',
                        'a8d871d7-be9e-4b1b-b45e-264097b4f8aa',
                        '1357c92d-2769-4ced-9fc2-8f15f7a2f84b',
                        'cce63ea7-f231-4ead-ba37-52e30867d3e5',
                        'e169abf3-6c98-46be-9024-371520ae13a6',
                        'e88119ae-69a3-4e31-843b-4a49fb3ac5b1',
                        'ea00e204-e07a-46e4-a6bc-940b6df07b83')
and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-42076', 
    updatedon = now()
    where id='115218054'
    and activeflag = 1;

