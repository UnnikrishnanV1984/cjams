/*
 * CDM-36033 - GAP Subsidy Rate
 * Customer Email ID:tonjua.boston@maryland.gov
 * Customer Name:Tonjua Boston
 * Focus Area:Payments
 * 
 */

--select * from gapagreementrate where gapagreementrateid ='6362ac20-bffd-49f4-8bf2-2e4819815fad' and activeflag=1;
--select * from gapratesrevision where gaprateid ='6362ac20-bffd-49f4-8bf2-2e4819815fad' and activeflag=1;
--select * from routing where objectid ='6362ac20-bffd-49f4-8bf2-2e4819815fad' and activeflag=1;

update gapagreementrate set activeflag =0, updatedby='CDM-36033', updatedon = NOW() where gapagreementrateid ='6362ac20-bffd-49f4-8bf2-2e4819815fad';
update gapratesrevision set activeflag =0, updatedby = 'CDM-36033', updatedon = now() where gaprateid ='6362ac20-bffd-49f4-8bf2-2e4819815fad';
update routing set activeflag =0, updatedby = 'CDM-36033', updatedon = now() where objectid ='6362ac20-bffd-49f4-8bf2-2e4819815fad';
