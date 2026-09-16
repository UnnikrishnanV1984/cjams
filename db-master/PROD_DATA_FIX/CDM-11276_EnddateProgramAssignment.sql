-- CDM-11276 - End date program assignments as the case is closed

update personprogramarea set enddate ='2020-06-03 00:00:00', updatedby = 'CDM-11276', updatedon = now() 
where personprogramid in 
('159e9f3c-c988-4000-855e-bd23e18ba3f6',
'e3c4a6d6-9c8b-460f-ac9b-6eb5df35afe9',
'80ed2aba-754c-466e-971a-1360339d04a5',
'ca957c22-dcb9-41ce-8a1c-c2d071dc56fe',
'646e32f2-1299-4c9d-a8f8-177b3fe80284',
'7fa879b3-798a-4cba-9603-a42034489029',
'159e9f3c-c988-4000-855e-bd23e18ba3f6',
'640efb32-3c31-4468-8ca2-eb49fe5cec2f',
'b25401d1-ec1c-42ad-8269-8e5a8fed2a12');