/*
   Issue Description: CIDM-6941
   Category/ Module  : Child Removal 
   Root cause: Soft deleting the removal record created in cps case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
    3266667,211030010897,3305151,221030016275,211030011087,221030015962,211030009940,3244100,3262108,2020011801161,
    202108506853,202109707117,211030008873,211030008961,3210065,3228307,3235800,3283628,3294162
*/

update intakeservreqchildremoval isrc
set activeflag = 0, updatedby = 'CIDM-6941', updatedon = now()
where intakeservreqchildremovalid in ('f02b66a8-3d46-4a45-8095-2e4e01051655','308e3df2-f034-4073-80a6-c7479abfd634',
'ba7e9733-729a-4aac-a4c6-835d45f42a41','bb8a8665-13c7-4722-8bb2-9e375bf1522f','2a81d610-a34b-42f0-b572-4da711811a14',
'96184279-6097-4bc6-9742-af4eb6b809f0','6aa7227b-149b-4a35-bc2e-a60039de1bb3','a5007c80-2b8e-48b3-a536-70d92e49bd77',
'507f453f-8bcf-4310-a889-1d9f8edc3143','5bc29b27-a4f4-410a-a165-467ba2b667d6','4adf32d3-570b-4425-9bdd-11ff61214ccb',
'38823818-6f47-4ad9-a420-c805b564d74d','5ded8372-3e70-418d-8920-a0a72e775d58','c523f47c-3e49-42dd-8a47-2f0db8503e66',
'e61130fb-09be-4096-9c94-ddb674f3a644', 'bfd2a1c2-fd27-42a9-a6e5-37d630113edd','557d9cce-078b-4032-b744-8a499a0fd4d0',
'28647a88-5b7c-4041-96c7-b78d6ebb2638','d44a95a2-98c6-4363-be73-c5a56d0b6cc1','c7f32c64-cba7-40f8-a3cd-78870f9f5040',
'a2323439-6e70-4b02-b8af-1d1fba5d9e46','f528e32d-a424-43f8-a160-095dbfdf83e0','5e67a8ea-183d-418b-b8ed-b6b2a92a1756',
'1587f5b5-2826-4135-8d45-103f0538e0f1','d15e2724-56cf-4480-957f-be13cd603871','25b92652-186d-434e-b7a3-db3e2f7717c0',
'3519e247-3505-41ba-abc7-99d78a9fa926');