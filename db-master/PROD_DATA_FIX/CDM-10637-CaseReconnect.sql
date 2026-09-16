-- CDM-10637 - Case reconnect with intake and remove case

select * from createservicecase('9a31fadf-a1bd-43bb-aee9-7dfa05eb3db4','c9b8f007-df4e-4012-8a62-de94b17151f6',0,'eca6f2d2-e3c6-474c-8c4a-d4ee53381883');
update servicecase set activeflag =0, updatedby = 'CDM-10637', updatedon =now() where servicecaseid ='1d92d6b3-e439-4a3b-8c95-26bab5e2187b' and activeflag =1;
