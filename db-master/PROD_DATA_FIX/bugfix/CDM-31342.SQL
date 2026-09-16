/*
Issue Description: CDM-31342
Root Cause :user wants change the plan established date to 03/02/2023
Data fix :Updated plan established date to 03/02/2023
*/
update permanencyplan set establisheddate ='2023-03-02 04:00:00',updatedby = 'CDM-31342',updatedon = now() where permanencyplanid = '0b2389ea-6fc7-4b2d-a18c-7f7345cb2164';