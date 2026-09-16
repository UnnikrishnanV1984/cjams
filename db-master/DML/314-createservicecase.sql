UPDATE cjams.servicecase
SET  activeflag=0
WHERE servicecaseid='2c405c20-049d-46a8-bfec-928325dc07dd';

select * from createservicecase('d702ca7f-8b13-43e7-bb63-c288351975ce', 'abb44c4e-901a-44a6-ba96-443226afb8cc', 0, '7407449a-fe4a-4fe4-9f2d-4bbea9c34081',null,null);
