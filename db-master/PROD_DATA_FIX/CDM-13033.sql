update routing
set activeflag=0, updatedon =now(), updatedby = 'CDM-13033'
where routingid  in ('a6bbfd2c-62e4-4ef9-b04c-965e48e28733','8b455f64-e407-42bd-9753-4ee22162dccb','4dacd095-4710-4674-882e-393c2cb39462',
'b98296e4-5ee1-42c9-a36b-e24f8c258eef');

update routing
set activeflag=0, updatedon =now(), updatedby = 'CDM-13166'
where routingid  in ('c1e580a5-a9b7-47f3-b58d-42b3df742c87');
