--CDM-464 - GAP duplicate issue

--already executed in PROD

--before
/*select * from guardianship where gapid in ('83a2afdb-4230-447d-85c2-a0567ab136a6','299cd909-050d-4226-8ab9-f52604a0e47d');
select * from gapagreement where gapid in ('83a2afdb-4230-447d-85c2-a0567ab136a6','299cd909-050d-4226-8ab9-f52604a0e47d');
select * from gapagreementrevision where gapid in ('83a2afdb-4230-447d-85c2-a0567ab136a6','299cd909-050d-4226-8ab9-f52604a0e47d');
select * from gapagreementrate g where gapagreementid in ('21030d5f-8065-412d-b98a-27492e277c18','aa0f7c72-6d9a-4f10-8019-6d505a5e3a16');
select * from gapratesrevision g where gaprateid in ('b5c8fc32-eb13-412c-a2f8-cf99fe9c8d57','3ece396a-05e4-4734-9327-142b9f0c6ce2');
select * from routing where objectid in ('21030d5f-8065-412d-b98a-27492e277c18','aa0f7c72-6d9a-4f10-8019-6d505a5e3a16'); --agreement
select * from routing r where objectid in ('b5c8fc32-eb13-412c-a2f8-cf99fe9c8d57','3ece396a-05e4-4734-9327-142b9f0c6ce2'); --rate
select * from tb_client_eligibility where guardian_subsidy_id in ( 1005398, 1005399 );

--delete

update guardianship set activeflag = 0, updatedon = now() where gapid in ('83a2afdb-4230-447d-85c2-a0567ab136a6','299cd909-050d-4226-8ab9-f52604a0e47d');

update gapagreement set activeflag = 0, updatedon = now() where gapid in ('83a2afdb-4230-447d-85c2-a0567ab136a6','299cd909-050d-4226-8ab9-f52604a0e47d');

update gapagreementrevision set activeflag = 0, updatedon = now() where gapid in ('83a2afdb-4230-447d-85c2-a0567ab136a6','299cd909-050d-4226-8ab9-f52604a0e47d');

update gapagreementrate g set activeflag = 0, updatedon = now() where gapagreementid in ('21030d5f-8065-412d-b98a-27492e277c18','aa0f7c72-6d9a-4f10-8019-6d505a5e3a16');

update gapratesrevision g set activeflag = 0, updatedon = now() where gaprateid in ('b5c8fc32-eb13-412c-a2f8-cf99fe9c8d57','3ece396a-05e4-4734-9327-142b9f0c6ce2');

update routing set activeflag = 0, updatedon = now() where objectid in ('21030d5f-8065-412d-b98a-27492e277c18','aa0f7c72-6d9a-4f10-8019-6d505a5e3a16'); --agreement

update routing r set activeflag = 0, updatedon = now() where objectid in ('b5c8fc32-eb13-412c-a2f8-cf99fe9c8d57','3ece396a-05e4-4734-9327-142b9f0c6ce2'); --rate

update tb_client_eligibility set delete_sw = 'Y', update_ts = now() where guardian_subsidy_id in ( 1005398, 1005399 );

--after
select * from guardianship where gapid in ('83a2afdb-4230-447d-85c2-a0567ab136a6','299cd909-050d-4226-8ab9-f52604a0e47d');
select * from gapagreement where gapid in ('83a2afdb-4230-447d-85c2-a0567ab136a6','299cd909-050d-4226-8ab9-f52604a0e47d');
select * from gapagreementrevision where gapid in ('83a2afdb-4230-447d-85c2-a0567ab136a6','299cd909-050d-4226-8ab9-f52604a0e47d');
select * from gapagreementrate g where gapagreementid in ('21030d5f-8065-412d-b98a-27492e277c18','aa0f7c72-6d9a-4f10-8019-6d505a5e3a16');
select * from gapratesrevision g where gaprateid in ('b5c8fc32-eb13-412c-a2f8-cf99fe9c8d57','3ece396a-05e4-4734-9327-142b9f0c6ce2');
select * from routing where objectid in ('21030d5f-8065-412d-b98a-27492e277c18','aa0f7c72-6d9a-4f10-8019-6d505a5e3a16'); --agreement
select * from routing r where objectid in ('b5c8fc32-eb13-412c-a2f8-cf99fe9c8d57','3ece396a-05e4-4734-9327-142b9f0c6ce2'); --rate
select * from tb_client_eligibility where guardian_subsidy_id in ( 1005398, 1005399 );
*/