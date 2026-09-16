-- CDM-10296 - Remove adoption cases from user dashboard that came by mistake

update routing set activeflag=0 where routingid in ('849dda68-c7e8-4575-8eae-d08bb1012550','3e1382ee-4e21-4302-a2e6-d97c580c1b3f','12b5551d-4681-4fa3-9a3c-a2d3e3b2d42f','3f8bab2f-c7b5-4022-8e39-8aac81a1247f','76ad3e15-7068-4f54-944f-6c7bd041894e','3f8bab2f-c7b5-4022-8e39-8aac81a1247f') and activeflag =1;
