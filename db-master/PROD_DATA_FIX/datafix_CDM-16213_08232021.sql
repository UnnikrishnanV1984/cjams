-- CDM-16213 -- Data fix - Open Removals with Exit Reason fix Statewide
/*
-- Issue Description: 
   Datafix to nullify the Removal Exist reasons where Removals are Active (Statewide Fix)
    
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error (Data Issue) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Nulllify the Removal Exit Reasons (Active Removals)
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from intakeservreqchildremoval  
where exitdate is null 	
	and removalexitreason is not null
	and btrim(removalexitreason) <> ''
	and activeflag = 1 ;	
	
update intakeservreqchildremoval
set removalexitreason = NULL,
	updatedby = 'CDM-16213',
	updatedon = now()
where exitdate is null 	
	and removalexitreason is not null
	and btrim(removalexitreason) <> ''
	and activeflag = 1 ;	
	
	
/*
Data as of 08/23/2021 

175499	2015-09-10 00:00:00		EMANIND		CDM-13264	2021-05-28 19:57:01	1
70963	2003-06-12 00:00:00		EMANIND		CDM-14595	2021-07-17 14:02:42	1
157395	2012-11-08 00:00:00		EMANIND		CDM-14116	2021-06-11 19:58:35	1
199529	2020-04-02 00:00:00		CISR		00b6c98a-472c-481e-ae79-ccdd318ded4f	2021-01-15 11:50:08	1
193616	2018-11-07 00:00:00		CGUARDREL	CDM-11239	2021-03-23 20:05:07	1
194241	2018-11-07 00:00:00		CGUARDREL	CDM-11239	2021-03-23 20:05:07	1
184831	2017-04-25 00:00:00		RNAWAY		CDM-14286	2021-06-25 20:07:43	1
68426	2004-01-21 00:00:00		OTHER		CIDM-2505	2021-05-03 19:16:27	1
74621	2003-10-22 00:00:00		OTHER		CIDM-2505	2021-05-03 19:16:27	1
80102	2005-10-20 00:00:00		OTHER		CIDM-2505	2021-05-03 19:16:27	1
69915	2006-04-05 00:00:00		OTHER		CIDM-2505	2021-05-03 19:16:27	1
197669	2019-11-01 00:00:00		CGUARDREL	CIDM-2505	2021-05-03 19:16:27	1
155502	2012-07-17 00:00:00		EMANIND		CIDM-2505	2021-05-03 19:16:27	1
111828	2008-10-08 00:00:00		EMANIND		CIDM-2505_1	2021-05-03 19:16:28	1
190777	2018-04-11 00:00:00		RUF			CDM-15345	2021-07-22 15:56:55	1
183037	2016-12-21 00:00:00		ADPFIN		CDM-15565	2021-08-20 20:43:37	1
252567	2021-06-03 00:00:00		RUF			144b922e-bc2c-4b1a-8048-d479256caa15	2021-08-20 23:17:17	1
*/