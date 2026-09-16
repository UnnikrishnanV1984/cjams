/*
   Issue Description: CDM-35234 CJAMS issue. Need to deactivate user that have offboarded CJAMS
   Category/ Module  :  user management
   Root cause: Removal of people no longer employed with Howard County DSS
   User list:   Carla Logan
                Steven Plakitsis
                Nancy Voight
                Stephanie Caruso
                Lisa Gresham
                Mary Kelty
                Angelica Christian
                Chanel McCrea
                Carole Miller
                Rachelle Thomas
                Shanquel Saunders
                Michael Demidenko
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment and securityusers tables
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-37387',
    updatedon = now() 
    where email in ('carla.logan@maryland.gov',
                    'steven.plakitsis@maryland.gov',
                    'nancy.voight@maryland.gov',
                    'stephanie.caruso@maryland.gov',
                    'lisa.gresham@maryland.gov',
                    'mary.kelty@maryland.gov',
                    'angelica.christian@maryland.gov',
                    'chanel.mccrea1@maryland.gov',
                    'carole.miller@maryland.gov',
                    'rachelle.thomas1@maryland.gov',
                    'shanquel.saunders@maryland.gov',
                    'mike.demidenko@maryland.gov')
    and activeflag=1;

update muser 
    set activeflag = 0, 
    updatedby = 'CDM-37387', 
    updatedon = now() 
    where email in ('carla.logan@maryland.gov', 
                    'steven.plakitsis@maryland.gov',
                    'nancy.voight@maryland.gov',
                    'stephanie.caruso@maryland.gov',
                    'lisa.gresham@maryland.gov',
                    'mary.kelty@maryland.gov',
                    'angelica.christian@maryland.gov',
                    'chanel.mccrea1@maryland.gov',
                    'carole.miller@maryland.gov',
                    'rachelle.thomas1@maryland.gov',
                    'shanquel.saunders@maryland.gov',
                    'mike.demidenko@maryland.gov'
                    )
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-37387', 
    updatedon = now() 
    where principalid in ('5101',
                          '5173',
                          '5144',
                          '13374',
                          '5211',
                          '5201')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-37387', 
    updatedon = now() 
    where userid in ('5101',
                     '5173',
                     '13374',
                     '5236')
     and activeflag=1;

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-37387', 
    updatedon = now()
    where securityusersid in ('11457dce-c78a-4642-8f2b-96df92c59db7',
                              '3a6c20ab-c946-4c9b-a2b6-5f9b82cf1069',
                              'd3825fc3-5cc4-4d6d-9497-2239458364ae',
                              '410cbb29-03dc-4816-aa5b-b972102e834c',
                              '1a4ef0f8-d04c-4915-8868-ff3792ec61af',
                              'f13ccfc2-d7f8-406f-8f83-8ec87fff2981',
                              '47e075b2-fc74-4d90-a48e-e55f9a29fe0f',
                              '9f75fae1-5e32-40f5-a37b-5064141c9421',
                              'acf8e923-5832-465f-bd9e-a1f3fb5053d9',
                              'eb696dcd-e1e7-4111-b093-18e67973f16a',
                              '10c68179-b8b6-4981-bd0f-d45d8bd27d37',
                              'aeb97e97-e1f7-4688-ab9e-2422bbbfcfc7')
    and activeflag=1;

update teammemberassignment
    set activeflag=0,
    updatedby = 'CDM-37387', 
    updatedon = now() 
    where securityusersid in('47e075b2-fc74-4d90-a48e-e55f9a29fe0f',
                            '1a4ef0f8-d04c-4915-8868-ff3792ec61af',
                            '9f75fae1-5e32-40f5-a37b-5064141c9421',
                            'aeb97e97-e1f7-4688-ab9e-2422bbbfcfc7')
    and activeflag=1;

update securityusers
    set activeflag = 0,
    updatedby = 'CDM-37387', 
    updatedon = now()
    where securityusersid in ('11457dce-c78a-4642-8f2b-96df92c59db7',
                              '3a6c20ab-c946-4c9b-a2b6-5f9b82cf1069',
                              'd3825fc3-5cc4-4d6d-9497-2239458364ae',
                              '410cbb29-03dc-4816-aa5b-b972102e834c',
                              '1a4ef0f8-d04c-4915-8868-ff3792ec61af',
                              'f13ccfc2-d7f8-406f-8f83-8ec87fff2981',
                              '47e075b2-fc74-4d90-a48e-e55f9a29fe0f',
                              '9f75fae1-5e32-40f5-a37b-5064141c9421',
                              'acf8e923-5832-465f-bd9e-a1f3fb5053d9',
                              'eb696dcd-e1e7-4111-b093-18e67973f16a',
                              '10c68179-b8b6-4981-bd0f-d45d8bd27d37',
                              'aeb97e97-e1f7-4688-ab9e-2422bbbfcfc7')
    and activeflag=1;




