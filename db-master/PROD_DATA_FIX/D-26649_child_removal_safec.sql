
update assessmentactor set activeflag = 0, updatedon = now() where assessmentactorid = '5e8b0bc3-589f-48ce-ada3-4ac303a45107';

update intakeservicerequestactor set servicecaseid = '88c4ca56-053e-4900-9192-8686c69764cf' , 
updatedon = now() where intakeservicerequestactorid = 'be255a60-7481-4d6e-905d-be33a62e22ab' ;

update intakeservicerequest set intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', 
actiontype = null, updatedon = now(), activeflag = 0,
updatedby ='D-26537' where servicerequestnumber = 2020052015961;

update documentproperties set insertedby = '8bc1ab63-2969-4e65-9dea-937cb2b79bf3', 
updatedby = '8bc1ab63-2969-4e65-9dea-937cb2b79bf3'
where insertedby = 'faaf72bc-5da7-4caf-9413-7db22babe7af' and servicecaseid in 
(select servicecaseid from servicecase where servicecasenumber = 3055914) ;

update documentproperties set insertedby = '245c41d3-9ab8-4193-9542-b2c80c82e6c6', 
updatedby = '245c41d3-9ab8-4193-9542-b2c80c82e6c6'
where insertedby = 'd8d2c6f7-e30c-41c4-9361-f01be33eb173' and servicecaseid in 
(select servicecaseid from servicecase where servicecasenumber = 20200310909) ;


update documentproperties set insertedby = '57feed06-822e-468d-b47e-a71006e71e22', 
updatedby = '57feed06-822e-468d-b47e-a71006e71e22'
where insertedby = 'f6efdb48-003a-4874-9aa6-3a01791e8f4c' and servicecaseid in 
(select servicecaseid from servicecase where servicecasenumber = 3298586) ;


update documentproperties set insertedby = '7aabe9fe-8838-41a9-a953-f17e3c9c5de9', 
updatedby = '7aabe9fe-8838-41a9-a953-f17e3c9c5de9'
where insertedby = '547109cd-10d4-4d38-8da0-ad5060b1e9e7' and servicecaseid in 
(select servicecaseid from servicecase where servicecasenumber = 3258960) ;