/*
Issue: Permanency plan
Category/Module: Permanency plan
Root cause: User requested to update the Switch Established Date from 11/05/2024 to 11/04/2024 for all three children, John (PID #2899525), Jorja (PID #2420180), and Jessie (PID #2420177) and Update the provider ID # 5078800 to provider ID# 6144555 on the latest 
subsidy rate slab under John (PID #2899525) and Jessie (PID #2420177).
Client ID#: 1723892 (LANEAH HELEN SHAW)
Fix provided:  Data fix has been done to update the Switch Established Date from 11/05/2024 to 11/04/2024 for all three children, John (PID #2899525), Jorja (PID #2420180), and Jessie (PID #2420177) and Update the provider ID # 5078800 to
 provider ID# 6144555 on the latest subsidy rate slab under John (PID #2899525) and Jessie (PID #2420177).
Data/Code fix ticket#: CJAMS-61102
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update guardianship 
  set effectiveswitchdate = '2024-11-04 05:00:00.000',
     updatedby = 'CJAMS-61102', 
     updatedon = now()
where servicecaseid = '6618772f-fd95-48b1-b637-e7464f6896fc'
 and activeflag = 1;

--Jessie (PID #2420177)
update gapagreementrate 
set provider_id = '6144555', 
    updatedby='CJAMS-61102', 
    updatedon = now() 
where gapagreementid='8dd1ecb1-410a-4c21-8d6f-559909b4e52e' and gapagreementrateid = '12daf289-bebc-42ce-aa8c-c8dfdd4e54ae';

update gapratesrevision 
set providerid = '6144555', 
    updatedby='CJAMS-61102', 
    updatedon = now() 
where gaprateid = '12daf289-bebc-42ce-aa8c-c8dfdd4e54ae';

--John (PID #2899525) 
update gapagreementrate 
set provider_id = '6144555', 
    updatedby='CJAMS-61102', 
    updatedon = now() 
where gapagreementid='85f2eb44-f3fe-4e58-badb-7185cb6c83ea' and gapagreementrateid = '12efcb72-e590-4d4b-b91e-982c36899380';


update gapratesrevision 
set providerid  = '6144555', 
    updatedby='CJAMS-61102', 
    updatedon = now() 
where gaprateid = '12efcb72-e590-4d4b-b91e-982c36899380';




