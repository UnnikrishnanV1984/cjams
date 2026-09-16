-- CDM-28428 - Notifications on a closed case
/*
-- Issue Description: 
   CJAMS is generating the Sex-Trafficking Notifications for Closed Cases 

-- Case ID: 3176280 - 9245e1ae-9849-4fea-8e1c-f17d81255905
-- Carroll County: Peg Ryan (peg.ryan@maryland.gov) - 88f55d96-49e4-49c4-bf29-08490b292d32
  
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: CJAMS User Notification batch code was not having logic to check for the Service Case status  
-- Fix Provided: CJAMS User Notification batch code was modified to exclude Closed Service cases and the datafix was promoted to remove all incorrect user notifications which are generated after the case closure.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod Deployment 
*/

select usernotificationmapid, activeflag, updatedby, updatedon 
	from usernotificationmap
where activeflag = 1
	and usernotificationid in (
								select un.usernotificationid
									from usernotification un 
								where un.activeflag = 1
									and un.old_id like 'MS_%'
									and (select (case when sd.intakeserreqstatustypekey <> 'Closed' then 
													sd.intakeserreqstatustypekey
												else 
													(case when (select ro.routingstatustypeid
																from routing ro 
																where ro.objectid = sd.servicecasedispositionid::character varying
																and ro.activeflag = 1
																order by ro.insertedon desc
																limit 1
																) = 16 then 
														sd.intakeserreqstatustypekey
													else
														'Open'
													end )
												end )
											from servicecasedisposition sd
										 where sd.servicecaseid = un.objectid::uuid
											and sd.activeflag = 1
										order by sd.insertedon desc
										limit 1
										) =  'Closed'
									and un.insertedon >= 
											(select (select ro.updatedon 
														from routing ro 
													 where ro.objectid = sd.servicecasedispositionid::character varying
														and ro.activeflag = 1
													 order by ro.insertedon desc
													limit 1
													)
												from servicecasedisposition sd
											 where sd.servicecaseid = un.objectid::uuid
												and sd.activeflag = 1
											order by sd.insertedon desc
											limit 1
											)
							);
								
update usernotificationmap
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-28428'
where activeflag = 1
	and usernotificationid in (
								select un.usernotificationid
									from usernotification un 
								where un.activeflag = 1
									and un.old_id like 'MS_%'
									and (select (case when sd.intakeserreqstatustypekey <> 'Closed' then 
													sd.intakeserreqstatustypekey
												else 
													(case when (select ro.routingstatustypeid
																from routing ro 
																where ro.objectid = sd.servicecasedispositionid::character varying
																and ro.activeflag = 1
																order by ro.insertedon desc
																limit 1
																) = 16 then 
														sd.intakeserreqstatustypekey
													else
														'Open'
													end )
												end )
											from servicecasedisposition sd
										 where sd.servicecaseid = un.objectid::uuid
											and sd.activeflag = 1
										order by sd.insertedon desc
										limit 1
										) =  'Closed'
									and un.insertedon >= 
											(select (select ro.updatedon 
														from routing ro 
													 where ro.objectid = sd.servicecasedispositionid::character varying
														and ro.activeflag = 1
													 order by ro.insertedon desc
													limit 1
													)
												from servicecasedisposition sd
											 where sd.servicecaseid = un.objectid::uuid
												and sd.activeflag = 1
											order by sd.insertedon desc
											limit 1
											)
							);

select usernotificationid, old_id, activeflag, updatedby, updatedon, subject
	from usernotification
where activeflag = 1 
	and usernotificationid in (
								select un.usernotificationid
									from usernotification un 
								where un.activeflag = 1
									and un.old_id like 'MS_%'
									and (select (case when sd.intakeserreqstatustypekey <> 'Closed' then 
													sd.intakeserreqstatustypekey
												else 
													(case when (select ro.routingstatustypeid
																from routing ro 
																where ro.objectid = sd.servicecasedispositionid::character varying
																and ro.activeflag = 1
																order by ro.insertedon desc
																limit 1
																) = 16 then 
														sd.intakeserreqstatustypekey
													else
														'Open'
													end )
												end )
											from servicecasedisposition sd
										 where sd.servicecaseid = un.objectid::uuid
											and sd.activeflag = 1
										order by sd.insertedon desc
										limit 1
										) =  'Closed'
									and un.insertedon >= 
											(select (select ro.updatedon 
														from routing ro 
													 where ro.objectid = sd.servicecasedispositionid::character varying
														and ro.activeflag = 1
													 order by ro.insertedon desc
													limit 1
													)
												from servicecasedisposition sd
											 where sd.servicecaseid = un.objectid::uuid
												and sd.activeflag = 1
											order by sd.insertedon desc
											limit 1
											)
							);

update usernotification
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-28428'
where activeflag = 1 
	and usernotificationid in (
								select un.usernotificationid
									from usernotification un 
								where un.activeflag = 1
									and un.old_id like 'MS_%'
									and (select (case when sd.intakeserreqstatustypekey <> 'Closed' then 
													sd.intakeserreqstatustypekey
												else 
													(case when (select ro.routingstatustypeid
																from routing ro 
																where ro.objectid = sd.servicecasedispositionid::character varying
																and ro.activeflag = 1
																order by ro.insertedon desc
																limit 1
																) = 16 then 
														sd.intakeserreqstatustypekey
													else
														'Open'
													end )
												end )
											from servicecasedisposition sd
										 where sd.servicecaseid = un.objectid::uuid
											and sd.activeflag = 1
										order by sd.insertedon desc
										limit 1
										) =  'Closed'
									and un.insertedon >= 
											(select (select ro.updatedon 
														from routing ro 
													 where ro.objectid = sd.servicecasedispositionid::character varying
														and ro.activeflag = 1
													 order by ro.insertedon desc
													limit 1
													)
												from servicecasedisposition sd
											 where sd.servicecaseid = un.objectid::uuid
												and sd.activeflag = 1
											order by sd.insertedon desc
											limit 1
											)
							);