-- CIDM-10242 - Missing IRN IDs & MDM IDs data cleanup
/*
-- Issue Description: 
   Person IRN mass data cleanup based on the info provided by the MDM Team.

-- Category/ Module: Person (Person Management) 
-- Root cause: MDM did not assign IRN & MDM IDs for all DHS applications due to the MDM production issue in Jan 2025.
-- Fix Provided: Datafix has been promoted for all impacted person records 
--				 updated the IRN numbers & the MDM provided by the MDM Team.  
-- Pull request# N/A 
-- Is Code fix Required?: No
--	Code fix ticket#: N/A
--	Reason why no related code fix: N/A
--  Regression Impacts: N/A
*/

-- for IRN & MDM ID mass data cleanup (CIDM-10242) 
delete from cjams.personidentifier where insertedby = 'CIDM-10242';

-- Update IRN (cisclientid) in person table
update cjams.person set cisclientid ='557073005', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064496 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='518072293', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064497 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='545071037', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064504 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='520071625', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064535 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='522071626', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064538 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='591071192', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064540 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='542072245', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064543 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='551072379', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064552 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='579071594', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064557 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='513072455', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064558 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='563072005', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064559 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='599072079', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064562 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='553072820', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064563 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='598071327', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064587 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='501071239', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064588 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071850', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064591 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='506072088', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064594 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='522071627', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064595 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='499016918', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064601 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='556071935', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064611 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='557073004', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064613 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='551072378', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064614 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='504072790', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064618 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='520071624', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064619 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='516071387', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064624 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='568071064', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064638 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='553072819', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064639 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='515071779', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064641 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='544071366', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064643 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='562071874', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064644 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='541071410', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064646 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='542072243', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064647 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='593072377', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064673 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='521071472', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064674 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='526071086', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064675 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='518072292', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064676 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='502065791', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064680 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='507071828', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064682 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='531071771', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064687 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='588071305', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064691 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='590071471', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064710 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='529071053', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064711 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='538071934', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064712 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='519071877', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064713 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='591071191', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064717 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='535071326', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064718 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='538071933', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064720 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='559072328', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064724 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='509071783', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064726 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='516071386', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064727 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='509071782', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064729 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='400313615', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064731 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='582071491', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064751 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='400604340', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064754 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071849', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064755 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='563072004', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064756 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='500886701', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064760 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='503075817', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064764 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='524071897', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064766 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='523072180', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064768 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='521071471', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064771 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='550073079', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064773 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='599072078', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064775 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='423004501', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064776 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='501071238', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064777 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='482041209', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064797 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='524071896', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064799 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='511071727', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064802 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='592071558', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064805 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='583071622', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064806 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='575072479', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064807 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='593072376', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064810 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='546071745', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064833 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='521071470', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064834 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='575072478', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064848 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='590071470', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064849 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='595071869', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064850 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='527071978', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064851 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='581072001', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064852 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='511071726', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064854 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='502065790', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064859 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071847', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064860 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='511071725', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064862 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='505071163', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064863 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='595071870', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064864 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='559072327', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064865 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='587071798', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064866 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='585071825', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064888 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='501071237', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064892 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='574072116', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064896 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='543071801', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064898 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='539072439', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064901 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='546071744', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064903 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='506072087', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064931 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='558071900', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064932 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='559072326', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064933 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='523072182', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064934 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='556072197', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064935 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='016454946', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064940 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='476012310', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064947 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='516071385', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064950 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='580071490', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064971 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='400318840', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064976 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='514071715', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064981 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='565072211', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064984 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='585071824', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064985 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='523072181', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064988 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='524071895', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064990 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='520071623', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064991 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='539072438', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064992 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='559072325', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204064994 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='548071096', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065014 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='575072480', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065016 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='510071546', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065017 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='568071063', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065019 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071848', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065026 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='525072920', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065027 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='581072003', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065029 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='528071670', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065030 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='409014268', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065031 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='507071827', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065056 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='548071097', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065061 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='507071826', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065062 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='513072454', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065063 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='538071932', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065064 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='522071625', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065065 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='581072002', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065069 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='552071998', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065071 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='507071824', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065072 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='587071797', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065075 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='554072147', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065076 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='554072146', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065081 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='573071605', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065084 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='523072179', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065085 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='572071525', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065086 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='569072353', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065118 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='503075816', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065125 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='507071825', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065127 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='566071824', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065128 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='502065789', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065130 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='514071714', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065131 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='597072190', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065132 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='560071826', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065133 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='524071894', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065181 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='550073078', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065183 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='527071977', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065728 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='567071854', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065731 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='505071162', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065734 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='544071363', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065736 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='534071889', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065737 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='581072000', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065738 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='588071304', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065739 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='559072324', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065740 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='411012008', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065742 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='529071052', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065743 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='579071593', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065744 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='536072053', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065745 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='475009949', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065749 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='516071384', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065767 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='474052486', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065769 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='400212155', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065772 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='564071809', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065776 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='528071669', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065786 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='596071615', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065792 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='510071545', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065793 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='528071668', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065795 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='551072377', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065796 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='557073003', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065804 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='496024967', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065812 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='504072789', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065819 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='570072040', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065823 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='546071743', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065829 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='557073002', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065830 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071846', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065832 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='598071325', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065833 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='544071365', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065834 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='547071316', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065843 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='578071889', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065845 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='547071315', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065846 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='570072041', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065848 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='560071825', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065849 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='574072115', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065851 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='586071116', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065852 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='501071236', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065854 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='528071667', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065868 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='500886700', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065871 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='521071469', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065874 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='532072200', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065877 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='584072113', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065879 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='554072145', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065880 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='418041947', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065884 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='552071997', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065896 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='502065788', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065909 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='545071036', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065912 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='540071695', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065914 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='560071824', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065918 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='567071853', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065933 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='589072150', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065934 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='562071872', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065936 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='562071873', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065937 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='551072375', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065938 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='594072207', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065939 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='500886699', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065940 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='544071364', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065942 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='561071772', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065944 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='553072818', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065946 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='517071599', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065948 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='538071931', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065963 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='552071996', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065978 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='541071409', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065979 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='578071888', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065980 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='543071800', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065981 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='568071062', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065990 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='585071823', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204065997 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='504072788', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066000 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='597072189', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066002 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='586071115', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066003 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='546071742', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066007 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='558071899', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066009 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='452020145', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066023 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='524071893', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066026 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='490010026', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066029 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071845', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066033 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='513072453', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066036 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='590071469', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066037 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='506072086', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066046 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='598071326', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066047 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='564071808', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066049 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='553072816', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066050 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='541071408', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066051 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='509067147', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066053 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='593072375', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066057 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='554072144', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066083 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='555070777', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066085 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='538071929', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066086 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='555071795', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066087 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='586071114', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066088 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='501071235', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066093 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='511071724', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066095 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='532072199', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066098 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='501071234', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066101 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='547071314', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066110 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='547071313', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066115 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='547071311', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066122 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='547071312', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066124 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071844', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066128 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='445049432', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066141 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='446008818', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066165 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='515071778', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066166 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='506072085', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066173 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='598071324', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066174 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='509071781', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066175 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='524071892', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066183 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='503075815', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066184 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='598071323', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066185 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='570072039', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066189 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='581071999', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066192 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='539072437', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066195 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='551072376', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066216 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='554072143', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066219 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='514071713', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066225 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='509071780', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066237 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='557073001', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066238 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='539072436', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066240 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='555071794', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066248 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='553072817', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066255 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='545071035', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066259 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='523072178', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066260 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='575072477', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066271 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='519071876', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066280 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='542072242', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066282 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='512071967', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066285 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='512071968', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066289 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='547071310', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066294 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='536072050', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066414 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='512071966', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066449 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='525072919', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066454 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='541071405', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066472 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='536072052', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066475 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='553072815', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066477 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='527071976', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066481 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='449010202', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066482 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='585071822', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066483 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='574072114', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066484 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='476049469', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066488 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='528071666', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066505 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='588071303', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066507 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='518072291', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066508 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='572071524', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066510 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='576071537', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066513 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='534071888', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066514 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='583071621', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066515 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='506072084', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066523 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='588071302', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066546 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='545071034', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066547 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='541071407', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066553 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='536072051', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066555 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='551072373', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066556 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='521071468', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066558 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='587071795', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066560 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='515071777', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066561 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='554072141', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066564 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='564071807', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066565 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='555071792', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066571 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='564071806', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066573 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='584072112', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066574 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='548070394', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066575 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071843', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066576 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='562071871', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066596 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='540071694', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066597 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='589072149', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066603 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='592071557', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066608 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='550073077', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066610 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='499016917', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066612 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='588071301', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066635 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='498020316', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066637 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='599072077', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066640 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='572071521', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066642 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='570072038', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066662 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='545071032', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066664 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='556072196', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066665 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='516071383', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066666 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='507071823', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066668 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='496009001', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066669 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='529071051', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066670 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='516071382', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066673 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='555071793', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066674 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='535071324', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066681 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='582071490', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066695 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='539072435', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066699 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='533070975', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066705 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='592071556', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066711 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='509071779', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066712 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='593072374', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066713 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='587071796', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066715 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='529071050', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066719 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='559072323', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066722 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='551072372', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066723 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='545071033', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066725 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='516071381', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066730 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='572071523', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066732 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='549070831', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066733 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='505071161', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066734 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='541071406', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066736 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='453045916', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066737 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='548071095', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066757 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='489022560', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066758 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='512071965', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066759 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='556072195', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066760 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='537071486', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066762 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='522071624', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066769 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='561071770', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066774 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='523072177', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066775 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='594072206', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066776 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='549070830', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066791 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='529071049', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066797 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='556072194', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066802 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='577072067', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066803 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='576071538', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066805 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='546071741', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066807 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='586071113', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066808 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='506072083', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066810 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='432018706', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066813 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='575072476', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066822 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='510071544', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066839 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='588071300', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066840 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='526071085', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066842 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='400320837', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066847 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='553072814', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066849 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='525072918', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066850 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='527071974', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066853 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='585071821', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066878 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='583067116', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066879 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='523072176', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066880 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='577072066', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066884 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='514071712', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066885 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='566071823', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066886 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='572071522', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066892 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='584072111', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066893 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='442031800', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066894 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='543071799', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066898 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='514071711', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066909 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='590071468', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066920 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='531071769', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066921 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='569072352', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066923 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='576071536', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066925 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='569072351', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066928 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='591071190', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066929 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='582071489', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066930 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='485010856', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066933 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='535071323', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066955 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='538071928', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066958 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='563072003', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066961 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='583071620', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066962 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='589072148', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066968 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='521071467', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066969 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='563072002', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066971 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='591071189', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204066986 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='583071619', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067460 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='406001738', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067463 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='529071048', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067471 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='417049944', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067489 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='591071188', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067491 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='443059734', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067492 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='574072113', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067495 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='524070778', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067506 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='586071112', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067537 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='560071823', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067538 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='487008788', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067540 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='597072188', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067559 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='543071798', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067560 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='566071822', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067570 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='580071489', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067585 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='559072322', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067590 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='566071821', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067593 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='591071186', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067623 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='557073000', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067626 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='510071543', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067631 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='571071569', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067633 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='427038493', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067649 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='513072452', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067655 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='501071233', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067656 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='455008958', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067659 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='522071623', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067663 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='510071542', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067675 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='505071160', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067676 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='597072187', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067677 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='563072001', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067678 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='521071466', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067680 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='539072434', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067686 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='400353772', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067687 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='541071404', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067703 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='564071804', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067706 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='593072373', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067707 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='506072081', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067708 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='557072998', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067710 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='535071322', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067711 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='527071973', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067712 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='591071187', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067719 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='504072787', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067734 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='527071972', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067737 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='571071567', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067738 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='517071596', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067739 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='525072916', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067740 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='515071775', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067741 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='515071774', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067742 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='584072110', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067743 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='514071710', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067752 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='569072349', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067753 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='598071322', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067778 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='489038419', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067784 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='525072915', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067787 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='596071614', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067788 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='578071886', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067789 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='503075814', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067791 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='522071622', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067793 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='588071299', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067809 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='535071321', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067812 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='520071622', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067813 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='598071321', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067816 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='578071887', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067817 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='517071598', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067820 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='525072917', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067823 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='503075813', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067826 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='580071488', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067827 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='536072049', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067854 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='577072065', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067855 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='595071867', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067858 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='567071851', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067862 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='585071820', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067863 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='599072076', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067864 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='595071868', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067866 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='571071568', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067867 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='507071822', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067868 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='559072321', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067872 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='582071488', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067892 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='546071740', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067894 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='504072786', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067895 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='505071159', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067896 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='544071362', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067898 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='599072075', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067899 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='523072175', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067900 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='567071852', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067901 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='569072350', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067902 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='506072080', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067908 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='557072999', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067924 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='408026395', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067925 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='581071998', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067926 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='553072813', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067927 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='506072082', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067934 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='597072186', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067935 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='587071794', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067937 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='501071232', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067938 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071840', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067939 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071842', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067940 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='583071618', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067945 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='511071723', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067946 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='508071841', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067947 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='539072433', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067948 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='519071875', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067949 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='551072371', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067950 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='566071820', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067951 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='587071793', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067953 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='512071964', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067970 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='585071818', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067974 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='531071768', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067975 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='593072372', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067977 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='594072205', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067984 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='592071555', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067986 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='525072914', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067987 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='517071597', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067988 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='562071870', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067989 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='562071869', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067992 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='520071621', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204067993 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='503075812', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068028 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='534071887', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068032 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='526071083', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068046 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='553072812', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068048 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='454064028', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068050 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='467058085', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068051 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='413009244', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068054 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='597072185', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068055 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='406055564', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068056 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='533070974', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068057 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='510071541', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068058 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='400632911', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068397 and btrim(coalesce(cisclientid, '')) = '';
update cjams.person set cisclientid ='563071748', updatedby = 'CIDM-10242', updatedon = now() where activeflag = 1 and cjamspid = 204068686 and btrim(coalesce(cisclientid, '')) = '';

--  Insert IRN (cisclientid) in personidentifier table
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '466d5b46-f461-4080-a533-a27c2dc9666f', 'IRN', '557073005', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '557073005'
			and pid.personid = '466d5b46-f461-4080-a533-a27c2dc9666f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a1fbe766-4538-4256-9a11-3cc2a6bd2708', 'IRN', '518072293', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '518072293'
			and pid.personid = 'a1fbe766-4538-4256-9a11-3cc2a6bd2708');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '44fafadb-0a3c-4776-b32b-806a797b6e45', 'IRN', '545071037', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '545071037'
			and pid.personid = '44fafadb-0a3c-4776-b32b-806a797b6e45');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3c1301f1-4c1b-43a4-b77a-cafb4f304ebc', 'IRN', '520071625', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '520071625'
			and pid.personid = '3c1301f1-4c1b-43a4-b77a-cafb4f304ebc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7b19cf8b-a003-4b0c-9a95-644682542e94', 'IRN', '522071626', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '522071626'
			and pid.personid = '7b19cf8b-a003-4b0c-9a95-644682542e94');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '60ed178d-563c-40c1-8cf4-b40556c6aa61', 'IRN', '591071192', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '591071192'
			and pid.personid = '60ed178d-563c-40c1-8cf4-b40556c6aa61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2d262284-9ab1-4d9b-bb73-4537484771e8', 'IRN', '542072245', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '542072245'
			and pid.personid = '2d262284-9ab1-4d9b-bb73-4537484771e8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7536a9c9-5449-4d67-9063-46fe18a4153c', 'IRN', '551072379', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '551072379'
			and pid.personid = '7536a9c9-5449-4d67-9063-46fe18a4153c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '868f833e-7316-4734-89fa-a2501b848eca', 'IRN', '579071594', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '579071594'
			and pid.personid = '868f833e-7316-4734-89fa-a2501b848eca');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3b04c22c-9488-4bbf-8a00-50baaf0ec803', 'IRN', '513072455', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '513072455'
			and pid.personid = '3b04c22c-9488-4bbf-8a00-50baaf0ec803');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '30dd4858-3f42-46cc-941c-702c49fa9caf', 'IRN', '563072005', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '563072005'
			and pid.personid = '30dd4858-3f42-46cc-941c-702c49fa9caf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a4a6e9d4-9939-4219-9219-65fa23fc267b', 'IRN', '599072079', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '599072079'
			and pid.personid = 'a4a6e9d4-9939-4219-9219-65fa23fc267b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '834255db-23aa-4728-87b9-da4d0a351f14', 'IRN', '553072820', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '553072820'
			and pid.personid = '834255db-23aa-4728-87b9-da4d0a351f14');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a12943f6-f140-4f46-a38f-16d6225ebb77', 'IRN', '598071327', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '598071327'
			and pid.personid = 'a12943f6-f140-4f46-a38f-16d6225ebb77');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a5dc8721-d097-431c-bc3f-89097647ad2e', 'IRN', '501071239', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '501071239'
			and pid.personid = 'a5dc8721-d097-431c-bc3f-89097647ad2e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd1dacf7e-b5e8-4275-9965-78a5aa989c1d', 'IRN', '508071850', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071850'
			and pid.personid = 'd1dacf7e-b5e8-4275-9965-78a5aa989c1d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cde4bbba-ff17-4869-af20-55e2717146ef', 'IRN', '506072088', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '506072088'
			and pid.personid = 'cde4bbba-ff17-4869-af20-55e2717146ef');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '87de45eb-2061-4638-9015-ec88e51b6e9f', 'IRN', '522071627', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '522071627'
			and pid.personid = '87de45eb-2061-4638-9015-ec88e51b6e9f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '832ef022-e700-4912-aa68-4876b32822d6', 'IRN', '499016918', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '499016918'
			and pid.personid = '832ef022-e700-4912-aa68-4876b32822d6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9d3881e7-ea64-4de9-8af2-3661b635da75', 'IRN', '556071935', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '556071935'
			and pid.personid = '9d3881e7-ea64-4de9-8af2-3661b635da75');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'acb06b51-4fe2-4cda-8ece-1f11eadd4b5e', 'IRN', '557073004', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '557073004'
			and pid.personid = 'acb06b51-4fe2-4cda-8ece-1f11eadd4b5e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a8eecdb9-f74c-41d5-83f7-c7af0c76e458', 'IRN', '551072378', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '551072378'
			and pid.personid = 'a8eecdb9-f74c-41d5-83f7-c7af0c76e458');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6ac9e3db-ae8e-48f6-8912-9187eeda662c', 'IRN', '504072790', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '504072790'
			and pid.personid = '6ac9e3db-ae8e-48f6-8912-9187eeda662c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '636846e9-ec15-4b37-b9bd-18f6db39eebe', 'IRN', '520071624', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '520071624'
			and pid.personid = '636846e9-ec15-4b37-b9bd-18f6db39eebe');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8d7e6ee1-6208-4b85-a737-f07713e17a84', 'IRN', '516071387', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '516071387'
			and pid.personid = '8d7e6ee1-6208-4b85-a737-f07713e17a84');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '01fb9a99-65b6-4cbc-95cc-46b27c16d6d5', 'IRN', '568071064', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '568071064'
			and pid.personid = '01fb9a99-65b6-4cbc-95cc-46b27c16d6d5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'adced735-7990-4df9-86b6-59cd03726c1b', 'IRN', '553072819', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '553072819'
			and pid.personid = 'adced735-7990-4df9-86b6-59cd03726c1b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cb1cb4f1-e9f5-43bb-935e-645ab40b1037', 'IRN', '515071779', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '515071779'
			and pid.personid = 'cb1cb4f1-e9f5-43bb-935e-645ab40b1037');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '631afa37-cebd-4612-bfa0-28db93d97979', 'IRN', '544071366', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '544071366'
			and pid.personid = '631afa37-cebd-4612-bfa0-28db93d97979');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '05fc80eb-ff7d-45c6-b796-bd63f9bbff9f', 'IRN', '562071874', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '562071874'
			and pid.personid = '05fc80eb-ff7d-45c6-b796-bd63f9bbff9f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3df5d37b-8934-4690-a948-7e143fda1210', 'IRN', '541071410', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '541071410'
			and pid.personid = '3df5d37b-8934-4690-a948-7e143fda1210');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a72cd695-4536-41c4-800f-5a431164f978', 'IRN', '542072243', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '542072243'
			and pid.personid = 'a72cd695-4536-41c4-800f-5a431164f978');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '408b8e55-dfb7-4018-8897-f634d52986a8', 'IRN', '593072377', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '593072377'
			and pid.personid = '408b8e55-dfb7-4018-8897-f634d52986a8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e3391f51-04e3-49b5-928c-6e8c2e47e30c', 'IRN', '521071472', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '521071472'
			and pid.personid = 'e3391f51-04e3-49b5-928c-6e8c2e47e30c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd35e1f84-aefa-480e-8ebd-86aef12c0feb', 'IRN', '526071086', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '526071086'
			and pid.personid = 'd35e1f84-aefa-480e-8ebd-86aef12c0feb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5fec9092-9d75-4393-8d0d-2209ab0acb32', 'IRN', '518072292', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '518072292'
			and pid.personid = '5fec9092-9d75-4393-8d0d-2209ab0acb32');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '41aee92f-a514-4b42-b44a-a5d29b0722e4', 'IRN', '502065791', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '502065791'
			and pid.personid = '41aee92f-a514-4b42-b44a-a5d29b0722e4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '71ab4c52-cf3a-4bdb-abcd-36bd749f4c7c', 'IRN', '507071828', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '507071828'
			and pid.personid = '71ab4c52-cf3a-4bdb-abcd-36bd749f4c7c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '79a4d160-8269-428b-9644-0f46110a1819', 'IRN', '531071771', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '531071771'
			and pid.personid = '79a4d160-8269-428b-9644-0f46110a1819');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '437dcc82-94dd-407f-8d83-b04151c2c630', 'IRN', '588071305', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '588071305'
			and pid.personid = '437dcc82-94dd-407f-8d83-b04151c2c630');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '623b57f6-cae0-4469-90b4-811def34ffa1', 'IRN', '590071471', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '590071471'
			and pid.personid = '623b57f6-cae0-4469-90b4-811def34ffa1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4aa57ecd-386a-46b4-82e0-c91f73043e09', 'IRN', '529071053', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '529071053'
			and pid.personid = '4aa57ecd-386a-46b4-82e0-c91f73043e09');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '52302521-12fd-4f61-9963-749be6611def', 'IRN', '538071934', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '538071934'
			and pid.personid = '52302521-12fd-4f61-9963-749be6611def');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '779d0670-800d-46ef-8249-eda0c25f2671', 'IRN', '519071877', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '519071877'
			and pid.personid = '779d0670-800d-46ef-8249-eda0c25f2671');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '06eee475-db5b-411b-b3d0-c4e023a72dab', 'IRN', '591071191', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '591071191'
			and pid.personid = '06eee475-db5b-411b-b3d0-c4e023a72dab');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2038290c-17a3-4577-b785-ce7c92525039', 'IRN', '535071326', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '535071326'
			and pid.personid = '2038290c-17a3-4577-b785-ce7c92525039');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'badff16e-8128-43f8-be7d-64f90ed0745c', 'IRN', '538071933', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '538071933'
			and pid.personid = 'badff16e-8128-43f8-be7d-64f90ed0745c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c001453e-7d66-4927-aa6d-67ae55cc426a', 'IRN', '559072328', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '559072328'
			and pid.personid = 'c001453e-7d66-4927-aa6d-67ae55cc426a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '90445008-2fbe-41af-a364-f9a1807dfe9a', 'IRN', '509071783', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '509071783'
			and pid.personid = '90445008-2fbe-41af-a364-f9a1807dfe9a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9454c0ba-ef57-492a-a334-552cc061dd95', 'IRN', '516071386', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '516071386'
			and pid.personid = '9454c0ba-ef57-492a-a334-552cc061dd95');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '961c6337-dbcf-4fba-b9c2-355f9fb80d43', 'IRN', '509071782', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '509071782'
			and pid.personid = '961c6337-dbcf-4fba-b9c2-355f9fb80d43');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2b619ec4-bbaf-4db6-8a27-fbe56de3cf47', 'IRN', '400313615', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '400313615'
			and pid.personid = '2b619ec4-bbaf-4db6-8a27-fbe56de3cf47');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '893e53f0-6cfc-41a1-b44a-20f4064d55a9', 'IRN', '582071491', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '582071491'
			and pid.personid = '893e53f0-6cfc-41a1-b44a-20f4064d55a9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '02dcb60f-9c71-4b77-b3b5-cc069bfa5cbf', 'IRN', '400604340', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '400604340'
			and pid.personid = '02dcb60f-9c71-4b77-b3b5-cc069bfa5cbf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3b419d14-9cc5-4437-b177-0bacb679e89b', 'IRN', '508071849', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071849'
			and pid.personid = '3b419d14-9cc5-4437-b177-0bacb679e89b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '689e23cd-e5d7-4117-a741-4410677e960a', 'IRN', '563072004', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '563072004'
			and pid.personid = '689e23cd-e5d7-4117-a741-4410677e960a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7fa7cae1-ba6b-40e2-92f3-b67799f93585', 'IRN', '500886701', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '500886701'
			and pid.personid = '7fa7cae1-ba6b-40e2-92f3-b67799f93585');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9bc51e6e-087d-4941-a40b-ace4e21c01ff', 'IRN', '503075817', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '503075817'
			and pid.personid = '9bc51e6e-087d-4941-a40b-ace4e21c01ff');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ddc0e0cd-4f72-4440-a43f-1ee9412ff284', 'IRN', '524071897', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '524071897'
			and pid.personid = 'ddc0e0cd-4f72-4440-a43f-1ee9412ff284');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bb938d7c-bc74-48fc-9304-27aa3e6a52e4', 'IRN', '523072180', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '523072180'
			and pid.personid = 'bb938d7c-bc74-48fc-9304-27aa3e6a52e4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '92cdb3ae-f1bf-4ec0-a738-d0b60d01c662', 'IRN', '521071471', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '521071471'
			and pid.personid = '92cdb3ae-f1bf-4ec0-a738-d0b60d01c662');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '36630938-e064-47fd-b95b-3fd39d8f2099', 'IRN', '550073079', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '550073079'
			and pid.personid = '36630938-e064-47fd-b95b-3fd39d8f2099');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '782fab29-4986-411b-b3ea-1379f18fb579', 'IRN', '599072078', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '599072078'
			and pid.personid = '782fab29-4986-411b-b3ea-1379f18fb579');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '81487fd0-14d9-4291-afac-f7c1457f32a3', 'IRN', '423004501', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '423004501'
			and pid.personid = '81487fd0-14d9-4291-afac-f7c1457f32a3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ade79738-b347-457c-a668-3765c53f7d20', 'IRN', '501071238', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '501071238'
			and pid.personid = 'ade79738-b347-457c-a668-3765c53f7d20');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f2c799f4-b084-4b14-adfe-263a847f2f79', 'IRN', '482041209', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '482041209'
			and pid.personid = 'f2c799f4-b084-4b14-adfe-263a847f2f79');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e895f09c-2542-4378-80f7-e94295584154', 'IRN', '524071896', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '524071896'
			and pid.personid = 'e895f09c-2542-4378-80f7-e94295584154');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b90b3042-91a4-4553-b41d-b86c7d94c2f5', 'IRN', '511071727', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '511071727'
			and pid.personid = 'b90b3042-91a4-4553-b41d-b86c7d94c2f5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'eea5f468-f68f-44ad-9513-5150423c1329', 'IRN', '592071558', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '592071558'
			and pid.personid = 'eea5f468-f68f-44ad-9513-5150423c1329');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bcf7c3e4-2bf7-4c17-aed9-a4160c3f51cf', 'IRN', '583071622', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '583071622'
			and pid.personid = 'bcf7c3e4-2bf7-4c17-aed9-a4160c3f51cf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9be498ab-95af-4cb9-95da-b44216866045', 'IRN', '575072479', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '575072479'
			and pid.personid = '9be498ab-95af-4cb9-95da-b44216866045');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f6b0477c-6f9a-473e-86b4-491d6b395833', 'IRN', '593072376', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '593072376'
			and pid.personid = 'f6b0477c-6f9a-473e-86b4-491d6b395833');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9df48948-69ac-4d9c-b8a3-c2603d2b3591', 'IRN', '546071745', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '546071745'
			and pid.personid = '9df48948-69ac-4d9c-b8a3-c2603d2b3591');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0b556eb7-dd93-4ccc-8ee6-e8f779483a3d', 'IRN', '521071470', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '521071470'
			and pid.personid = '0b556eb7-dd93-4ccc-8ee6-e8f779483a3d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '849aacc9-90a4-45b8-86e7-c67f8312741f', 'IRN', '575072478', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '575072478'
			and pid.personid = '849aacc9-90a4-45b8-86e7-c67f8312741f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2796dcb1-3c58-4185-8f76-ea8265353b16', 'IRN', '590071470', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '590071470'
			and pid.personid = '2796dcb1-3c58-4185-8f76-ea8265353b16');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e2648f2c-ab85-4fcc-86a4-f76e3970f679', 'IRN', '595071869', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '595071869'
			and pid.personid = 'e2648f2c-ab85-4fcc-86a4-f76e3970f679');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '74cf4c99-9140-4fcd-a9f3-c2b0595a72db', 'IRN', '527071978', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '527071978'
			and pid.personid = '74cf4c99-9140-4fcd-a9f3-c2b0595a72db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a98da7d5-3b2f-4f77-b459-2f63d0e1d84c', 'IRN', '581072001', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '581072001'
			and pid.personid = 'a98da7d5-3b2f-4f77-b459-2f63d0e1d84c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bd245847-b4ce-4098-a9bb-9d2e7cd43834', 'IRN', '511071726', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '511071726'
			and pid.personid = 'bd245847-b4ce-4098-a9bb-9d2e7cd43834');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '33ab117b-d982-433f-9f70-719524e71ca0', 'IRN', '502065790', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '502065790'
			and pid.personid = '33ab117b-d982-433f-9f70-719524e71ca0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '428eb312-9071-4035-8c94-85b22b45c05f', 'IRN', '508071847', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071847'
			and pid.personid = '428eb312-9071-4035-8c94-85b22b45c05f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ee6d454f-b304-4b03-b9ed-33ed13ef8596', 'IRN', '511071725', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '511071725'
			and pid.personid = 'ee6d454f-b304-4b03-b9ed-33ed13ef8596');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f5b78530-d196-4bdd-acdc-ca2221def667', 'IRN', '505071163', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '505071163'
			and pid.personid = 'f5b78530-d196-4bdd-acdc-ca2221def667');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '90c4c401-ab29-4620-b368-532a4767b318', 'IRN', '595071870', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '595071870'
			and pid.personid = '90c4c401-ab29-4620-b368-532a4767b318');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '887ac5c0-073e-432b-8cd9-ae58f7d6dea8', 'IRN', '559072327', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '559072327'
			and pid.personid = '887ac5c0-073e-432b-8cd9-ae58f7d6dea8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6e709f2b-5afc-4bff-9e6b-d0c20b8a3444', 'IRN', '587071798', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '587071798'
			and pid.personid = '6e709f2b-5afc-4bff-9e6b-d0c20b8a3444');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '04feabd3-3776-40c2-8a8e-1c9fffd6bf16', 'IRN', '585071825', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '585071825'
			and pid.personid = '04feabd3-3776-40c2-8a8e-1c9fffd6bf16');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '98553efa-0763-4f3f-af86-0401dea36b9c', 'IRN', '501071237', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '501071237'
			and pid.personid = '98553efa-0763-4f3f-af86-0401dea36b9c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '55ed6497-76fa-42e5-8c98-973bec2f1d4a', 'IRN', '574072116', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '574072116'
			and pid.personid = '55ed6497-76fa-42e5-8c98-973bec2f1d4a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5800ef6c-7ebb-4f51-a9f2-1d51149a05d4', 'IRN', '543071801', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '543071801'
			and pid.personid = '5800ef6c-7ebb-4f51-a9f2-1d51149a05d4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5b4d62c8-2f02-4da0-99a5-a31f091bfb6b', 'IRN', '539072439', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '539072439'
			and pid.personid = '5b4d62c8-2f02-4da0-99a5-a31f091bfb6b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '69415eb8-77b7-4b9f-a29c-4943ebad8fdd', 'IRN', '546071744', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '546071744'
			and pid.personid = '69415eb8-77b7-4b9f-a29c-4943ebad8fdd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '667bfc5a-f663-45fb-8ca3-1dbaa7cb2690', 'IRN', '506072087', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '506072087'
			and pid.personid = '667bfc5a-f663-45fb-8ca3-1dbaa7cb2690');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd3aa356c-0ac9-4990-8281-a3588019027b', 'IRN', '558071900', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '558071900'
			and pid.personid = 'd3aa356c-0ac9-4990-8281-a3588019027b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9ebde388-7ac7-4f70-a2ff-8ceb0b86d9b6', 'IRN', '559072326', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '559072326'
			and pid.personid = '9ebde388-7ac7-4f70-a2ff-8ceb0b86d9b6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8fb2d04d-70c4-446f-a1bb-c0fc1e3bdaab', 'IRN', '523072182', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '523072182'
			and pid.personid = '8fb2d04d-70c4-446f-a1bb-c0fc1e3bdaab');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b92cee1f-e440-43f9-beca-8140d6bdce8d', 'IRN', '556072197', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '556072197'
			and pid.personid = 'b92cee1f-e440-43f9-beca-8140d6bdce8d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a9f72935-bdce-42a0-8e77-21f724c5d456', 'IRN', '016454946', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '016454946'
			and pid.personid = 'a9f72935-bdce-42a0-8e77-21f724c5d456');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bf2ff238-d858-4d06-bbad-e9eaa78814a5', 'IRN', '476012310', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '476012310'
			and pid.personid = 'bf2ff238-d858-4d06-bbad-e9eaa78814a5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2e53ad14-9ec4-47e7-904a-56de68139422', 'IRN', '516071385', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '516071385'
			and pid.personid = '2e53ad14-9ec4-47e7-904a-56de68139422');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e485ea61-3989-4829-9cf9-f8c27eddb7a5', 'IRN', '580071490', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '580071490'
			and pid.personid = 'e485ea61-3989-4829-9cf9-f8c27eddb7a5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9a9c2a40-28b2-4d38-b844-11e0e3387465', 'IRN', '400318840', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '400318840'
			and pid.personid = '9a9c2a40-28b2-4d38-b844-11e0e3387465');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'eafa3128-fbe3-43d4-9a24-94089b5a4540', 'IRN', '514071715', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '514071715'
			and pid.personid = 'eafa3128-fbe3-43d4-9a24-94089b5a4540');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1053961e-a80e-4998-9a5c-9673d92f9598', 'IRN', '565072211', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '565072211'
			and pid.personid = '1053961e-a80e-4998-9a5c-9673d92f9598');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a75c523f-23c9-47a3-98f8-f6cd0f50a2db', 'IRN', '585071824', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '585071824'
			and pid.personid = 'a75c523f-23c9-47a3-98f8-f6cd0f50a2db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '706f24e9-2266-4cde-a678-65ff32d2f3e3', 'IRN', '523072181', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '523072181'
			and pid.personid = '706f24e9-2266-4cde-a678-65ff32d2f3e3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '19c10802-9afd-4964-b73e-de0dbb0115cb', 'IRN', '524071895', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '524071895'
			and pid.personid = '19c10802-9afd-4964-b73e-de0dbb0115cb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7fa57733-37a4-4622-b76f-36627f743902', 'IRN', '520071623', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '520071623'
			and pid.personid = '7fa57733-37a4-4622-b76f-36627f743902');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef72a00d-78fa-47cd-95ee-fca24794b5fa', 'IRN', '539072438', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '539072438'
			and pid.personid = 'ef72a00d-78fa-47cd-95ee-fca24794b5fa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '92e02337-e5fd-406d-9d5e-703ae651ea17', 'IRN', '559072325', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '559072325'
			and pid.personid = '92e02337-e5fd-406d-9d5e-703ae651ea17');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c74f2706-2046-4298-8a42-09ab0f3c16cf', 'IRN', '548071096', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '548071096'
			and pid.personid = 'c74f2706-2046-4298-8a42-09ab0f3c16cf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6db3119a-4400-4f07-8f0f-59caf1462bc1', 'IRN', '575072480', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '575072480'
			and pid.personid = '6db3119a-4400-4f07-8f0f-59caf1462bc1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '402833e8-1f2f-41c4-81bf-d96791f2e4df', 'IRN', '510071546', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '510071546'
			and pid.personid = '402833e8-1f2f-41c4-81bf-d96791f2e4df');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'af1ac406-44df-4dd0-a543-0dd42c87cafd', 'IRN', '568071063', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '568071063'
			and pid.personid = 'af1ac406-44df-4dd0-a543-0dd42c87cafd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '93a2f8ee-b07b-4b78-a12d-80dfaf22118b', 'IRN', '508071848', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071848'
			and pid.personid = '93a2f8ee-b07b-4b78-a12d-80dfaf22118b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '26b701f8-0af3-4f67-ac55-7bfa136554de', 'IRN', '525072920', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '525072920'
			and pid.personid = '26b701f8-0af3-4f67-ac55-7bfa136554de');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba65ecf1-9077-4c11-8244-547387ba1006', 'IRN', '581072003', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '581072003'
			and pid.personid = 'ba65ecf1-9077-4c11-8244-547387ba1006');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'db2a6e91-75a2-4947-b22b-6299714e436d', 'IRN', '528071670', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '528071670'
			and pid.personid = 'db2a6e91-75a2-4947-b22b-6299714e436d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '56ec1d97-42f2-4cbd-aa72-07b781a454ef', 'IRN', '409014268', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '409014268'
			and pid.personid = '56ec1d97-42f2-4cbd-aa72-07b781a454ef');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '26573917-c28b-4750-8835-3e99bdc45fc8', 'IRN', '507071827', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '507071827'
			and pid.personid = '26573917-c28b-4750-8835-3e99bdc45fc8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3782f257-9843-4558-88e5-9504fb1c03e6', 'IRN', '548071097', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '548071097'
			and pid.personid = '3782f257-9843-4558-88e5-9504fb1c03e6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '48df6aa4-ffaa-4887-b44f-c063daf6d05e', 'IRN', '507071826', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '507071826'
			and pid.personid = '48df6aa4-ffaa-4887-b44f-c063daf6d05e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0dd93c49-594e-45e1-bd6e-65b72c730e61', 'IRN', '513072454', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '513072454'
			and pid.personid = '0dd93c49-594e-45e1-bd6e-65b72c730e61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ed336d45-cc16-4acc-a28f-0de29c53186d', 'IRN', '538071932', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '538071932'
			and pid.personid = 'ed336d45-cc16-4acc-a28f-0de29c53186d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '52c37aad-c3a9-4dbe-a439-5ff514c30665', 'IRN', '522071625', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '522071625'
			and pid.personid = '52c37aad-c3a9-4dbe-a439-5ff514c30665');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8b3bf5a1-08b5-43cf-b695-080c19cc2b08', 'IRN', '581072002', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '581072002'
			and pid.personid = '8b3bf5a1-08b5-43cf-b695-080c19cc2b08');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e511cff3-57d3-48eb-afad-0d1f58401f17', 'IRN', '552071998', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '552071998'
			and pid.personid = 'e511cff3-57d3-48eb-afad-0d1f58401f17');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '61945298-fe88-469a-aaea-f57f934ab120', 'IRN', '507071824', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '507071824'
			and pid.personid = '61945298-fe88-469a-aaea-f57f934ab120');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b10a9068-71da-438d-b5ee-ec52402413e7', 'IRN', '587071797', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '587071797'
			and pid.personid = 'b10a9068-71da-438d-b5ee-ec52402413e7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8255e289-64ca-4d2b-8499-3d2e60998ea5', 'IRN', '554072147', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '554072147'
			and pid.personid = '8255e289-64ca-4d2b-8499-3d2e60998ea5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9a6d745b-bb81-4fa1-889b-6295ac4ccc2a', 'IRN', '554072146', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '554072146'
			and pid.personid = '9a6d745b-bb81-4fa1-889b-6295ac4ccc2a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ffe25e17-e740-48f0-9712-3f34c10cf866', 'IRN', '573071605', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '573071605'
			and pid.personid = 'ffe25e17-e740-48f0-9712-3f34c10cf866');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f916b8da-6c38-4f9c-af98-514620220d4f', 'IRN', '523072179', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '523072179'
			and pid.personid = 'f916b8da-6c38-4f9c-af98-514620220d4f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3b10e23f-94db-42d1-90c5-3d5a1d3e2fc6', 'IRN', '572071525', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '572071525'
			and pid.personid = '3b10e23f-94db-42d1-90c5-3d5a1d3e2fc6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd928b906-9a71-4aa7-bf7b-ee727b1c1377', 'IRN', '569072353', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '569072353'
			and pid.personid = 'd928b906-9a71-4aa7-bf7b-ee727b1c1377');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f038b0d2-32c2-4c5b-bf96-cbf10673ac8b', 'IRN', '503075816', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '503075816'
			and pid.personid = 'f038b0d2-32c2-4c5b-bf96-cbf10673ac8b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd9c10f3e-127e-48f0-ad5a-6cd5e0e79687', 'IRN', '507071825', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '507071825'
			and pid.personid = 'd9c10f3e-127e-48f0-ad5a-6cd5e0e79687');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '30f2a427-8503-45f5-89e0-17f986d4d558', 'IRN', '566071824', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '566071824'
			and pid.personid = '30f2a427-8503-45f5-89e0-17f986d4d558');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0b78a04c-86fb-43b5-9399-c740d383d796', 'IRN', '502065789', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '502065789'
			and pid.personid = '0b78a04c-86fb-43b5-9399-c740d383d796');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e173ce99-d11f-42bb-9bea-40df039807b3', 'IRN', '514071714', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '514071714'
			and pid.personid = 'e173ce99-d11f-42bb-9bea-40df039807b3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c22061c8-c81b-4f97-9f57-3b920ad8b001', 'IRN', '597072190', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '597072190'
			and pid.personid = 'c22061c8-c81b-4f97-9f57-3b920ad8b001');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ab0957ca-a6d6-4a4b-8431-1608d505a6d7', 'IRN', '560071826', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '560071826'
			and pid.personid = 'ab0957ca-a6d6-4a4b-8431-1608d505a6d7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '25acd46f-2f2b-477e-a77b-e2abdc42955e', 'IRN', '524071894', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '524071894'
			and pid.personid = '25acd46f-2f2b-477e-a77b-e2abdc42955e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bbaeeb74-fe72-4981-beca-5a4aa743feeb', 'IRN', '550073078', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '550073078'
			and pid.personid = 'bbaeeb74-fe72-4981-beca-5a4aa743feeb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '43dd6283-4589-493a-b768-77ef291515c3', 'IRN', '527071977', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '527071977'
			and pid.personid = '43dd6283-4589-493a-b768-77ef291515c3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c8850c47-8513-4d30-b211-944148e854ce', 'IRN', '567071854', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '567071854'
			and pid.personid = 'c8850c47-8513-4d30-b211-944148e854ce');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd22eec64-e913-4b1f-a176-56ad1dd39c88', 'IRN', '505071162', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '505071162'
			and pid.personid = 'd22eec64-e913-4b1f-a176-56ad1dd39c88');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9f81e3c2-be0a-4796-8c17-aa5fc8c93c9a', 'IRN', '544071363', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '544071363'
			and pid.personid = '9f81e3c2-be0a-4796-8c17-aa5fc8c93c9a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cf764f41-2ac6-441c-822d-dc8767816517', 'IRN', '534071889', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '534071889'
			and pid.personid = 'cf764f41-2ac6-441c-822d-dc8767816517');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c1087234-c2da-4067-97ee-cb077196c2ad', 'IRN', '581072000', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '581072000'
			and pid.personid = 'c1087234-c2da-4067-97ee-cb077196c2ad');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2177db5f-8e5a-42be-a0cb-53aeea8eac75', 'IRN', '588071304', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '588071304'
			and pid.personid = '2177db5f-8e5a-42be-a0cb-53aeea8eac75');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'abf83396-3cbb-4f01-8a6a-1ece8763c8ab', 'IRN', '559072324', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '559072324'
			and pid.personid = 'abf83396-3cbb-4f01-8a6a-1ece8763c8ab');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0bda7c63-1014-47ca-8d5c-3546eba652e8', 'IRN', '411012008', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '411012008'
			and pid.personid = '0bda7c63-1014-47ca-8d5c-3546eba652e8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd6d5f878-54ab-40b7-930c-5399eb5b508c', 'IRN', '529071052', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '529071052'
			and pid.personid = 'd6d5f878-54ab-40b7-930c-5399eb5b508c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '959fa2ac-4a6c-4b67-82a3-e250d2204761', 'IRN', '579071593', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '579071593'
			and pid.personid = '959fa2ac-4a6c-4b67-82a3-e250d2204761');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '37a2c588-398f-432b-a4db-04afd3911753', 'IRN', '536072053', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '536072053'
			and pid.personid = '37a2c588-398f-432b-a4db-04afd3911753');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9a2e04ca-0184-4f63-b134-e305c261f280', 'IRN', '475009949', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '475009949'
			and pid.personid = '9a2e04ca-0184-4f63-b134-e305c261f280');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f42df58e-21eb-4d3a-95c0-0b60471b6848', 'IRN', '516071384', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '516071384'
			and pid.personid = 'f42df58e-21eb-4d3a-95c0-0b60471b6848');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '74b166b3-ac85-43c8-b500-dd35f80944fa', 'IRN', '474052486', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '474052486'
			and pid.personid = '74b166b3-ac85-43c8-b500-dd35f80944fa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8c2f5af0-f749-481a-9d14-cada023e1908', 'IRN', '400212155', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '400212155'
			and pid.personid = '8c2f5af0-f749-481a-9d14-cada023e1908');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ebeb1333-3771-4e77-94be-2bfd386a8d1f', 'IRN', '564071809', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '564071809'
			and pid.personid = 'ebeb1333-3771-4e77-94be-2bfd386a8d1f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e327b710-fdcb-4460-8745-e43e282aa411', 'IRN', '528071669', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '528071669'
			and pid.personid = 'e327b710-fdcb-4460-8745-e43e282aa411');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4da60ac4-839d-4568-a681-d0e18a6ebb95', 'IRN', '596071615', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '596071615'
			and pid.personid = '4da60ac4-839d-4568-a681-d0e18a6ebb95');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e064790e-e255-4185-8d96-2c1bff4ccb84', 'IRN', '510071545', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '510071545'
			and pid.personid = 'e064790e-e255-4185-8d96-2c1bff4ccb84');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '827224d5-7c0f-402b-97d6-08f0e6eb65e8', 'IRN', '528071668', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '528071668'
			and pid.personid = '827224d5-7c0f-402b-97d6-08f0e6eb65e8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd83b06bf-4978-4336-a651-3d638832146c', 'IRN', '551072377', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '551072377'
			and pid.personid = 'd83b06bf-4978-4336-a651-3d638832146c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c32ef98c-2a8f-4b17-9378-610f6e0ef78d', 'IRN', '557073003', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '557073003'
			and pid.personid = 'c32ef98c-2a8f-4b17-9378-610f6e0ef78d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7f50726c-d2f7-4122-a699-394d00fd4628', 'IRN', '496024967', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '496024967'
			and pid.personid = '7f50726c-d2f7-4122-a699-394d00fd4628');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '308ca072-da99-4a37-8013-b5659ba4a226', 'IRN', '504072789', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '504072789'
			and pid.personid = '308ca072-da99-4a37-8013-b5659ba4a226');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef247ad8-9c8d-4b8e-9644-970d5beb18d1', 'IRN', '570072040', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '570072040'
			and pid.personid = 'ef247ad8-9c8d-4b8e-9644-970d5beb18d1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4f0a114e-e8fd-4a95-9fce-1a0df3e24055', 'IRN', '546071743', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '546071743'
			and pid.personid = '4f0a114e-e8fd-4a95-9fce-1a0df3e24055');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1e49f577-2fcd-431c-abde-181ed3221741', 'IRN', '557073002', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '557073002'
			and pid.personid = '1e49f577-2fcd-431c-abde-181ed3221741');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2e477717-33f9-43d2-8e67-fbd6468a4a70', 'IRN', '508071846', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071846'
			and pid.personid = '2e477717-33f9-43d2-8e67-fbd6468a4a70');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '55109895-8fb5-4a50-acf7-6e31181b1ee3', 'IRN', '598071325', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '598071325'
			and pid.personid = '55109895-8fb5-4a50-acf7-6e31181b1ee3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'de16d95a-54e5-461b-96c5-d577b1e8e80a', 'IRN', '544071365', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '544071365'
			and pid.personid = 'de16d95a-54e5-461b-96c5-d577b1e8e80a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5a682dfb-f7be-457d-b203-8ef9c162c295', 'IRN', '547071316', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '547071316'
			and pid.personid = '5a682dfb-f7be-457d-b203-8ef9c162c295');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '35bbd083-0243-45d5-bac2-c0061d6cfbaf', 'IRN', '578071889', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '578071889'
			and pid.personid = '35bbd083-0243-45d5-bac2-c0061d6cfbaf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '34e6efb0-2bab-4fb5-9b4d-8d9d72c97137', 'IRN', '547071315', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '547071315'
			and pid.personid = '34e6efb0-2bab-4fb5-9b4d-8d9d72c97137');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cd0b9c08-c2f3-45a0-b04b-666909cd6bb5', 'IRN', '570072041', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '570072041'
			and pid.personid = 'cd0b9c08-c2f3-45a0-b04b-666909cd6bb5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '478ad14e-2aee-41fa-bbfc-55ad1afc83f9', 'IRN', '560071825', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '560071825'
			and pid.personid = '478ad14e-2aee-41fa-bbfc-55ad1afc83f9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '12900d62-82f2-45d8-af70-fc3033a83477', 'IRN', '574072115', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '574072115'
			and pid.personid = '12900d62-82f2-45d8-af70-fc3033a83477');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '540b673c-4be8-45f4-9c3d-b37c970dea7f', 'IRN', '586071116', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '586071116'
			and pid.personid = '540b673c-4be8-45f4-9c3d-b37c970dea7f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5c9164b7-d6b7-4672-b99f-f475dc3f0803', 'IRN', '501071236', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '501071236'
			and pid.personid = '5c9164b7-d6b7-4672-b99f-f475dc3f0803');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6b9ac1be-2bdf-4dff-8dad-7c1264522b7d', 'IRN', '528071667', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '528071667'
			and pid.personid = '6b9ac1be-2bdf-4dff-8dad-7c1264522b7d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fdc53e3d-800e-4556-8f36-af7c3cdbbe76', 'IRN', '500886700', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '500886700'
			and pid.personid = 'fdc53e3d-800e-4556-8f36-af7c3cdbbe76');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'dc2afcd9-fd8f-4856-822a-d09419b13456', 'IRN', '521071469', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '521071469'
			and pid.personid = 'dc2afcd9-fd8f-4856-822a-d09419b13456');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '471e0b4a-2234-4c8a-814d-fcc513b76e75', 'IRN', '532072200', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '532072200'
			and pid.personid = '471e0b4a-2234-4c8a-814d-fcc513b76e75');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ecb9f079-87ce-4b72-bd03-5d5fbaef5cfe', 'IRN', '584072113', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '584072113'
			and pid.personid = 'ecb9f079-87ce-4b72-bd03-5d5fbaef5cfe');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ccce98f5-b72d-4414-b0d5-732f5818f15f', 'IRN', '554072145', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '554072145'
			and pid.personid = 'ccce98f5-b72d-4414-b0d5-732f5818f15f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '821708de-cd60-4ba2-9df3-f054939dba66', 'IRN', '418041947', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '418041947'
			and pid.personid = '821708de-cd60-4ba2-9df3-f054939dba66');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e11ea55e-5f2d-404a-b0ff-f51f2d094e42', 'IRN', '552071997', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '552071997'
			and pid.personid = 'e11ea55e-5f2d-404a-b0ff-f51f2d094e42');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '740eac55-3a11-4fbb-924d-921526cb6c54', 'IRN', '502065788', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '502065788'
			and pid.personid = '740eac55-3a11-4fbb-924d-921526cb6c54');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '891ba1f7-2f7d-4572-bc30-3b64f2003240', 'IRN', '545071036', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '545071036'
			and pid.personid = '891ba1f7-2f7d-4572-bc30-3b64f2003240');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9dc25426-2752-4643-a795-59ead8e90a6f', 'IRN', '540071695', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '540071695'
			and pid.personid = '9dc25426-2752-4643-a795-59ead8e90a6f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f0c364e1-eb92-437c-8f61-139a85bdb95d', 'IRN', '560071824', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '560071824'
			and pid.personid = 'f0c364e1-eb92-437c-8f61-139a85bdb95d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c88953b7-7366-485d-822f-ce78f7c0d8ce', 'IRN', '567071853', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '567071853'
			and pid.personid = 'c88953b7-7366-485d-822f-ce78f7c0d8ce');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c22997e9-4290-4a5e-9975-84ceed42e67a', 'IRN', '589072150', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '589072150'
			and pid.personid = 'c22997e9-4290-4a5e-9975-84ceed42e67a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '889c4e5e-72cc-4672-925a-302464a22a6d', 'IRN', '562071872', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '562071872'
			and pid.personid = '889c4e5e-72cc-4672-925a-302464a22a6d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5c5fdd53-9e20-4416-adb5-06dde136ffb8', 'IRN', '562071873', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '562071873'
			and pid.personid = '5c5fdd53-9e20-4416-adb5-06dde136ffb8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b5dd8885-e948-45aa-ade7-458e1cb8bd3d', 'IRN', '551072375', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '551072375'
			and pid.personid = 'b5dd8885-e948-45aa-ade7-458e1cb8bd3d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '22b7b2f6-efdd-4b35-b5e8-581845148f78', 'IRN', '594072207', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '594072207'
			and pid.personid = '22b7b2f6-efdd-4b35-b5e8-581845148f78');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8f30e09a-0a4a-4aeb-86c0-33638567ea61', 'IRN', '500886699', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '500886699'
			and pid.personid = '8f30e09a-0a4a-4aeb-86c0-33638567ea61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7c51896f-295c-4bc4-8848-bc7359c2ce93', 'IRN', '544071364', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '544071364'
			and pid.personid = '7c51896f-295c-4bc4-8848-bc7359c2ce93');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cbb3288d-829b-44b9-868d-0f1ef90c4414', 'IRN', '561071772', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '561071772'
			and pid.personid = 'cbb3288d-829b-44b9-868d-0f1ef90c4414');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a8ebe558-5795-4be4-b4ca-3c084bf157aa', 'IRN', '553072818', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '553072818'
			and pid.personid = 'a8ebe558-5795-4be4-b4ca-3c084bf157aa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'de89520c-11ca-47f5-b95c-f3c8b0ec2bb5', 'IRN', '517071599', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '517071599'
			and pid.personid = 'de89520c-11ca-47f5-b95c-f3c8b0ec2bb5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd2f32c29-62dd-43d6-aa16-3421d46fb7f8', 'IRN', '538071931', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '538071931'
			and pid.personid = 'd2f32c29-62dd-43d6-aa16-3421d46fb7f8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '45350145-f1ca-498a-81f8-1bb773031bb2', 'IRN', '552071996', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '552071996'
			and pid.personid = '45350145-f1ca-498a-81f8-1bb773031bb2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cc8767df-708b-439c-9c3f-9932c6167226', 'IRN', '541071409', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '541071409'
			and pid.personid = 'cc8767df-708b-439c-9c3f-9932c6167226');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '760f940f-46eb-441d-998b-92d4b2bbb7a2', 'IRN', '578071888', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '578071888'
			and pid.personid = '760f940f-46eb-441d-998b-92d4b2bbb7a2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e45ed80a-a669-445f-81d7-ada9231a1185', 'IRN', '543071800', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '543071800'
			and pid.personid = 'e45ed80a-a669-445f-81d7-ada9231a1185');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '967dc65e-5757-453a-9d38-04267f2bfe21', 'IRN', '568071062', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '568071062'
			and pid.personid = '967dc65e-5757-453a-9d38-04267f2bfe21');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '804c11c0-8c6d-418e-9a20-e9df865856ec', 'IRN', '585071823', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '585071823'
			and pid.personid = '804c11c0-8c6d-418e-9a20-e9df865856ec');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e33099fd-3c55-425e-8b22-be61647de7ad', 'IRN', '504072788', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '504072788'
			and pid.personid = 'e33099fd-3c55-425e-8b22-be61647de7ad');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ab4e9ffa-6e08-446a-b011-e40723e7155e', 'IRN', '597072189', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '597072189'
			and pid.personid = 'ab4e9ffa-6e08-446a-b011-e40723e7155e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '55de933d-0443-4d96-aeed-7c4e1372a8d5', 'IRN', '586071115', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '586071115'
			and pid.personid = '55de933d-0443-4d96-aeed-7c4e1372a8d5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '312dfe25-7e1f-4c5a-b3df-d9748d14d768', 'IRN', '546071742', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '546071742'
			and pid.personid = '312dfe25-7e1f-4c5a-b3df-d9748d14d768');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fd2f1289-e254-4e3e-aab8-828f539a3f76', 'IRN', '558071899', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '558071899'
			and pid.personid = 'fd2f1289-e254-4e3e-aab8-828f539a3f76');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0dfbeee9-4c13-4aca-8fb5-234f60575e38', 'IRN', '452020145', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '452020145'
			and pid.personid = '0dfbeee9-4c13-4aca-8fb5-234f60575e38');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6fa665b4-3620-413b-bb0f-c7d3616f335e', 'IRN', '524071893', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '524071893'
			and pid.personid = '6fa665b4-3620-413b-bb0f-c7d3616f335e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6fd762c4-a246-4edf-9323-4558f9a8127e', 'IRN', '490010026', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '490010026'
			and pid.personid = '6fd762c4-a246-4edf-9323-4558f9a8127e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7e55eadb-c33b-43fa-9fe3-0565860e972d', 'IRN', '508071845', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071845'
			and pid.personid = '7e55eadb-c33b-43fa-9fe3-0565860e972d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '08549b61-cf6e-4b70-9502-79a5acc70a67', 'IRN', '513072453', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '513072453'
			and pid.personid = '08549b61-cf6e-4b70-9502-79a5acc70a67');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9d127334-f5ce-4e24-b8be-27592ed47508', 'IRN', '590071469', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '590071469'
			and pid.personid = '9d127334-f5ce-4e24-b8be-27592ed47508');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bf33e1f8-e2b5-43bb-8c13-366b68645bd7', 'IRN', '506072086', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '506072086'
			and pid.personid = 'bf33e1f8-e2b5-43bb-8c13-366b68645bd7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ed993b30-7cc0-498c-a27f-0936fd0a2fa1', 'IRN', '598071326', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '598071326'
			and pid.personid = 'ed993b30-7cc0-498c-a27f-0936fd0a2fa1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7117ceeb-d001-4c1b-8879-6a15621df1f3', 'IRN', '564071808', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '564071808'
			and pid.personid = '7117ceeb-d001-4c1b-8879-6a15621df1f3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e2097060-6c67-491f-8796-3226152103db', 'IRN', '553072816', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '553072816'
			and pid.personid = 'e2097060-6c67-491f-8796-3226152103db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '71019ef3-bb44-4fbe-96d3-a9606b611d5c', 'IRN', '541071408', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '541071408'
			and pid.personid = '71019ef3-bb44-4fbe-96d3-a9606b611d5c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6c1a2471-2cb7-4a47-8078-32ec3a445d78', 'IRN', '509067147', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '509067147'
			and pid.personid = '6c1a2471-2cb7-4a47-8078-32ec3a445d78');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8d87b426-28b5-4941-82c1-3dac6d3ea8dd', 'IRN', '593072375', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '593072375'
			and pid.personid = '8d87b426-28b5-4941-82c1-3dac6d3ea8dd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'dcee5803-55ba-4f48-bf24-a30c9566b0f9', 'IRN', '554072144', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '554072144'
			and pid.personid = 'dcee5803-55ba-4f48-bf24-a30c9566b0f9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e781e98a-7498-4083-8544-c01664457b64', 'IRN', '555070777', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '555070777'
			and pid.personid = 'e781e98a-7498-4083-8544-c01664457b64');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6da9e6ae-243e-45ad-be04-684b3c2c28cf', 'IRN', '538071929', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '538071929'
			and pid.personid = '6da9e6ae-243e-45ad-be04-684b3c2c28cf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '43cc5094-ec57-44ac-bc17-9a8762679403', 'IRN', '555071795', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '555071795'
			and pid.personid = '43cc5094-ec57-44ac-bc17-9a8762679403');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '32898610-9f90-4869-a69d-cc5bc7a1611a', 'IRN', '586071114', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '586071114'
			and pid.personid = '32898610-9f90-4869-a69d-cc5bc7a1611a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7965945b-531f-4178-922b-823341711b3f', 'IRN', '501071235', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '501071235'
			and pid.personid = '7965945b-531f-4178-922b-823341711b3f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '878bfa3f-6d17-436e-8ec1-0711ac1e43a5', 'IRN', '511071724', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '511071724'
			and pid.personid = '878bfa3f-6d17-436e-8ec1-0711ac1e43a5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '40af0e94-7e4f-42ae-8b28-2b250037076e', 'IRN', '532072199', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '532072199'
			and pid.personid = '40af0e94-7e4f-42ae-8b28-2b250037076e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0f67c0ff-d57e-4ade-8b49-74c4a697137a', 'IRN', '501071234', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '501071234'
			and pid.personid = '0f67c0ff-d57e-4ade-8b49-74c4a697137a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1821c4ea-aa9b-411a-ba13-c48574df3ebf', 'IRN', '547071314', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '547071314'
			and pid.personid = '1821c4ea-aa9b-411a-ba13-c48574df3ebf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '63f3ba38-8535-4783-a6be-09757eb57216', 'IRN', '547071313', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '547071313'
			and pid.personid = '63f3ba38-8535-4783-a6be-09757eb57216');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c2f5ed59-7246-4e90-8f07-ea7ae55eb2a7', 'IRN', '547071311', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '547071311'
			and pid.personid = 'c2f5ed59-7246-4e90-8f07-ea7ae55eb2a7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba6ab7b5-9151-496f-9a6e-0fc03ab4ffcb', 'IRN', '547071312', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '547071312'
			and pid.personid = 'ba6ab7b5-9151-496f-9a6e-0fc03ab4ffcb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '066fe01f-fb47-4699-a443-0f9c7acc59f4', 'IRN', '508071844', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071844'
			and pid.personid = '066fe01f-fb47-4699-a443-0f9c7acc59f4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2c1214a9-8312-4411-b710-2982b1bd0bc2', 'IRN', '445049432', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '445049432'
			and pid.personid = '2c1214a9-8312-4411-b710-2982b1bd0bc2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1f9f2440-c86c-4768-8273-73d03c5618fa', 'IRN', '446008818', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '446008818'
			and pid.personid = '1f9f2440-c86c-4768-8273-73d03c5618fa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '77b3f3a1-eb69-4eed-8ae7-b63e956ae99c', 'IRN', '515071778', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '515071778'
			and pid.personid = '77b3f3a1-eb69-4eed-8ae7-b63e956ae99c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ee99b8cd-2551-45d6-8e9d-2b61911ccadd', 'IRN', '506072085', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '506072085'
			and pid.personid = 'ee99b8cd-2551-45d6-8e9d-2b61911ccadd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba3cd77d-59b4-45fd-ae03-abe12f722e40', 'IRN', '598071324', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '598071324'
			and pid.personid = 'ba3cd77d-59b4-45fd-ae03-abe12f722e40');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b0e12704-0bf1-4d76-9920-c7617d1c1c7b', 'IRN', '509071781', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '509071781'
			and pid.personid = 'b0e12704-0bf1-4d76-9920-c7617d1c1c7b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ac989c50-4a16-416c-9248-8d62b7cd6aa3', 'IRN', '524071892', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '524071892'
			and pid.personid = 'ac989c50-4a16-416c-9248-8d62b7cd6aa3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0c268ff2-9b91-467e-92b4-6a99a99ed1f6', 'IRN', '503075815', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '503075815'
			and pid.personid = '0c268ff2-9b91-467e-92b4-6a99a99ed1f6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '148a0856-8758-4bba-b90e-673b0ba09a9e', 'IRN', '598071323', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '598071323'
			and pid.personid = '148a0856-8758-4bba-b90e-673b0ba09a9e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1366adb9-0328-4fd0-bc8e-30c554fa09c6', 'IRN', '570072039', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '570072039'
			and pid.personid = '1366adb9-0328-4fd0-bc8e-30c554fa09c6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef2e31fe-a2e2-4be0-a8a1-927ca09ed95d', 'IRN', '581071999', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '581071999'
			and pid.personid = 'ef2e31fe-a2e2-4be0-a8a1-927ca09ed95d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3aecb37e-00b6-4670-ac76-5ac7819f75cb', 'IRN', '539072437', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '539072437'
			and pid.personid = '3aecb37e-00b6-4670-ac76-5ac7819f75cb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '13e9ee04-cfdb-4710-918b-e48ce37f7f68', 'IRN', '551072376', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '551072376'
			and pid.personid = '13e9ee04-cfdb-4710-918b-e48ce37f7f68');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '10f8543f-93ca-4900-a1ac-3f340e7bca07', 'IRN', '554072143', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '554072143'
			and pid.personid = '10f8543f-93ca-4900-a1ac-3f340e7bca07');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '856b630a-7b0f-46e3-871f-291b86249439', 'IRN', '514071713', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '514071713'
			and pid.personid = '856b630a-7b0f-46e3-871f-291b86249439');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ac5ea611-67ea-4d56-b94b-30a61c9c8da5', 'IRN', '509071780', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '509071780'
			and pid.personid = 'ac5ea611-67ea-4d56-b94b-30a61c9c8da5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0a8077b6-594e-494c-be28-74f76809452f', 'IRN', '557073001', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '557073001'
			and pid.personid = '0a8077b6-594e-494c-be28-74f76809452f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '93ec61c7-1ba0-4658-9dde-3c9f90522a3d', 'IRN', '539072436', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '539072436'
			and pid.personid = '93ec61c7-1ba0-4658-9dde-3c9f90522a3d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7a1d7140-6b28-49d8-8312-a6d978592c28', 'IRN', '555071794', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '555071794'
			and pid.personid = '7a1d7140-6b28-49d8-8312-a6d978592c28');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '657b96d8-d12f-4356-9a5b-3d02b50c4b1b', 'IRN', '553072817', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '553072817'
			and pid.personid = '657b96d8-d12f-4356-9a5b-3d02b50c4b1b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c917efac-1d2d-421c-a024-ffc1aa0fcee5', 'IRN', '545071035', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '545071035'
			and pid.personid = 'c917efac-1d2d-421c-a024-ffc1aa0fcee5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f3198755-30d8-4dc9-b00e-17338c3b0088', 'IRN', '523072178', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '523072178'
			and pid.personid = 'f3198755-30d8-4dc9-b00e-17338c3b0088');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '90915840-fcc1-47f8-8d6d-cc498127188b', 'IRN', '575072477', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '575072477'
			and pid.personid = '90915840-fcc1-47f8-8d6d-cc498127188b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd50e9f85-cfb3-4e48-a7a7-c3b5961f98df', 'IRN', '519071876', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '519071876'
			and pid.personid = 'd50e9f85-cfb3-4e48-a7a7-c3b5961f98df');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b71be5a8-cba1-4f85-86f8-d0c3761912d0', 'IRN', '542072242', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '542072242'
			and pid.personid = 'b71be5a8-cba1-4f85-86f8-d0c3761912d0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '83bafe62-84cb-4762-8b46-3a73c0a96df0', 'IRN', '512071967', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '512071967'
			and pid.personid = '83bafe62-84cb-4762-8b46-3a73c0a96df0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e2fb2618-8a86-49ab-914d-2dfb9be6d687', 'IRN', '512071968', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '512071968'
			and pid.personid = 'e2fb2618-8a86-49ab-914d-2dfb9be6d687');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '266338e4-422c-4b42-b8b6-f8fa054aeaf3', 'IRN', '547071310', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '547071310'
			and pid.personid = '266338e4-422c-4b42-b8b6-f8fa054aeaf3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2ad3b507-d4f3-4846-902f-c6ba06ee11a0', 'IRN', '536072050', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '536072050'
			and pid.personid = '2ad3b507-d4f3-4846-902f-c6ba06ee11a0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fd10c3b0-7d38-4666-9a8f-3ad5e37bf86b', 'IRN', '512071966', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '512071966'
			and pid.personid = 'fd10c3b0-7d38-4666-9a8f-3ad5e37bf86b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '86363bc8-9383-4e4c-bb5d-170d7d57b360', 'IRN', '525072919', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '525072919'
			and pid.personid = '86363bc8-9383-4e4c-bb5d-170d7d57b360');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '83526639-5887-4520-9967-d3ee4f970253', 'IRN', '541071405', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '541071405'
			and pid.personid = '83526639-5887-4520-9967-d3ee4f970253');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '00b1cd83-b51d-4213-a5b8-48a9895d8d78', 'IRN', '536072052', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '536072052'
			and pid.personid = '00b1cd83-b51d-4213-a5b8-48a9895d8d78');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '16038b6c-6e7c-416c-b441-d434f2b52645', 'IRN', '553072815', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '553072815'
			and pid.personid = '16038b6c-6e7c-416c-b441-d434f2b52645');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '89e5a69f-568f-48bd-a151-3ffc4cfd702b', 'IRN', '527071976', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '527071976'
			and pid.personid = '89e5a69f-568f-48bd-a151-3ffc4cfd702b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f85225c2-aa55-4e11-8523-d0b7ffceb39c', 'IRN', '449010202', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '449010202'
			and pid.personid = 'f85225c2-aa55-4e11-8523-d0b7ffceb39c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9381547c-4848-48f0-b865-756a84fcb21d', 'IRN', '585071822', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '585071822'
			and pid.personid = '9381547c-4848-48f0-b865-756a84fcb21d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bb0301e0-6ba1-4f30-9bc7-4dfb77892b94', 'IRN', '574072114', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '574072114'
			and pid.personid = 'bb0301e0-6ba1-4f30-9bc7-4dfb77892b94');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '68e75178-7e95-4c3e-a7a5-b741f8df4679', 'IRN', '476049469', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '476049469'
			and pid.personid = '68e75178-7e95-4c3e-a7a5-b741f8df4679');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '052a83d4-3483-40a3-9ec8-d250e936a6e7', 'IRN', '528071666', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '528071666'
			and pid.personid = '052a83d4-3483-40a3-9ec8-d250e936a6e7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '85cbc042-7a23-49a3-a024-fee06910b790', 'IRN', '588071303', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '588071303'
			and pid.personid = '85cbc042-7a23-49a3-a024-fee06910b790');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2d36a8b9-2876-43a3-898e-1cbbdc7fe58c', 'IRN', '518072291', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '518072291'
			and pid.personid = '2d36a8b9-2876-43a3-898e-1cbbdc7fe58c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef6e7522-1ed9-44cc-9dd5-5f9641c56792', 'IRN', '572071524', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '572071524'
			and pid.personid = 'ef6e7522-1ed9-44cc-9dd5-5f9641c56792');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e0f5ec2e-52ef-4ab0-9459-407521d7be38', 'IRN', '576071537', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '576071537'
			and pid.personid = 'e0f5ec2e-52ef-4ab0-9459-407521d7be38');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '51ae9e00-7130-4368-bf5c-8221914fd447', 'IRN', '534071888', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '534071888'
			and pid.personid = '51ae9e00-7130-4368-bf5c-8221914fd447');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'afbc405d-b1ca-4737-bd5d-365c1d1ec645', 'IRN', '583071621', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '583071621'
			and pid.personid = 'afbc405d-b1ca-4737-bd5d-365c1d1ec645');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0a685224-1737-49d9-81c8-d08009d37b8e', 'IRN', '506072084', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '506072084'
			and pid.personid = '0a685224-1737-49d9-81c8-d08009d37b8e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4c69b0dc-4812-467e-879e-c2a18c637eea', 'IRN', '588071302', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '588071302'
			and pid.personid = '4c69b0dc-4812-467e-879e-c2a18c637eea');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a1577e5f-0486-481f-957f-9ee554507a1d', 'IRN', '545071034', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '545071034'
			and pid.personid = 'a1577e5f-0486-481f-957f-9ee554507a1d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'dc16f8cd-bdf6-45f3-809e-83d90f9a8279', 'IRN', '541071407', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '541071407'
			and pid.personid = 'dc16f8cd-bdf6-45f3-809e-83d90f9a8279');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '25ff6242-a07e-4cf6-9dce-08d2a1f15693', 'IRN', '536072051', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '536072051'
			and pid.personid = '25ff6242-a07e-4cf6-9dce-08d2a1f15693');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7be6a600-387e-4cf9-b8e9-330871126c95', 'IRN', '551072373', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '551072373'
			and pid.personid = '7be6a600-387e-4cf9-b8e9-330871126c95');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5556bd79-2845-42e4-b5ac-804a889b4cf1', 'IRN', '521071468', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '521071468'
			and pid.personid = '5556bd79-2845-42e4-b5ac-804a889b4cf1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '02021a78-3cba-435e-ad08-d52c77f0dc95', 'IRN', '587071795', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '587071795'
			and pid.personid = '02021a78-3cba-435e-ad08-d52c77f0dc95');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a39cd26d-2d1e-4c21-a783-8639c7e7c34a', 'IRN', '515071777', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '515071777'
			and pid.personid = 'a39cd26d-2d1e-4c21-a783-8639c7e7c34a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bc68bc04-5a52-4097-884e-1fcb1dc08ace', 'IRN', '554072141', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '554072141'
			and pid.personid = 'bc68bc04-5a52-4097-884e-1fcb1dc08ace');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0c01d70d-b5d3-4ff2-bd94-dda02756ad7f', 'IRN', '564071807', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '564071807'
			and pid.personid = '0c01d70d-b5d3-4ff2-bd94-dda02756ad7f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '22df1714-7d7b-4353-a9f2-87966d27cd6e', 'IRN', '555071792', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '555071792'
			and pid.personid = '22df1714-7d7b-4353-a9f2-87966d27cd6e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6b12b030-9851-4ca3-984e-f18809975fc9', 'IRN', '564071806', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '564071806'
			and pid.personid = '6b12b030-9851-4ca3-984e-f18809975fc9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '849292ad-1cad-4b65-a062-f0aaea1bba50', 'IRN', '584072112', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '584072112'
			and pid.personid = '849292ad-1cad-4b65-a062-f0aaea1bba50');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ee10ba0b-ca89-4b09-a011-7c8793d7d395', 'IRN', '548070394', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '548070394'
			and pid.personid = 'ee10ba0b-ca89-4b09-a011-7c8793d7d395');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fcc9911b-27cd-44a0-ad4a-a890ced1dbbc', 'IRN', '508071843', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071843'
			and pid.personid = 'fcc9911b-27cd-44a0-ad4a-a890ced1dbbc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8558da89-075f-4e83-85a4-e1e4a69ffc9d', 'IRN', '562071871', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '562071871'
			and pid.personid = '8558da89-075f-4e83-85a4-e1e4a69ffc9d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '28af24da-5208-40cd-839a-c75549ab71c1', 'IRN', '540071694', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '540071694'
			and pid.personid = '28af24da-5208-40cd-839a-c75549ab71c1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fdac46cb-4b36-4d59-95cb-c067274438ef', 'IRN', '589072149', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '589072149'
			and pid.personid = 'fdac46cb-4b36-4d59-95cb-c067274438ef');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '12ebdc3f-77bb-483b-93d0-25d48076be59', 'IRN', '592071557', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '592071557'
			and pid.personid = '12ebdc3f-77bb-483b-93d0-25d48076be59');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6eeaa51d-73d1-4ae7-a32f-46e87ce7806c', 'IRN', '550073077', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '550073077'
			and pid.personid = '6eeaa51d-73d1-4ae7-a32f-46e87ce7806c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '143abefe-01ca-4277-b0b1-de4a494765b6', 'IRN', '499016917', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '499016917'
			and pid.personid = '143abefe-01ca-4277-b0b1-de4a494765b6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba16efa6-bcba-40d5-b490-0da295756ba6', 'IRN', '588071301', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '588071301'
			and pid.personid = 'ba16efa6-bcba-40d5-b490-0da295756ba6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '25f6dd19-e7b2-451a-a307-4fea7afbd0a0', 'IRN', '498020316', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '498020316'
			and pid.personid = '25f6dd19-e7b2-451a-a307-4fea7afbd0a0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0f273db1-d86f-4a5c-a57e-29a8b0c7b735', 'IRN', '599072077', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '599072077'
			and pid.personid = '0f273db1-d86f-4a5c-a57e-29a8b0c7b735');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'dd252436-d538-437d-943a-5c4ac33df4cc', 'IRN', '572071521', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '572071521'
			and pid.personid = 'dd252436-d538-437d-943a-5c4ac33df4cc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f4287a9e-cf37-4e93-9ab3-ba347fc05822', 'IRN', '570072038', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '570072038'
			and pid.personid = 'f4287a9e-cf37-4e93-9ab3-ba347fc05822');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c5408454-d559-4efa-9394-4b832d3cafbc', 'IRN', '545071032', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '545071032'
			and pid.personid = 'c5408454-d559-4efa-9394-4b832d3cafbc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3efcafcd-74ce-4bac-9bc7-7d04ae00ddc9', 'IRN', '556072196', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '556072196'
			and pid.personid = '3efcafcd-74ce-4bac-9bc7-7d04ae00ddc9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4f6ee167-96a8-4c72-a935-814afdcb163a', 'IRN', '516071383', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '516071383'
			and pid.personid = '4f6ee167-96a8-4c72-a935-814afdcb163a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9ad1f6f8-5443-428a-a94d-84bb1809e6c3', 'IRN', '507071823', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '507071823'
			and pid.personid = '9ad1f6f8-5443-428a-a94d-84bb1809e6c3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3291bc29-14e2-4573-92f9-5b0c82a3881c', 'IRN', '496009001', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '496009001'
			and pid.personid = '3291bc29-14e2-4573-92f9-5b0c82a3881c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef2230b3-8760-48da-8c66-f5c021f8a61c', 'IRN', '529071051', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '529071051'
			and pid.personid = 'ef2230b3-8760-48da-8c66-f5c021f8a61c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '36ca8a01-85ad-4335-a7fd-29c586a99616', 'IRN', '516071382', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '516071382'
			and pid.personid = '36ca8a01-85ad-4335-a7fd-29c586a99616');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'be358f06-fddd-4fd3-93d2-2e5691424908', 'IRN', '555071793', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '555071793'
			and pid.personid = 'be358f06-fddd-4fd3-93d2-2e5691424908');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f319e671-394c-4ca4-833d-b11c0f53c446', 'IRN', '535071324', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '535071324'
			and pid.personid = 'f319e671-394c-4ca4-833d-b11c0f53c446');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8ce394eb-279b-44a5-83c1-7863e42f887f', 'IRN', '582071490', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '582071490'
			and pid.personid = '8ce394eb-279b-44a5-83c1-7863e42f887f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e8b520d3-dcc4-49ac-84d8-b6a0ada8c7fc', 'IRN', '539072435', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '539072435'
			and pid.personid = 'e8b520d3-dcc4-49ac-84d8-b6a0ada8c7fc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8d0b42b6-e504-4798-a118-c72d67898ad8', 'IRN', '533070975', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '533070975'
			and pid.personid = '8d0b42b6-e504-4798-a118-c72d67898ad8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5648e839-61d3-41a7-a75e-e4bec24cf4ba', 'IRN', '592071556', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '592071556'
			and pid.personid = '5648e839-61d3-41a7-a75e-e4bec24cf4ba');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '77796500-270c-4b7f-bdae-6ffeb95a1ac2', 'IRN', '509071779', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '509071779'
			and pid.personid = '77796500-270c-4b7f-bdae-6ffeb95a1ac2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '12f61bcb-a7d2-4769-9737-d0920cc229d4', 'IRN', '593072374', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '593072374'
			and pid.personid = '12f61bcb-a7d2-4769-9737-d0920cc229d4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c067c417-74c4-4b0c-8892-9688a0fbe3d8', 'IRN', '587071796', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '587071796'
			and pid.personid = 'c067c417-74c4-4b0c-8892-9688a0fbe3d8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '743af9b6-7660-4303-931e-b5ce8d8e6430', 'IRN', '529071050', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '529071050'
			and pid.personid = '743af9b6-7660-4303-931e-b5ce8d8e6430');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ea88856a-75dc-481d-800e-75d522e99b97', 'IRN', '559072323', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '559072323'
			and pid.personid = 'ea88856a-75dc-481d-800e-75d522e99b97');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '42f203b0-f3a6-49b8-b344-0b6f263ae284', 'IRN', '551072372', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '551072372'
			and pid.personid = '42f203b0-f3a6-49b8-b344-0b6f263ae284');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9313d5e6-19db-4be9-aed1-fd5ce83a729f', 'IRN', '545071033', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '545071033'
			and pid.personid = '9313d5e6-19db-4be9-aed1-fd5ce83a729f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3eea097b-a3a8-4243-b2bf-2d2225208638', 'IRN', '516071381', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '516071381'
			and pid.personid = '3eea097b-a3a8-4243-b2bf-2d2225208638');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4b822c8e-bf69-45e5-b37f-5e9754e31d44', 'IRN', '572071523', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '572071523'
			and pid.personid = '4b822c8e-bf69-45e5-b37f-5e9754e31d44');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4cafbb49-84dd-4f1d-81a7-e1b01d0ef855', 'IRN', '549070831', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '549070831'
			and pid.personid = '4cafbb49-84dd-4f1d-81a7-e1b01d0ef855');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9adee1b9-c489-4972-8f89-bc36cc7aa314', 'IRN', '505071161', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '505071161'
			and pid.personid = '9adee1b9-c489-4972-8f89-bc36cc7aa314');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '342e3212-42d2-46c6-9ec1-1842c5a539a0', 'IRN', '541071406', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '541071406'
			and pid.personid = '342e3212-42d2-46c6-9ec1-1842c5a539a0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'caebd0ed-c265-4333-b878-b129621db3df', 'IRN', '453045916', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '453045916'
			and pid.personid = 'caebd0ed-c265-4333-b878-b129621db3df');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7dc56987-5872-48a7-97f8-1f59bf4322a0', 'IRN', '548071095', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '548071095'
			and pid.personid = '7dc56987-5872-48a7-97f8-1f59bf4322a0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3ebce46a-2495-4268-8fd6-b1c0b59b8b0b', 'IRN', '489022560', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '489022560'
			and pid.personid = '3ebce46a-2495-4268-8fd6-b1c0b59b8b0b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3ef144ce-271c-4c78-9cdb-7d929de20e11', 'IRN', '512071965', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '512071965'
			and pid.personid = '3ef144ce-271c-4c78-9cdb-7d929de20e11');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd6b3c6c2-d09b-4139-9581-0f0387d93220', 'IRN', '556072195', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '556072195'
			and pid.personid = 'd6b3c6c2-d09b-4139-9581-0f0387d93220');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b8b3c0e2-d1a4-425b-998c-3ee645356ad8', 'IRN', '537071486', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '537071486'
			and pid.personid = 'b8b3c0e2-d1a4-425b-998c-3ee645356ad8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2a9672aa-91f9-4d63-9d94-0b424fbc5030', 'IRN', '522071624', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '522071624'
			and pid.personid = '2a9672aa-91f9-4d63-9d94-0b424fbc5030');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4d26726f-cf15-41d2-876a-d45787adc33d', 'IRN', '561071770', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '561071770'
			and pid.personid = '4d26726f-cf15-41d2-876a-d45787adc33d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ddceaaa6-7a1e-4a3a-b966-384725ebe898', 'IRN', '523072177', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '523072177'
			and pid.personid = 'ddceaaa6-7a1e-4a3a-b966-384725ebe898');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bb77873e-d25a-4066-a711-41c3579f3277', 'IRN', '594072206', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '594072206'
			and pid.personid = 'bb77873e-d25a-4066-a711-41c3579f3277');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba22787d-ef65-4c7f-8803-83808e2c04c3', 'IRN', '549070830', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '549070830'
			and pid.personid = 'ba22787d-ef65-4c7f-8803-83808e2c04c3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1fcb2dfa-9603-4e5b-8ab8-61dfecf7a556', 'IRN', '529071049', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '529071049'
			and pid.personid = '1fcb2dfa-9603-4e5b-8ab8-61dfecf7a556');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '001caaa6-f804-4c3d-a7ac-d1a5c0008af3', 'IRN', '556072194', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '556072194'
			and pid.personid = '001caaa6-f804-4c3d-a7ac-d1a5c0008af3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '84da6ee7-4f22-4f59-a463-61b50d44f452', 'IRN', '577072067', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '577072067'
			and pid.personid = '84da6ee7-4f22-4f59-a463-61b50d44f452');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9fbaa073-f457-4aeb-8289-d2ee82ae5d70', 'IRN', '576071538', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '576071538'
			and pid.personid = '9fbaa073-f457-4aeb-8289-d2ee82ae5d70');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c164f2ae-b1c0-4414-96a4-d51d9a53313b', 'IRN', '546071741', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '546071741'
			and pid.personid = 'c164f2ae-b1c0-4414-96a4-d51d9a53313b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'aa5a1d02-868e-4250-9d91-73155b3d8fee', 'IRN', '586071113', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '586071113'
			and pid.personid = 'aa5a1d02-868e-4250-9d91-73155b3d8fee');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f6a23b58-3404-49fe-a304-988ec7a87000', 'IRN', '506072083', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '506072083'
			and pid.personid = 'f6a23b58-3404-49fe-a304-988ec7a87000');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2c1853fd-5f82-4064-8afb-caef8e529151', 'IRN', '432018706', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '432018706'
			and pid.personid = '2c1853fd-5f82-4064-8afb-caef8e529151');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '931ba8e4-106d-4335-995c-cde35d66b48a', 'IRN', '575072476', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '575072476'
			and pid.personid = '931ba8e4-106d-4335-995c-cde35d66b48a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '685cdf80-7e27-46b9-a3b8-29f6791a36f7', 'IRN', '510071544', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '510071544'
			and pid.personid = '685cdf80-7e27-46b9-a3b8-29f6791a36f7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3626427f-1e57-4d7a-adf7-f46e509df5ac', 'IRN', '588071300', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '588071300'
			and pid.personid = '3626427f-1e57-4d7a-adf7-f46e509df5ac');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'df9af9f6-94fc-4389-8209-2730dad37146', 'IRN', '526071085', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '526071085'
			and pid.personid = 'df9af9f6-94fc-4389-8209-2730dad37146');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'de01a3a9-3c1e-4c1c-a1e4-e35ad3d685c8', 'IRN', '400320837', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '400320837'
			and pid.personid = 'de01a3a9-3c1e-4c1c-a1e4-e35ad3d685c8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c147e016-4fba-4e67-b84f-82083c2fa4aa', 'IRN', '553072814', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '553072814'
			and pid.personid = 'c147e016-4fba-4e67-b84f-82083c2fa4aa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '11c500b7-3a49-41d1-a6cc-85913ccce518', 'IRN', '525072918', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '525072918'
			and pid.personid = '11c500b7-3a49-41d1-a6cc-85913ccce518');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'eb7e606f-5b2b-498e-9b66-f0d5e866bf8e', 'IRN', '527071974', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '527071974'
			and pid.personid = 'eb7e606f-5b2b-498e-9b66-f0d5e866bf8e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e4ef0a93-f988-47dd-ac91-3a61b5e1457d', 'IRN', '585071821', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '585071821'
			and pid.personid = 'e4ef0a93-f988-47dd-ac91-3a61b5e1457d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f32fb6c1-2a7d-4793-bf9f-89740638445f', 'IRN', '583067116', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '583067116'
			and pid.personid = 'f32fb6c1-2a7d-4793-bf9f-89740638445f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '97a29e77-669c-43fb-b151-4173a80880e6', 'IRN', '523072176', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '523072176'
			and pid.personid = '97a29e77-669c-43fb-b151-4173a80880e6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd2bffd69-fe7b-42c8-bf72-5f7fd0ffc13c', 'IRN', '577072066', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '577072066'
			and pid.personid = 'd2bffd69-fe7b-42c8-bf72-5f7fd0ffc13c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9933be42-7d5b-4c03-8cfa-a3607c2337f9', 'IRN', '514071712', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '514071712'
			and pid.personid = '9933be42-7d5b-4c03-8cfa-a3607c2337f9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '33530c54-fdff-4633-bf43-c2b70b2d619b', 'IRN', '566071823', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '566071823'
			and pid.personid = '33530c54-fdff-4633-bf43-c2b70b2d619b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '268e1fec-850b-4493-94f1-b79f48087c44', 'IRN', '572071522', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '572071522'
			and pid.personid = '268e1fec-850b-4493-94f1-b79f48087c44');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0a8c5c85-b6ab-403d-bfe0-3f15cc843b65', 'IRN', '584072111', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '584072111'
			and pid.personid = '0a8c5c85-b6ab-403d-bfe0-3f15cc843b65');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3fc7d8d4-681f-4809-8e5c-33dbcc3c3b42', 'IRN', '442031800', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '442031800'
			and pid.personid = '3fc7d8d4-681f-4809-8e5c-33dbcc3c3b42');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c18192fd-1d16-464c-ac5c-019864493abd', 'IRN', '543071799', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '543071799'
			and pid.personid = 'c18192fd-1d16-464c-ac5c-019864493abd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f44e28bc-a3ad-469f-9024-296947c866da', 'IRN', '514071711', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '514071711'
			and pid.personid = 'f44e28bc-a3ad-469f-9024-296947c866da');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c3ca103b-635c-447b-abe4-db10d16b403e', 'IRN', '590071468', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '590071468'
			and pid.personid = 'c3ca103b-635c-447b-abe4-db10d16b403e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '96005552-031b-402f-916a-4812d93cb924', 'IRN', '531071769', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '531071769'
			and pid.personid = '96005552-031b-402f-916a-4812d93cb924');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'edc0c5f3-8f5e-4c05-8588-c0cfe1180ffe', 'IRN', '569072352', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '569072352'
			and pid.personid = 'edc0c5f3-8f5e-4c05-8588-c0cfe1180ffe');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9dcbdcf7-3ae3-40cc-80e5-70dc0a1ffa93', 'IRN', '576071536', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '576071536'
			and pid.personid = '9dcbdcf7-3ae3-40cc-80e5-70dc0a1ffa93');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f2aedaea-f4bf-46f9-9c31-d28ebf44950b', 'IRN', '569072351', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '569072351'
			and pid.personid = 'f2aedaea-f4bf-46f9-9c31-d28ebf44950b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a7c53b0b-7103-4449-a04a-b7538c66314a', 'IRN', '591071190', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '591071190'
			and pid.personid = 'a7c53b0b-7103-4449-a04a-b7538c66314a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '312df99b-736f-4d22-8db1-50c21690580a', 'IRN', '582071489', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '582071489'
			and pid.personid = '312df99b-736f-4d22-8db1-50c21690580a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '62775efe-0163-44e3-88ae-a03a11420d26', 'IRN', '485010856', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '485010856'
			and pid.personid = '62775efe-0163-44e3-88ae-a03a11420d26');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '95da2800-7c36-410c-b66d-82376676c4da', 'IRN', '535071323', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '535071323'
			and pid.personid = '95da2800-7c36-410c-b66d-82376676c4da');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a75b7fc3-0abf-4f6c-91eb-31eb76c00a6e', 'IRN', '538071928', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '538071928'
			and pid.personid = 'a75b7fc3-0abf-4f6c-91eb-31eb76c00a6e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '738471ae-a8a3-4273-85ba-a5884f0f02db', 'IRN', '563072003', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '563072003'
			and pid.personid = '738471ae-a8a3-4273-85ba-a5884f0f02db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4dd8f636-959d-48cc-b5bd-3348f36da879', 'IRN', '583071620', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '583071620'
			and pid.personid = '4dd8f636-959d-48cc-b5bd-3348f36da879');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '307d9e6f-13e8-4c06-86f7-62874e6d9737', 'IRN', '589072148', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '589072148'
			and pid.personid = '307d9e6f-13e8-4c06-86f7-62874e6d9737');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '78f00bde-1c22-4f4a-a0fe-04b13bba804d', 'IRN', '521071467', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '521071467'
			and pid.personid = '78f00bde-1c22-4f4a-a0fe-04b13bba804d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '56f9f7f4-a55a-411b-bb68-b7b45791436c', 'IRN', '563072002', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '563072002'
			and pid.personid = '56f9f7f4-a55a-411b-bb68-b7b45791436c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2178bccb-6b65-42e1-9f9b-2e1f9b86be61', 'IRN', '591071189', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '591071189'
			and pid.personid = '2178bccb-6b65-42e1-9f9b-2e1f9b86be61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'feca2a9d-86eb-4390-b66a-e714ce068b34', 'IRN', '583071619', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '583071619'
			and pid.personid = 'feca2a9d-86eb-4390-b66a-e714ce068b34');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd02a53f5-bab3-48a4-bc4c-7ee29ac18ead', 'IRN', '406001738', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '406001738'
			and pid.personid = 'd02a53f5-bab3-48a4-bc4c-7ee29ac18ead');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '11eafce9-d2ee-4558-862d-d6739b2cb9b7', 'IRN', '529071048', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '529071048'
			and pid.personid = '11eafce9-d2ee-4558-862d-d6739b2cb9b7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1800d78f-6de0-4a07-b854-a23a6162d9da', 'IRN', '417049944', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '417049944'
			and pid.personid = '1800d78f-6de0-4a07-b854-a23a6162d9da');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3ff7e31f-260c-4800-9156-1e1a74e64f00', 'IRN', '591071188', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '591071188'
			and pid.personid = '3ff7e31f-260c-4800-9156-1e1a74e64f00');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '20999e7f-f4a0-4efa-9edd-6b51ebc1f70b', 'IRN', '443059734', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '443059734'
			and pid.personid = '20999e7f-f4a0-4efa-9edd-6b51ebc1f70b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '91c36b2d-12db-434a-abaf-e8ef2789495b', 'IRN', '574072113', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '574072113'
			and pid.personid = '91c36b2d-12db-434a-abaf-e8ef2789495b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '859acbec-0b63-4ece-bce8-4c9151260ca4', 'IRN', '524070778', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '524070778'
			and pid.personid = '859acbec-0b63-4ece-bce8-4c9151260ca4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3da63e87-d09e-452b-812b-7efffcfd9baf', 'IRN', '586071112', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '586071112'
			and pid.personid = '3da63e87-d09e-452b-812b-7efffcfd9baf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '41af6a08-d9b5-43f4-b68d-555060c7262d', 'IRN', '560071823', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '560071823'
			and pid.personid = '41af6a08-d9b5-43f4-b68d-555060c7262d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '418b4525-0a78-4387-94ab-2248768887e2', 'IRN', '487008788', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '487008788'
			and pid.personid = '418b4525-0a78-4387-94ab-2248768887e2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '24abfc42-118c-4cec-81b9-4ac848b4597e', 'IRN', '597072188', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '597072188'
			and pid.personid = '24abfc42-118c-4cec-81b9-4ac848b4597e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd7714c10-31ac-4388-9b39-d33789d62808', 'IRN', '543071798', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '543071798'
			and pid.personid = 'd7714c10-31ac-4388-9b39-d33789d62808');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2727d0ea-5642-4d4d-9f16-757e8bb3ef76', 'IRN', '566071822', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '566071822'
			and pid.personid = '2727d0ea-5642-4d4d-9f16-757e8bb3ef76');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c41712f5-76dc-45a7-b244-5f7a1aa4b277', 'IRN', '580071489', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '580071489'
			and pid.personid = 'c41712f5-76dc-45a7-b244-5f7a1aa4b277');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '92adf656-aa13-48b5-9a8b-3d4681757345', 'IRN', '559072322', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '559072322'
			and pid.personid = '92adf656-aa13-48b5-9a8b-3d4681757345');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ce0a3934-ad5b-4327-addf-8faa2b18cb46', 'IRN', '566071821', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '566071821'
			and pid.personid = 'ce0a3934-ad5b-4327-addf-8faa2b18cb46');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '177cd5f2-2bac-4925-8936-805d7fd89346', 'IRN', '591071186', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '591071186'
			and pid.personid = '177cd5f2-2bac-4925-8936-805d7fd89346');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '336556aa-e737-4135-b062-15f7634843e2', 'IRN', '557073000', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '557073000'
			and pid.personid = '336556aa-e737-4135-b062-15f7634843e2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '41c6275c-817d-4778-b840-5490b0eee035', 'IRN', '510071543', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '510071543'
			and pid.personid = '41c6275c-817d-4778-b840-5490b0eee035');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f33814b2-dce4-4a66-ac76-621e358b0960', 'IRN', '571071569', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '571071569'
			and pid.personid = 'f33814b2-dce4-4a66-ac76-621e358b0960');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '19e1c27d-10d0-41f7-8183-7fb4748e4665', 'IRN', '427038493', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '427038493'
			and pid.personid = '19e1c27d-10d0-41f7-8183-7fb4748e4665');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '46fa5889-2db8-41c6-9e37-8d0640f67b3d', 'IRN', '513072452', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '513072452'
			and pid.personid = '46fa5889-2db8-41c6-9e37-8d0640f67b3d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7c555152-8772-4487-a0d8-f33bbc446de5', 'IRN', '501071233', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '501071233'
			and pid.personid = '7c555152-8772-4487-a0d8-f33bbc446de5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f9240c81-b783-4b73-b9e5-adb9338f181b', 'IRN', '455008958', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '455008958'
			and pid.personid = 'f9240c81-b783-4b73-b9e5-adb9338f181b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3b0f33fe-8a84-47c2-bfb4-e185c6701251', 'IRN', '522071623', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '522071623'
			and pid.personid = '3b0f33fe-8a84-47c2-bfb4-e185c6701251');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1ee193d3-6852-4731-8faf-2754adcda6bd', 'IRN', '510071542', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '510071542'
			and pid.personid = '1ee193d3-6852-4731-8faf-2754adcda6bd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '00153f38-ac8b-4c35-b3a6-6f9c3318564c', 'IRN', '505071160', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '505071160'
			and pid.personid = '00153f38-ac8b-4c35-b3a6-6f9c3318564c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c9a0ea46-c810-48e0-a38a-65e4d71ac5e3', 'IRN', '597072187', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '597072187'
			and pid.personid = 'c9a0ea46-c810-48e0-a38a-65e4d71ac5e3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '43f65065-f9b4-43e2-afcc-31c6409a4a1a', 'IRN', '563072001', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '563072001'
			and pid.personid = '43f65065-f9b4-43e2-afcc-31c6409a4a1a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '237119d2-c01e-4ca2-b7e4-b27d142151cc', 'IRN', '521071466', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '521071466'
			and pid.personid = '237119d2-c01e-4ca2-b7e4-b27d142151cc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd9b5da60-cc4b-4b61-a90b-7cf681393b0c', 'IRN', '539072434', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '539072434'
			and pid.personid = 'd9b5da60-cc4b-4b61-a90b-7cf681393b0c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd227bfcb-3226-4187-9ff2-fc4dc8a5b0e4', 'IRN', '400353772', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '400353772'
			and pid.personid = 'd227bfcb-3226-4187-9ff2-fc4dc8a5b0e4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ffb61b68-381e-4fe2-8e47-764e9351af91', 'IRN', '541071404', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '541071404'
			and pid.personid = 'ffb61b68-381e-4fe2-8e47-764e9351af91');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e55a0e3e-b80e-4c8c-9eea-671518cf6e82', 'IRN', '564071804', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '564071804'
			and pid.personid = 'e55a0e3e-b80e-4c8c-9eea-671518cf6e82');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cd192c9b-3722-4209-a70e-84aeb12d93dd', 'IRN', '593072373', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '593072373'
			and pid.personid = 'cd192c9b-3722-4209-a70e-84aeb12d93dd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7a3f9c62-45fc-4402-b763-f5b831a2b726', 'IRN', '506072081', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '506072081'
			and pid.personid = '7a3f9c62-45fc-4402-b763-f5b831a2b726');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7f0eaba4-3056-4496-b6c7-0922c71b98c2', 'IRN', '557072998', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '557072998'
			and pid.personid = '7f0eaba4-3056-4496-b6c7-0922c71b98c2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '79335fc5-c261-4304-8923-4f099ad7a661', 'IRN', '535071322', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '535071322'
			and pid.personid = '79335fc5-c261-4304-8923-4f099ad7a661');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '37311d89-7c4d-4830-a0c3-6ede5f2f8dc6', 'IRN', '527071973', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '527071973'
			and pid.personid = '37311d89-7c4d-4830-a0c3-6ede5f2f8dc6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ca2dc27c-8a92-4d46-b26b-4f910f73b5d7', 'IRN', '591071187', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '591071187'
			and pid.personid = 'ca2dc27c-8a92-4d46-b26b-4f910f73b5d7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2853b7d7-59ac-4a2f-b226-4cf31e7820c2', 'IRN', '504072787', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '504072787'
			and pid.personid = '2853b7d7-59ac-4a2f-b226-4cf31e7820c2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '26179255-906c-47d5-9ec7-94d170e4afc3', 'IRN', '527071972', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '527071972'
			and pid.personid = '26179255-906c-47d5-9ec7-94d170e4afc3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd08450ef-627a-4e5d-bdce-0b0f1089563f', 'IRN', '571071567', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '571071567'
			and pid.personid = 'd08450ef-627a-4e5d-bdce-0b0f1089563f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '913c79a0-9e10-4ef7-a4fb-14dca2032f9e', 'IRN', '517071596', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '517071596'
			and pid.personid = '913c79a0-9e10-4ef7-a4fb-14dca2032f9e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a1ec49b1-f9ab-4e70-99fb-224e47ad9d5a', 'IRN', '525072916', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '525072916'
			and pid.personid = 'a1ec49b1-f9ab-4e70-99fb-224e47ad9d5a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9034c2bc-5f08-4afa-bd2e-9cdd8844742c', 'IRN', '515071775', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '515071775'
			and pid.personid = '9034c2bc-5f08-4afa-bd2e-9cdd8844742c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '82d9f9b6-53da-4d63-a4b4-128f4314f8d9', 'IRN', '515071774', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '515071774'
			and pid.personid = '82d9f9b6-53da-4d63-a4b4-128f4314f8d9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '263ff5f7-4b93-47fd-be05-1bff7fc2671d', 'IRN', '584072110', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '584072110'
			and pid.personid = '263ff5f7-4b93-47fd-be05-1bff7fc2671d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4208780f-be24-4598-b904-dff9418e9114', 'IRN', '514071710', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '514071710'
			and pid.personid = '4208780f-be24-4598-b904-dff9418e9114');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e5bba008-b9a2-4896-be0e-94e2fa26765e', 'IRN', '569072349', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '569072349'
			and pid.personid = 'e5bba008-b9a2-4896-be0e-94e2fa26765e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0e9b19e5-de4b-464d-9794-48526246cc98', 'IRN', '598071322', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '598071322'
			and pid.personid = '0e9b19e5-de4b-464d-9794-48526246cc98');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd462443c-9b18-4879-bb67-9c74f1618e8c', 'IRN', '489038419', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '489038419'
			and pid.personid = 'd462443c-9b18-4879-bb67-9c74f1618e8c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cce821f9-4bbf-4f8b-a00a-62a4e98123e4', 'IRN', '525072915', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '525072915'
			and pid.personid = 'cce821f9-4bbf-4f8b-a00a-62a4e98123e4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd4252b6d-9de4-407c-b201-611352566050', 'IRN', '596071614', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '596071614'
			and pid.personid = 'd4252b6d-9de4-407c-b201-611352566050');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '415f5210-bc9d-47df-9749-c9e03265f0e8', 'IRN', '578071886', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '578071886'
			and pid.personid = '415f5210-bc9d-47df-9749-c9e03265f0e8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a51bb730-530c-4d3a-867b-aabc042c0860', 'IRN', '503075814', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '503075814'
			and pid.personid = 'a51bb730-530c-4d3a-867b-aabc042c0860');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3de9b2ae-1768-45ad-bcad-588d341506fe', 'IRN', '522071622', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '522071622'
			and pid.personid = '3de9b2ae-1768-45ad-bcad-588d341506fe');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2e584ecb-eeaa-4c70-af2d-1b8510c2143d', 'IRN', '588071299', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '588071299'
			and pid.personid = '2e584ecb-eeaa-4c70-af2d-1b8510c2143d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8343d7ba-b665-4520-a908-3911cb882055', 'IRN', '535071321', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '535071321'
			and pid.personid = '8343d7ba-b665-4520-a908-3911cb882055');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '09ee9fc4-911f-4396-85a5-8a50819f8514', 'IRN', '520071622', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '520071622'
			and pid.personid = '09ee9fc4-911f-4396-85a5-8a50819f8514');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a35a4faa-417e-4a26-98f6-ac222af59253', 'IRN', '598071321', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '598071321'
			and pid.personid = 'a35a4faa-417e-4a26-98f6-ac222af59253');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f94bcefb-ff7b-4103-96ff-592133972ce5', 'IRN', '578071887', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '578071887'
			and pid.personid = 'f94bcefb-ff7b-4103-96ff-592133972ce5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7a9048df-1863-4956-82ad-a290a6d27f98', 'IRN', '517071598', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '517071598'
			and pid.personid = '7a9048df-1863-4956-82ad-a290a6d27f98');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7320a8a1-6c4d-4e47-941e-874f961a06ca', 'IRN', '525072917', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '525072917'
			and pid.personid = '7320a8a1-6c4d-4e47-941e-874f961a06ca');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8303b3d2-3cc7-490b-ab2f-7a99bd0553eb', 'IRN', '503075813', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '503075813'
			and pid.personid = '8303b3d2-3cc7-490b-ab2f-7a99bd0553eb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '41fe19a3-8fdc-47aa-9e84-538d2207c3a5', 'IRN', '580071488', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '580071488'
			and pid.personid = '41fe19a3-8fdc-47aa-9e84-538d2207c3a5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '31ae811e-e52a-4ea5-baa9-94403bcbf19f', 'IRN', '536072049', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '536072049'
			and pid.personid = '31ae811e-e52a-4ea5-baa9-94403bcbf19f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '969a581d-f11b-434b-b6f4-f45654783512', 'IRN', '577072065', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '577072065'
			and pid.personid = '969a581d-f11b-434b-b6f4-f45654783512');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c0dc75be-5361-43f2-bb4c-d128b68a7543', 'IRN', '595071867', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '595071867'
			and pid.personid = 'c0dc75be-5361-43f2-bb4c-d128b68a7543');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '697c1313-9b8e-414b-a367-f3c2dc4cb03e', 'IRN', '567071851', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '567071851'
			and pid.personid = '697c1313-9b8e-414b-a367-f3c2dc4cb03e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9b1d744a-91c5-416f-95e6-0690174185c6', 'IRN', '585071820', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '585071820'
			and pid.personid = '9b1d744a-91c5-416f-95e6-0690174185c6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '22f33d2f-3985-4fbf-b8c9-e3396f13dade', 'IRN', '599072076', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '599072076'
			and pid.personid = '22f33d2f-3985-4fbf-b8c9-e3396f13dade');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cb9f62a9-f35e-4542-8d7a-16fbc52ae76f', 'IRN', '595071868', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '595071868'
			and pid.personid = 'cb9f62a9-f35e-4542-8d7a-16fbc52ae76f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd0d1d7b4-db59-4651-ac89-7d35d05ff083', 'IRN', '571071568', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '571071568'
			and pid.personid = 'd0d1d7b4-db59-4651-ac89-7d35d05ff083');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cff5f2a4-601e-4eac-b709-962a10a42bf4', 'IRN', '507071822', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '507071822'
			and pid.personid = 'cff5f2a4-601e-4eac-b709-962a10a42bf4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3ed19fc1-2ac3-44c7-b412-6755552e9c5d', 'IRN', '559072321', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '559072321'
			and pid.personid = '3ed19fc1-2ac3-44c7-b412-6755552e9c5d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0b35014e-7610-4f6b-a6d9-9de712b969b1', 'IRN', '582071488', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '582071488'
			and pid.personid = '0b35014e-7610-4f6b-a6d9-9de712b969b1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '281eafa1-6c56-44a2-bd43-0d346ec67860', 'IRN', '546071740', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '546071740'
			and pid.personid = '281eafa1-6c56-44a2-bd43-0d346ec67860');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5118a1bf-b529-40ff-9d3c-31fa373de03b', 'IRN', '504072786', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '504072786'
			and pid.personid = '5118a1bf-b529-40ff-9d3c-31fa373de03b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8293c566-4c47-4931-963b-fa7f1e5e76dc', 'IRN', '505071159', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '505071159'
			and pid.personid = '8293c566-4c47-4931-963b-fa7f1e5e76dc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5573a0e5-f500-4cf4-854f-4a96461f2237', 'IRN', '544071362', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '544071362'
			and pid.personid = '5573a0e5-f500-4cf4-854f-4a96461f2237');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ed03c6b1-8eee-4dfe-ba3a-d014a7c013a9', 'IRN', '599072075', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '599072075'
			and pid.personid = 'ed03c6b1-8eee-4dfe-ba3a-d014a7c013a9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5e4f1f9e-bbaf-48c8-8e3b-7b630c24fef1', 'IRN', '523072175', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '523072175'
			and pid.personid = '5e4f1f9e-bbaf-48c8-8e3b-7b630c24fef1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4b8957df-d6ca-4654-ba3c-abdc3fc03fd8', 'IRN', '567071852', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '567071852'
			and pid.personid = '4b8957df-d6ca-4654-ba3c-abdc3fc03fd8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '39c2791f-ecea-403e-aecc-51d7e449d183', 'IRN', '569072350', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '569072350'
			and pid.personid = '39c2791f-ecea-403e-aecc-51d7e449d183');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9bf9891a-ea21-4ea4-8941-22e7b4bb745d', 'IRN', '506072080', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '506072080'
			and pid.personid = '9bf9891a-ea21-4ea4-8941-22e7b4bb745d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b8ed517a-5ecd-49b4-bcce-51f4a0f34f61', 'IRN', '557072999', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '557072999'
			and pid.personid = 'b8ed517a-5ecd-49b4-bcce-51f4a0f34f61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7fe79438-ce35-46ce-8834-d3a6274f84c6', 'IRN', '408026395', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '408026395'
			and pid.personid = '7fe79438-ce35-46ce-8834-d3a6274f84c6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1a695b78-5e79-4fb0-ad72-b46b14c6e313', 'IRN', '581071998', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '581071998'
			and pid.personid = '1a695b78-5e79-4fb0-ad72-b46b14c6e313');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'eeac2205-36c2-4a17-8813-8dc785458cf5', 'IRN', '553072813', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '553072813'
			and pid.personid = 'eeac2205-36c2-4a17-8813-8dc785458cf5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '429db12a-974b-49b3-b170-95927767cc0c', 'IRN', '506072082', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '506072082'
			and pid.personid = '429db12a-974b-49b3-b170-95927767cc0c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9374f80e-06dc-4ce5-8d66-f026086b1f43', 'IRN', '597072186', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '597072186'
			and pid.personid = '9374f80e-06dc-4ce5-8d66-f026086b1f43');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '14764862-0970-415f-9492-f932a87ca026', 'IRN', '587071794', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '587071794'
			and pid.personid = '14764862-0970-415f-9492-f932a87ca026');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '752666dc-87eb-4eeb-834b-a8cd32a03cef', 'IRN', '501071232', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '501071232'
			and pid.personid = '752666dc-87eb-4eeb-834b-a8cd32a03cef');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4fe308e5-7f93-465a-a920-c713c9365c5b', 'IRN', '508071840', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071840'
			and pid.personid = '4fe308e5-7f93-465a-a920-c713c9365c5b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a07f3750-5014-453d-b784-bf1d323248cb', 'IRN', '508071842', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071842'
			and pid.personid = 'a07f3750-5014-453d-b784-bf1d323248cb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7498e2b8-1708-4871-b37a-9381872a9fb7', 'IRN', '583071618', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '583071618'
			and pid.personid = '7498e2b8-1708-4871-b37a-9381872a9fb7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '723e7c2b-f7eb-479c-b4b0-ea0dbf963608', 'IRN', '511071723', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '511071723'
			and pid.personid = '723e7c2b-f7eb-479c-b4b0-ea0dbf963608');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b2504972-5df4-42e4-acff-0a93e0948cb8', 'IRN', '508071841', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '508071841'
			and pid.personid = 'b2504972-5df4-42e4-acff-0a93e0948cb8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '64425adf-3b80-474d-a9bb-e904b55b11fb', 'IRN', '539072433', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '539072433'
			and pid.personid = '64425adf-3b80-474d-a9bb-e904b55b11fb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bc9b8988-a5ef-4539-871e-cb5e4cb406d6', 'IRN', '519071875', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '519071875'
			and pid.personid = 'bc9b8988-a5ef-4539-871e-cb5e4cb406d6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4c95741c-54b7-42cb-89cb-4ba46f348ea9', 'IRN', '551072371', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '551072371'
			and pid.personid = '4c95741c-54b7-42cb-89cb-4ba46f348ea9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ce678053-79a2-48b3-93c3-a523a5c44551', 'IRN', '566071820', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '566071820'
			and pid.personid = 'ce678053-79a2-48b3-93c3-a523a5c44551');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1227982c-4f80-4453-82ff-5f11abfc5598', 'IRN', '587071793', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '587071793'
			and pid.personid = '1227982c-4f80-4453-82ff-5f11abfc5598');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2635f384-c26f-4aaa-b625-247f8d5403db', 'IRN', '512071964', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '512071964'
			and pid.personid = '2635f384-c26f-4aaa-b625-247f8d5403db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '56e31ec1-ef8e-4075-8d1a-faf077b628c6', 'IRN', '585071818', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '585071818'
			and pid.personid = '56e31ec1-ef8e-4075-8d1a-faf077b628c6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7c9c31a5-69bb-48f5-8dbe-4bff0d533c10', 'IRN', '531071768', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '531071768'
			and pid.personid = '7c9c31a5-69bb-48f5-8dbe-4bff0d533c10');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1b24c3f1-4a08-43f6-ab38-e5874add3e65', 'IRN', '593072372', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '593072372'
			and pid.personid = '1b24c3f1-4a08-43f6-ab38-e5874add3e65');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '341cbe7c-4b86-453d-b8ee-db0694fac706', 'IRN', '594072205', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '594072205'
			and pid.personid = '341cbe7c-4b86-453d-b8ee-db0694fac706');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c18bf9ac-0b64-4a2d-b38f-7464519c0394', 'IRN', '592071555', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '592071555'
			and pid.personid = 'c18bf9ac-0b64-4a2d-b38f-7464519c0394');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '227cfeb4-3d2a-45a4-b3f7-f7942e53f2dc', 'IRN', '525072914', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '525072914'
			and pid.personid = '227cfeb4-3d2a-45a4-b3f7-f7942e53f2dc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bcdd3ce5-2fb8-4ee6-a158-9cab82f28f10', 'IRN', '517071597', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '517071597'
			and pid.personid = 'bcdd3ce5-2fb8-4ee6-a158-9cab82f28f10');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '062a93ea-5c11-4f5a-98da-b3d9a01a8417', 'IRN', '562071870', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '562071870'
			and pid.personid = '062a93ea-5c11-4f5a-98da-b3d9a01a8417');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7bf6ecae-0faa-4344-a040-8595ec6d9ec2', 'IRN', '562071869', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '562071869'
			and pid.personid = '7bf6ecae-0faa-4344-a040-8595ec6d9ec2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd16cd0f3-fd1d-4117-9d55-46da3d83170b', 'IRN', '520071621', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '520071621'
			and pid.personid = 'd16cd0f3-fd1d-4117-9d55-46da3d83170b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2cea5d0e-5b1b-476f-88e3-a7ce9915c0df', 'IRN', '503075812', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '503075812'
			and pid.personid = '2cea5d0e-5b1b-476f-88e3-a7ce9915c0df');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3469790f-f0fb-444c-a376-4a42682a6090', 'IRN', '534071887', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '534071887'
			and pid.personid = '3469790f-f0fb-444c-a376-4a42682a6090');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '890e262c-e99f-4b22-a29e-0ef7c9fc0c98', 'IRN', '526071083', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '526071083'
			and pid.personid = '890e262c-e99f-4b22-a29e-0ef7c9fc0c98');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8ab06673-025b-4c6e-b6f7-9c57c9f175c5', 'IRN', '553072812', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '553072812'
			and pid.personid = '8ab06673-025b-4c6e-b6f7-9c57c9f175c5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b38b77a8-b56f-41ec-be6b-257bdea25ab1', 'IRN', '454064028', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '454064028'
			and pid.personid = 'b38b77a8-b56f-41ec-be6b-257bdea25ab1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '978f29aa-d94b-47ec-b2bf-64952e42b5fd', 'IRN', '467058085', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '467058085'
			and pid.personid = '978f29aa-d94b-47ec-b2bf-64952e42b5fd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9eff6b8c-5d00-48fd-9616-05da3bd72d72', 'IRN', '413009244', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '413009244'
			and pid.personid = '9eff6b8c-5d00-48fd-9616-05da3bd72d72');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b7f2db71-7f58-4938-922b-98f91cc250a6', 'IRN', '597072185', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '597072185'
			and pid.personid = 'b7f2db71-7f58-4938-922b-98f91cc250a6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '14a7e32a-f401-4f49-85d5-74bbb31411ba', 'IRN', '406055564', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '406055564'
			and pid.personid = '14a7e32a-f401-4f49-85d5-74bbb31411ba');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b5816b89-33e5-403a-bb76-54631e0f4e1b', 'IRN', '533070974', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '533070974'
			and pid.personid = 'b5816b89-33e5-403a-bb76-54631e0f4e1b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '361066e4-5c30-43cc-ae17-e63a4442bb48', 'IRN', '510071541', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '510071541'
			and pid.personid = '361066e4-5c30-43cc-ae17-e63a4442bb48');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b8b43488-3241-4807-9128-649034d3761d', 'IRN', '400632911', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '400632911'
			and pid.personid = 'b8b43488-3241-4807-9128-649034d3761d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd3402845-ddbe-4d5f-b5f4-77abdf013626', 'IRN', '563071748', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'IRN' 
			and btrim(pid.personidentifiervalue) = '563071748'
			and pid.personid = 'd3402845-ddbe-4d5f-b5f4-77abdf013626');

--  Insert MDM ID in personidentifier table
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '466d5b46-f461-4080-a533-a27c2dc9666f', 'MDM_ID', 'MDT-155633652', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633652'
			and pid.personid = '466d5b46-f461-4080-a533-a27c2dc9666f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a1fbe766-4538-4256-9a11-3cc2a6bd2708', 'MDM_ID', 'MDT-155633651', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633651'
			and pid.personid = 'a1fbe766-4538-4256-9a11-3cc2a6bd2708');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '44fafadb-0a3c-4776-b32b-806a797b6e45', 'MDM_ID', 'MDT-155633605', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633605'
			and pid.personid = '44fafadb-0a3c-4776-b32b-806a797b6e45');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3c1301f1-4c1b-43a4-b77a-cafb4f304ebc', 'MDM_ID', 'MDT-155633650', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633650'
			and pid.personid = '3c1301f1-4c1b-43a4-b77a-cafb4f304ebc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7b19cf8b-a003-4b0c-9a95-644682542e94', 'MDM_ID', 'MDT-155633603', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633603'
			and pid.personid = '7b19cf8b-a003-4b0c-9a95-644682542e94');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '60ed178d-563c-40c1-8cf4-b40556c6aa61', 'MDM_ID', 'MDT-155633649', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633649'
			and pid.personid = '60ed178d-563c-40c1-8cf4-b40556c6aa61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2d262284-9ab1-4d9b-bb73-4537484771e8', 'MDM_ID', 'MDT-155641324', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641324'
			and pid.personid = '2d262284-9ab1-4d9b-bb73-4537484771e8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7536a9c9-5449-4d67-9063-46fe18a4153c', 'MDM_ID', 'MDT-155633648', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633648'
			and pid.personid = '7536a9c9-5449-4d67-9063-46fe18a4153c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '868f833e-7316-4734-89fa-a2501b848eca', 'MDM_ID', 'MDT-155633647', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633647'
			and pid.personid = '868f833e-7316-4734-89fa-a2501b848eca');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3b04c22c-9488-4bbf-8a00-50baaf0ec803', 'MDM_ID', 'MDT-155641323', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641323'
			and pid.personid = '3b04c22c-9488-4bbf-8a00-50baaf0ec803');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '30dd4858-3f42-46cc-941c-702c49fa9caf', 'MDM_ID', 'MDT-155633601', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633601'
			and pid.personid = '30dd4858-3f42-46cc-941c-702c49fa9caf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a4a6e9d4-9939-4219-9219-65fa23fc267b', 'MDM_ID', 'MDT-155633646', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633646'
			and pid.personid = 'a4a6e9d4-9939-4219-9219-65fa23fc267b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '834255db-23aa-4728-87b9-da4d0a351f14', 'MDM_ID', 'MDT-155641322', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641322'
			and pid.personid = '834255db-23aa-4728-87b9-da4d0a351f14');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a12943f6-f140-4f46-a38f-16d6225ebb77', 'MDM_ID', 'MDT-155641321', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641321'
			and pid.personid = 'a12943f6-f140-4f46-a38f-16d6225ebb77');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a5dc8721-d097-431c-bc3f-89097647ad2e', 'MDM_ID', 'MDT-155633645', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633645'
			and pid.personid = 'a5dc8721-d097-431c-bc3f-89097647ad2e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd1dacf7e-b5e8-4275-9965-78a5aa989c1d', 'MDM_ID', 'MDT-155633644', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633644'
			and pid.personid = 'd1dacf7e-b5e8-4275-9965-78a5aa989c1d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cde4bbba-ff17-4869-af20-55e2717146ef', 'MDM_ID', 'MDT-155633643', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633643'
			and pid.personid = 'cde4bbba-ff17-4869-af20-55e2717146ef');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '87de45eb-2061-4638-9015-ec88e51b6e9f', 'MDM_ID', 'MDT-155633642', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633642'
			and pid.personid = '87de45eb-2061-4638-9015-ec88e51b6e9f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '832ef022-e700-4912-aa68-4876b32822d6', 'MDM_ID', 'MDT-127748631', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127748631'
			and pid.personid = '832ef022-e700-4912-aa68-4876b32822d6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9d3881e7-ea64-4de9-8af2-3661b635da75', 'MDM_ID', 'MDT-155590466', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155590466'
			and pid.personid = '9d3881e7-ea64-4de9-8af2-3661b635da75');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'acb06b51-4fe2-4cda-8ece-1f11eadd4b5e', 'MDM_ID', 'MDT-155641293', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641293'
			and pid.personid = 'acb06b51-4fe2-4cda-8ece-1f11eadd4b5e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a8eecdb9-f74c-41d5-83f7-c7af0c76e458', 'MDM_ID', 'MDT-155641319', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641319'
			and pid.personid = 'a8eecdb9-f74c-41d5-83f7-c7af0c76e458');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6ac9e3db-ae8e-48f6-8912-9187eeda662c', 'MDM_ID', 'MDT-155633640', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633640'
			and pid.personid = '6ac9e3db-ae8e-48f6-8912-9187eeda662c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '636846e9-ec15-4b37-b9bd-18f6db39eebe', 'MDM_ID', 'MDT-155633639', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633639'
			and pid.personid = '636846e9-ec15-4b37-b9bd-18f6db39eebe');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8d7e6ee1-6208-4b85-a737-f07713e17a84', 'MDM_ID', 'MDT-155633638', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633638'
			and pid.personid = '8d7e6ee1-6208-4b85-a737-f07713e17a84');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '01fb9a99-65b6-4cbc-95cc-46b27c16d6d5', 'MDM_ID', 'MDT-155641289', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641289'
			and pid.personid = '01fb9a99-65b6-4cbc-95cc-46b27c16d6d5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'adced735-7990-4df9-86b6-59cd03726c1b', 'MDM_ID', 'MDT-155633637', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633637'
			and pid.personid = 'adced735-7990-4df9-86b6-59cd03726c1b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cb1cb4f1-e9f5-43bb-935e-645ab40b1037', 'MDM_ID', 'MDT-155641318', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641318'
			and pid.personid = 'cb1cb4f1-e9f5-43bb-935e-645ab40b1037');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '631afa37-cebd-4612-bfa0-28db93d97979', 'MDM_ID', 'MDT-155641285', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641285'
			and pid.personid = '631afa37-cebd-4612-bfa0-28db93d97979');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '05fc80eb-ff7d-45c6-b796-bd63f9bbff9f', 'MDM_ID', 'MDT-155641284', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641284'
			and pid.personid = '05fc80eb-ff7d-45c6-b796-bd63f9bbff9f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3df5d37b-8934-4690-a948-7e143fda1210', 'MDM_ID', 'MDT-155633636', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633636'
			and pid.personid = '3df5d37b-8934-4690-a948-7e143fda1210');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a72cd695-4536-41c4-800f-5a431164f978', 'MDM_ID', 'MDT-155633593', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633593'
			and pid.personid = 'a72cd695-4536-41c4-800f-5a431164f978');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '408b8e55-dfb7-4018-8897-f634d52986a8', 'MDM_ID', 'MDT-155633635', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633635'
			and pid.personid = '408b8e55-dfb7-4018-8897-f634d52986a8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e3391f51-04e3-49b5-928c-6e8c2e47e30c', 'MDM_ID', 'MDT-155641316', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641316'
			and pid.personid = 'e3391f51-04e3-49b5-928c-6e8c2e47e30c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd35e1f84-aefa-480e-8ebd-86aef12c0feb', 'MDM_ID', 'MDT-155641315', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641315'
			and pid.personid = 'd35e1f84-aefa-480e-8ebd-86aef12c0feb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5fec9092-9d75-4393-8d0d-2209ab0acb32', 'MDM_ID', 'MDT-155633634', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633634'
			and pid.personid = '5fec9092-9d75-4393-8d0d-2209ab0acb32');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '41aee92f-a514-4b42-b44a-a5d29b0722e4', 'MDM_ID', 'MDT-155633633', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633633'
			and pid.personid = '41aee92f-a514-4b42-b44a-a5d29b0722e4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '71ab4c52-cf3a-4bdb-abcd-36bd749f4c7c', 'MDM_ID', 'MDT-155641314', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641314'
			and pid.personid = '71ab4c52-cf3a-4bdb-abcd-36bd749f4c7c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '79a4d160-8269-428b-9644-0f46110a1819', 'MDM_ID', 'MDT-155633632', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633632'
			and pid.personid = '79a4d160-8269-428b-9644-0f46110a1819');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '437dcc82-94dd-407f-8d83-b04151c2c630', 'MDM_ID', 'MDT-155633631', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633631'
			and pid.personid = '437dcc82-94dd-407f-8d83-b04151c2c630');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '623b57f6-cae0-4469-90b4-811def34ffa1', 'MDM_ID', 'MDT-155633630', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633630'
			and pid.personid = '623b57f6-cae0-4469-90b4-811def34ffa1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4aa57ecd-386a-46b4-82e0-c91f73043e09', 'MDM_ID', 'MDT-155641313', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641313'
			and pid.personid = '4aa57ecd-386a-46b4-82e0-c91f73043e09');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '52302521-12fd-4f61-9963-749be6611def', 'MDM_ID', 'MDT-155633629', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633629'
			and pid.personid = '52302521-12fd-4f61-9963-749be6611def');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '779d0670-800d-46ef-8249-eda0c25f2671', 'MDM_ID', 'MDT-155641277', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641277'
			and pid.personid = '779d0670-800d-46ef-8249-eda0c25f2671');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '06eee475-db5b-411b-b3d0-c4e023a72dab', 'MDM_ID', 'MDT-155633581', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633581'
			and pid.personid = '06eee475-db5b-411b-b3d0-c4e023a72dab');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2038290c-17a3-4577-b785-ce7c92525039', 'MDM_ID', 'MDT-155633628', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633628'
			and pid.personid = '2038290c-17a3-4577-b785-ce7c92525039');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'badff16e-8128-43f8-be7d-64f90ed0745c', 'MDM_ID', 'MDT-155633627', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633627'
			and pid.personid = 'badff16e-8128-43f8-be7d-64f90ed0745c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c001453e-7d66-4927-aa6d-67ae55cc426a', 'MDM_ID', 'MDT-155633626', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633626'
			and pid.personid = 'c001453e-7d66-4927-aa6d-67ae55cc426a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '90445008-2fbe-41af-a364-f9a1807dfe9a', 'MDM_ID', 'MDT-155633625', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633625'
			and pid.personid = '90445008-2fbe-41af-a364-f9a1807dfe9a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9454c0ba-ef57-492a-a334-552cc061dd95', 'MDM_ID', 'MDT-155641312', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641312'
			and pid.personid = '9454c0ba-ef57-492a-a334-552cc061dd95');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '961c6337-dbcf-4fba-b9c2-355f9fb80d43', 'MDM_ID', 'MDT-155633580', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633580'
			and pid.personid = '961c6337-dbcf-4fba-b9c2-355f9fb80d43');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2b619ec4-bbaf-4db6-8a27-fbe56de3cf47', 'MDM_ID', 'MDT-128287446', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-128287446'
			and pid.personid = '2b619ec4-bbaf-4db6-8a27-fbe56de3cf47');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '893e53f0-6cfc-41a1-b44a-20f4064d55a9', 'MDM_ID', 'MDT-155641272', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641272'
			and pid.personid = '893e53f0-6cfc-41a1-b44a-20f4064d55a9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '02dcb60f-9c71-4b77-b3b5-cc069bfa5cbf', 'MDM_ID', 'MDT-128804498', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-128804498'
			and pid.personid = '02dcb60f-9c71-4b77-b3b5-cc069bfa5cbf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3b419d14-9cc5-4437-b177-0bacb679e89b', 'MDM_ID', 'MDT-155633621', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633621'
			and pid.personid = '3b419d14-9cc5-4437-b177-0bacb679e89b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '689e23cd-e5d7-4117-a741-4410677e960a', 'MDM_ID', 'MDT-155641271', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641271'
			and pid.personid = '689e23cd-e5d7-4117-a741-4410677e960a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7fa7cae1-ba6b-40e2-92f3-b67799f93585', 'MDM_ID', 'MDT-155641311', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641311'
			and pid.personid = '7fa7cae1-ba6b-40e2-92f3-b67799f93585');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9bc51e6e-087d-4941-a40b-ace4e21c01ff', 'MDM_ID', 'MDT-155633577', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633577'
			and pid.personid = '9bc51e6e-087d-4941-a40b-ace4e21c01ff');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ddc0e0cd-4f72-4440-a43f-1ee9412ff284', 'MDM_ID', 'MDT-155641310', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641310'
			and pid.personid = 'ddc0e0cd-4f72-4440-a43f-1ee9412ff284');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bb938d7c-bc74-48fc-9304-27aa3e6a52e4', 'MDM_ID', 'MDT-155633576', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633576'
			and pid.personid = 'bb938d7c-bc74-48fc-9304-27aa3e6a52e4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '92cdb3ae-f1bf-4ec0-a738-d0b60d01c662', 'MDM_ID', 'MDT-155633620', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633620'
			and pid.personid = '92cdb3ae-f1bf-4ec0-a738-d0b60d01c662');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '36630938-e064-47fd-b95b-3fd39d8f2099', 'MDM_ID', 'MDT-155633619', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633619'
			and pid.personid = '36630938-e064-47fd-b95b-3fd39d8f2099');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '782fab29-4986-411b-b3ea-1379f18fb579', 'MDM_ID', 'MDT-155633575', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633575'
			and pid.personid = '782fab29-4986-411b-b3ea-1379f18fb579');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '81487fd0-14d9-4291-afac-f7c1457f32a3', 'MDM_ID', 'MDT-123971474', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-123971474'
			and pid.personid = '81487fd0-14d9-4291-afac-f7c1457f32a3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ade79738-b347-457c-a668-3765c53f7d20', 'MDM_ID', 'MDT-155641308', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641308'
			and pid.personid = 'ade79738-b347-457c-a668-3765c53f7d20');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f2c799f4-b084-4b14-adfe-263a847f2f79', 'MDM_ID', 'MDT-126926842', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-126926842'
			and pid.personid = 'f2c799f4-b084-4b14-adfe-263a847f2f79');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e895f09c-2542-4378-80f7-e94295584154', 'MDM_ID', 'MDT-155633617', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633617'
			and pid.personid = 'e895f09c-2542-4378-80f7-e94295584154');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b90b3042-91a4-4553-b41d-b86c7d94c2f5', 'MDM_ID', 'MDT-155633615', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633615'
			and pid.personid = 'b90b3042-91a4-4553-b41d-b86c7d94c2f5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'eea5f468-f68f-44ad-9513-5150423c1329', 'MDM_ID', 'MDT-155641270', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641270'
			and pid.personid = 'eea5f468-f68f-44ad-9513-5150423c1329');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bcf7c3e4-2bf7-4c17-aed9-a4160c3f51cf', 'MDM_ID', 'MDT-155491380', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155491380'
			and pid.personid = 'bcf7c3e4-2bf7-4c17-aed9-a4160c3f51cf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9be498ab-95af-4cb9-95da-b44216866045', 'MDM_ID', 'MDT-155641269', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641269'
			and pid.personid = '9be498ab-95af-4cb9-95da-b44216866045');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f6b0477c-6f9a-473e-86b4-491d6b395833', 'MDM_ID', 'MDT-155633614', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633614'
			and pid.personid = 'f6b0477c-6f9a-473e-86b4-491d6b395833');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9df48948-69ac-4d9c-b8a3-c2603d2b3591', 'MDM_ID', 'MDT-155633613', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633613'
			and pid.personid = '9df48948-69ac-4d9c-b8a3-c2603d2b3591');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0b556eb7-dd93-4ccc-8ee6-e8f779483a3d', 'MDM_ID', 'MDT-155633574', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633574'
			and pid.personid = '0b556eb7-dd93-4ccc-8ee6-e8f779483a3d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '849aacc9-90a4-45b8-86e7-c67f8312741f', 'MDM_ID', 'MDT-155633571', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633571'
			and pid.personid = '849aacc9-90a4-45b8-86e7-c67f8312741f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2796dcb1-3c58-4185-8f76-ea8265353b16', 'MDM_ID', 'MDT-155641307', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641307'
			and pid.personid = '2796dcb1-3c58-4185-8f76-ea8265353b16');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e2648f2c-ab85-4fcc-86a4-f76e3970f679', 'MDM_ID', 'MDT-155641268', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641268'
			and pid.personid = 'e2648f2c-ab85-4fcc-86a4-f76e3970f679');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '74cf4c99-9140-4fcd-a9f3-c2b0595a72db', 'MDM_ID', 'MDT-155633612', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633612'
			and pid.personid = '74cf4c99-9140-4fcd-a9f3-c2b0595a72db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a98da7d5-3b2f-4f77-b459-2f63d0e1d84c', 'MDM_ID', 'MDT-155641267', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641267'
			and pid.personid = 'a98da7d5-3b2f-4f77-b459-2f63d0e1d84c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bd245847-b4ce-4098-a9bb-9d2e7cd43834', 'MDM_ID', 'MDT-155633611', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633611'
			and pid.personid = 'bd245847-b4ce-4098-a9bb-9d2e7cd43834');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '33ab117b-d982-433f-9f70-719524e71ca0', 'MDM_ID', 'MDT-155633610', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633610'
			and pid.personid = '33ab117b-d982-433f-9f70-719524e71ca0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '428eb312-9071-4035-8c94-85b22b45c05f', 'MDM_ID', 'MDT-155641266', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641266'
			and pid.personid = '428eb312-9071-4035-8c94-85b22b45c05f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ee6d454f-b304-4b03-b9ed-33ed13ef8596', 'MDM_ID', 'MDT-155641306', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641306'
			and pid.personid = 'ee6d454f-b304-4b03-b9ed-33ed13ef8596');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f5b78530-d196-4bdd-acdc-ca2221def667', 'MDM_ID', 'MDT-155633609', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633609'
			and pid.personid = 'f5b78530-d196-4bdd-acdc-ca2221def667');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '90c4c401-ab29-4620-b368-532a4767b318', 'MDM_ID', 'MDT-155633608', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633608'
			and pid.personid = '90c4c401-ab29-4620-b368-532a4767b318');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '887ac5c0-073e-432b-8cd9-ae58f7d6dea8', 'MDM_ID', 'MDT-155633607', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633607'
			and pid.personid = '887ac5c0-073e-432b-8cd9-ae58f7d6dea8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6e709f2b-5afc-4bff-9e6b-d0c20b8a3444', 'MDM_ID', 'MDT-155641304', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641304'
			and pid.personid = '6e709f2b-5afc-4bff-9e6b-d0c20b8a3444');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '04feabd3-3776-40c2-8a8e-1c9fffd6bf16', 'MDM_ID', 'MDT-155633604', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633604'
			and pid.personid = '04feabd3-3776-40c2-8a8e-1c9fffd6bf16');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '98553efa-0763-4f3f-af86-0401dea36b9c', 'MDM_ID', 'MDT-155641303', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641303'
			and pid.personid = '98553efa-0763-4f3f-af86-0401dea36b9c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '55ed6497-76fa-42e5-8c98-973bec2f1d4a', 'MDM_ID', 'MDT-155641302', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641302'
			and pid.personid = '55ed6497-76fa-42e5-8c98-973bec2f1d4a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5800ef6c-7ebb-4f51-a9f2-1d51149a05d4', 'MDM_ID', 'MDT-155641265', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641265'
			and pid.personid = '5800ef6c-7ebb-4f51-a9f2-1d51149a05d4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5b4d62c8-2f02-4da0-99a5-a31f091bfb6b', 'MDM_ID', 'MDT-155633602', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633602'
			and pid.personid = '5b4d62c8-2f02-4da0-99a5-a31f091bfb6b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '69415eb8-77b7-4b9f-a29c-4943ebad8fdd', 'MDM_ID', 'MDT-155641301', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641301'
			and pid.personid = '69415eb8-77b7-4b9f-a29c-4943ebad8fdd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '667bfc5a-f663-45fb-8ca3-1dbaa7cb2690', 'MDM_ID', 'MDT-155641300', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641300'
			and pid.personid = '667bfc5a-f663-45fb-8ca3-1dbaa7cb2690');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd3aa356c-0ac9-4990-8281-a3588019027b', 'MDM_ID', 'MDT-155633600', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633600'
			and pid.personid = 'd3aa356c-0ac9-4990-8281-a3588019027b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9ebde388-7ac7-4f70-a2ff-8ceb0b86d9b6', 'MDM_ID', 'MDT-155641299', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641299'
			and pid.personid = '9ebde388-7ac7-4f70-a2ff-8ceb0b86d9b6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8fb2d04d-70c4-446f-a1bb-c0fc1e3bdaab', 'MDM_ID', 'MDT-155633599', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633599'
			and pid.personid = '8fb2d04d-70c4-446f-a1bb-c0fc1e3bdaab');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b92cee1f-e440-43f9-beca-8140d6bdce8d', 'MDM_ID', 'MDT-155633598', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633598'
			and pid.personid = 'b92cee1f-e440-43f9-beca-8140d6bdce8d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a9f72935-bdce-42a0-8e77-21f724c5d456', 'MDM_ID', 'MDT-128220293', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-128220293'
			and pid.personid = 'a9f72935-bdce-42a0-8e77-21f724c5d456');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bf2ff238-d858-4d06-bbad-e9eaa78814a5', 'MDM_ID', 'MDT-126617957', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-126617957'
			and pid.personid = 'bf2ff238-d858-4d06-bbad-e9eaa78814a5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2e53ad14-9ec4-47e7-904a-56de68139422', 'MDM_ID', 'MDT-155641296', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641296'
			and pid.personid = '2e53ad14-9ec4-47e7-904a-56de68139422');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e485ea61-3989-4829-9cf9-f8c27eddb7a5', 'MDM_ID', 'MDT-155641295', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641295'
			and pid.personid = 'e485ea61-3989-4829-9cf9-f8c27eddb7a5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9a9c2a40-28b2-4d38-b844-11e0e3387465', 'MDM_ID', 'MDT-128270477', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-128270477'
			and pid.personid = '9a9c2a40-28b2-4d38-b844-11e0e3387465');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'eafa3128-fbe3-43d4-9a24-94089b5a4540', 'MDM_ID', 'MDT-155641292', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641292'
			and pid.personid = 'eafa3128-fbe3-43d4-9a24-94089b5a4540');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1053961e-a80e-4998-9a5c-9673d92f9598', 'MDM_ID', 'MDT-155641291', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641291'
			and pid.personid = '1053961e-a80e-4998-9a5c-9673d92f9598');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a75c523f-23c9-47a3-98f8-f6cd0f50a2db', 'MDM_ID', 'MDT-155641290', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641290'
			and pid.personid = 'a75c523f-23c9-47a3-98f8-f6cd0f50a2db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '706f24e9-2266-4cde-a678-65ff32d2f3e3', 'MDM_ID', 'MDT-155633597', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633597'
			and pid.personid = '706f24e9-2266-4cde-a678-65ff32d2f3e3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '19c10802-9afd-4964-b73e-de0dbb0115cb', 'MDM_ID', 'MDT-155633596', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633596'
			and pid.personid = '19c10802-9afd-4964-b73e-de0dbb0115cb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7fa57733-37a4-4622-b76f-36627f743902', 'MDM_ID', 'MDT-155633595', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633595'
			and pid.personid = '7fa57733-37a4-4622-b76f-36627f743902');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef72a00d-78fa-47cd-95ee-fca24794b5fa', 'MDM_ID', 'MDT-155633594', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633594'
			and pid.personid = 'ef72a00d-78fa-47cd-95ee-fca24794b5fa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '92e02337-e5fd-406d-9d5e-703ae651ea17', 'MDM_ID', 'MDT-155641264', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641264'
			and pid.personid = '92e02337-e5fd-406d-9d5e-703ae651ea17');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c74f2706-2046-4298-8a42-09ab0f3c16cf', 'MDM_ID', 'MDT-155633570', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633570'
			and pid.personid = 'c74f2706-2046-4298-8a42-09ab0f3c16cf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6db3119a-4400-4f07-8f0f-59caf1462bc1', 'MDM_ID', 'MDT-155641288', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641288'
			and pid.personid = '6db3119a-4400-4f07-8f0f-59caf1462bc1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '402833e8-1f2f-41c4-81bf-d96791f2e4df', 'MDM_ID', 'MDT-155641287', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641287'
			and pid.personid = '402833e8-1f2f-41c4-81bf-d96791f2e4df');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'af1ac406-44df-4dd0-a543-0dd42c87cafd', 'MDM_ID', 'MDT-155641286', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641286'
			and pid.personid = 'af1ac406-44df-4dd0-a543-0dd42c87cafd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '93a2f8ee-b07b-4b78-a12d-80dfaf22118b', 'MDM_ID', 'MDT-155633592', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633592'
			and pid.personid = '93a2f8ee-b07b-4b78-a12d-80dfaf22118b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '26b701f8-0af3-4f67-ac55-7bfa136554de', 'MDM_ID', 'MDT-155641283', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641283'
			and pid.personid = '26b701f8-0af3-4f67-ac55-7bfa136554de');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba65ecf1-9077-4c11-8244-547387ba1006', 'MDM_ID', 'MDT-155633591', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633591'
			and pid.personid = 'ba65ecf1-9077-4c11-8244-547387ba1006');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'db2a6e91-75a2-4947-b22b-6299714e436d', 'MDM_ID', 'MDT-155641263', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641263'
			and pid.personid = 'db2a6e91-75a2-4947-b22b-6299714e436d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '56ec1d97-42f2-4cbd-aa72-07b781a454ef', 'MDM_ID', 'MDT-129263817', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-129263817'
			and pid.personid = '56ec1d97-42f2-4cbd-aa72-07b781a454ef');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '26573917-c28b-4750-8835-3e99bdc45fc8', 'MDM_ID', 'MDT-155641282', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641282'
			and pid.personid = '26573917-c28b-4750-8835-3e99bdc45fc8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3782f257-9843-4558-88e5-9504fb1c03e6', 'MDM_ID', 'MDT-155641281', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641281'
			and pid.personid = '3782f257-9843-4558-88e5-9504fb1c03e6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '48df6aa4-ffaa-4887-b44f-c063daf6d05e', 'MDM_ID', 'MDT-155641280', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641280'
			and pid.personid = '48df6aa4-ffaa-4887-b44f-c063daf6d05e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0dd93c49-594e-45e1-bd6e-65b72c730e61', 'MDM_ID', 'MDT-155641279', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641279'
			and pid.personid = '0dd93c49-594e-45e1-bd6e-65b72c730e61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ed336d45-cc16-4acc-a28f-0de29c53186d', 'MDM_ID', 'MDT-155633589', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633589'
			and pid.personid = 'ed336d45-cc16-4acc-a28f-0de29c53186d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '52c37aad-c3a9-4dbe-a439-5ff514c30665', 'MDM_ID', 'MDT-155633588', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633588'
			and pid.personid = '52c37aad-c3a9-4dbe-a439-5ff514c30665');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8b3bf5a1-08b5-43cf-b695-080c19cc2b08', 'MDM_ID', 'MDT-155633587', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633587'
			and pid.personid = '8b3bf5a1-08b5-43cf-b695-080c19cc2b08');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e511cff3-57d3-48eb-afad-0d1f58401f17', 'MDM_ID', 'MDT-155641278', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641278'
			and pid.personid = 'e511cff3-57d3-48eb-afad-0d1f58401f17');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '61945298-fe88-469a-aaea-f57f934ab120', 'MDM_ID', 'MDT-155633569', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633569'
			and pid.personid = '61945298-fe88-469a-aaea-f57f934ab120');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b10a9068-71da-438d-b5ee-ec52402413e7', 'MDM_ID', 'MDT-155633586', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633586'
			and pid.personid = 'b10a9068-71da-438d-b5ee-ec52402413e7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8255e289-64ca-4d2b-8499-3d2e60998ea5', 'MDM_ID', 'MDT-155633585', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633585'
			and pid.personid = '8255e289-64ca-4d2b-8499-3d2e60998ea5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9a6d745b-bb81-4fa1-889b-6295ac4ccc2a', 'MDM_ID', 'MDT-155633584', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633584'
			and pid.personid = '9a6d745b-bb81-4fa1-889b-6295ac4ccc2a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ffe25e17-e740-48f0-9712-3f34c10cf866', 'MDM_ID', 'MDT-155633583', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633583'
			and pid.personid = 'ffe25e17-e740-48f0-9712-3f34c10cf866');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f916b8da-6c38-4f9c-af98-514620220d4f', 'MDM_ID', 'MDT-155633568', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633568'
			and pid.personid = 'f916b8da-6c38-4f9c-af98-514620220d4f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3b10e23f-94db-42d1-90c5-3d5a1d3e2fc6', 'MDM_ID', 'MDT-155633582', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633582'
			and pid.personid = '3b10e23f-94db-42d1-90c5-3d5a1d3e2fc6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd928b906-9a71-4aa7-bf7b-ee727b1c1377', 'MDM_ID', 'MDT-155641262', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641262'
			and pid.personid = 'd928b906-9a71-4aa7-bf7b-ee727b1c1377');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f038b0d2-32c2-4c5b-bf96-cbf10673ac8b', 'MDM_ID', 'MDT-155633567', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633567'
			and pid.personid = 'f038b0d2-32c2-4c5b-bf96-cbf10673ac8b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd9c10f3e-127e-48f0-ad5a-6cd5e0e79687', 'MDM_ID', 'MDT-155641276', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641276'
			and pid.personid = 'd9c10f3e-127e-48f0-ad5a-6cd5e0e79687');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '30f2a427-8503-45f5-89e0-17f986d4d558', 'MDM_ID', 'MDT-155641275', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641275'
			and pid.personid = '30f2a427-8503-45f5-89e0-17f986d4d558');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0b78a04c-86fb-43b5-9399-c740d383d796', 'MDM_ID', 'MDT-155633579', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633579'
			and pid.personid = '0b78a04c-86fb-43b5-9399-c740d383d796');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e173ce99-d11f-42bb-9bea-40df039807b3', 'MDM_ID', 'MDT-155641274', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641274'
			and pid.personid = 'e173ce99-d11f-42bb-9bea-40df039807b3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c22061c8-c81b-4f97-9f57-3b920ad8b001', 'MDM_ID', 'MDT-155633578', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633578'
			and pid.personid = 'c22061c8-c81b-4f97-9f57-3b920ad8b001');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ab0957ca-a6d6-4a4b-8431-1608d505a6d7', 'MDM_ID', 'MDT-155641273', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641273'
			and pid.personid = 'ab0957ca-a6d6-4a4b-8431-1608d505a6d7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '25acd46f-2f2b-477e-a77b-e2abdc42955e', 'MDM_ID', 'MDT-155633573', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633573'
			and pid.personid = '25acd46f-2f2b-477e-a77b-e2abdc42955e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bbaeeb74-fe72-4981-beca-5a4aa743feeb', 'MDM_ID', 'MDT-155633572', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633572'
			and pid.personid = 'bbaeeb74-fe72-4981-beca-5a4aa743feeb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '43dd6283-4589-493a-b768-77ef291515c3', 'MDM_ID', 'MDT-155641261', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641261'
			and pid.personid = '43dd6283-4589-493a-b768-77ef291515c3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c8850c47-8513-4d30-b211-944148e854ce', 'MDM_ID', 'MDT-155641260', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641260'
			and pid.personid = 'c8850c47-8513-4d30-b211-944148e854ce');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd22eec64-e913-4b1f-a176-56ad1dd39c88', 'MDM_ID', 'MDT-155641259', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641259'
			and pid.personid = 'd22eec64-e913-4b1f-a176-56ad1dd39c88');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9f81e3c2-be0a-4796-8c17-aa5fc8c93c9a', 'MDM_ID', 'MDT-155633535', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633535'
			and pid.personid = '9f81e3c2-be0a-4796-8c17-aa5fc8c93c9a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cf764f41-2ac6-441c-822d-dc8767816517', 'MDM_ID', 'MDT-155633566', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633566'
			and pid.personid = 'cf764f41-2ac6-441c-822d-dc8767816517');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c1087234-c2da-4067-97ee-cb077196c2ad', 'MDM_ID', 'MDT-155633565', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633565'
			and pid.personid = 'c1087234-c2da-4067-97ee-cb077196c2ad');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2177db5f-8e5a-42be-a0cb-53aeea8eac75', 'MDM_ID', 'MDT-155641258', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641258'
			and pid.personid = '2177db5f-8e5a-42be-a0cb-53aeea8eac75');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'abf83396-3cbb-4f01-8a6a-1ece8763c8ab', 'MDM_ID', 'MDT-155633564', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633564'
			and pid.personid = 'abf83396-3cbb-4f01-8a6a-1ece8763c8ab');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0bda7c63-1014-47ca-8d5c-3546eba652e8', 'MDM_ID', 'MDT-129346412', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-129346412'
			and pid.personid = '0bda7c63-1014-47ca-8d5c-3546eba652e8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd6d5f878-54ab-40b7-930c-5399eb5b508c', 'MDM_ID', 'MDT-155641257', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641257'
			and pid.personid = 'd6d5f878-54ab-40b7-930c-5399eb5b508c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '959fa2ac-4a6c-4b67-82a3-e250d2204761', 'MDM_ID', 'MDT-155641256', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641256'
			and pid.personid = '959fa2ac-4a6c-4b67-82a3-e250d2204761');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '37a2c588-398f-432b-a4db-04afd3911753', 'MDM_ID', 'MDT-155641255', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641255'
			and pid.personid = '37a2c588-398f-432b-a4db-04afd3911753');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9a2e04ca-0184-4f63-b134-e305c261f280', 'MDM_ID', 'MDT-126564675', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-126564675'
			and pid.personid = '9a2e04ca-0184-4f63-b134-e305c261f280');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f42df58e-21eb-4d3a-95c0-0b60471b6848', 'MDM_ID', 'MDT-155633562', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633562'
			and pid.personid = 'f42df58e-21eb-4d3a-95c0-0b60471b6848');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '74b166b3-ac85-43c8-b500-dd35f80944fa', 'MDM_ID', 'MDT-126532949', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-126532949'
			and pid.personid = '74b166b3-ac85-43c8-b500-dd35f80944fa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8c2f5af0-f749-481a-9d14-cada023e1908', 'MDM_ID', 'MDT-128480778', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-128480778'
			and pid.personid = '8c2f5af0-f749-481a-9d14-cada023e1908');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ebeb1333-3771-4e77-94be-2bfd386a8d1f', 'MDM_ID', 'MDT-155633560', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633560'
			and pid.personid = 'ebeb1333-3771-4e77-94be-2bfd386a8d1f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e327b710-fdcb-4460-8745-e43e282aa411', 'MDM_ID', 'MDT-155633559', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633559'
			and pid.personid = 'e327b710-fdcb-4460-8745-e43e282aa411');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4da60ac4-839d-4568-a681-d0e18a6ebb95', 'MDM_ID', 'MDT-155633558', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633558'
			and pid.personid = '4da60ac4-839d-4568-a681-d0e18a6ebb95');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e064790e-e255-4185-8d96-2c1bff4ccb84', 'MDM_ID', 'MDT-155641251', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641251'
			and pid.personid = 'e064790e-e255-4185-8d96-2c1bff4ccb84');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '827224d5-7c0f-402b-97d6-08f0e6eb65e8', 'MDM_ID', 'MDT-155641250', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641250'
			and pid.personid = '827224d5-7c0f-402b-97d6-08f0e6eb65e8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd83b06bf-4978-4336-a651-3d638832146c', 'MDM_ID', 'MDT-155633557', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633557'
			and pid.personid = 'd83b06bf-4978-4336-a651-3d638832146c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c32ef98c-2a8f-4b17-9378-610f6e0ef78d', 'MDM_ID', 'MDT-155633556', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633556'
			and pid.personid = 'c32ef98c-2a8f-4b17-9378-610f6e0ef78d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7f50726c-d2f7-4122-a699-394d00fd4628', 'MDM_ID', 'MDT-127616420', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127616420'
			and pid.personid = '7f50726c-d2f7-4122-a699-394d00fd4628');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '308ca072-da99-4a37-8013-b5659ba4a226', 'MDM_ID', 'MDT-155633555', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633555'
			and pid.personid = '308ca072-da99-4a37-8013-b5659ba4a226');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef247ad8-9c8d-4b8e-9644-970d5beb18d1', 'MDM_ID', 'MDT-155633520', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633520'
			and pid.personid = 'ef247ad8-9c8d-4b8e-9644-970d5beb18d1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4f0a114e-e8fd-4a95-9fce-1a0df3e24055', 'MDM_ID', 'MDT-155641248', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641248'
			and pid.personid = '4f0a114e-e8fd-4a95-9fce-1a0df3e24055');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1e49f577-2fcd-431c-abde-181ed3221741', 'MDM_ID', 'MDT-155633553', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633553'
			and pid.personid = '1e49f577-2fcd-431c-abde-181ed3221741');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2e477717-33f9-43d2-8e67-fbd6468a4a70', 'MDM_ID', 'MDT-155633552', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633552'
			and pid.personid = '2e477717-33f9-43d2-8e67-fbd6468a4a70');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '55109895-8fb5-4a50-acf7-6e31181b1ee3', 'MDM_ID', 'MDT-155633518', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633518'
			and pid.personid = '55109895-8fb5-4a50-acf7-6e31181b1ee3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'de16d95a-54e5-461b-96c5-d577b1e8e80a', 'MDM_ID', 'MDT-155633551', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633551'
			and pid.personid = 'de16d95a-54e5-461b-96c5-d577b1e8e80a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5a682dfb-f7be-457d-b203-8ef9c162c295', 'MDM_ID', 'MDT-155641247', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641247'
			and pid.personid = '5a682dfb-f7be-457d-b203-8ef9c162c295');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '35bbd083-0243-45d5-bac2-c0061d6cfbaf', 'MDM_ID', 'MDT-155641246', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641246'
			and pid.personid = '35bbd083-0243-45d5-bac2-c0061d6cfbaf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '34e6efb0-2bab-4fb5-9b4d-8d9d72c97137', 'MDM_ID', 'MDT-155641245', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641245'
			and pid.personid = '34e6efb0-2bab-4fb5-9b4d-8d9d72c97137');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cd0b9c08-c2f3-45a0-b04b-666909cd6bb5', 'MDM_ID', 'MDT-155641244', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641244'
			and pid.personid = 'cd0b9c08-c2f3-45a0-b04b-666909cd6bb5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '478ad14e-2aee-41fa-bbfc-55ad1afc83f9', 'MDM_ID', 'MDT-155633550', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633550'
			and pid.personid = '478ad14e-2aee-41fa-bbfc-55ad1afc83f9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '12900d62-82f2-45d8-af70-fc3033a83477', 'MDM_ID', 'MDT-155641243', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641243'
			and pid.personid = '12900d62-82f2-45d8-af70-fc3033a83477');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '540b673c-4be8-45f4-9c3d-b37c970dea7f', 'MDM_ID', 'MDT-155633549', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633549'
			and pid.personid = '540b673c-4be8-45f4-9c3d-b37c970dea7f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5c9164b7-d6b7-4672-b99f-f475dc3f0803', 'MDM_ID', 'MDT-155641242', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641242'
			and pid.personid = '5c9164b7-d6b7-4672-b99f-f475dc3f0803');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6b9ac1be-2bdf-4dff-8dad-7c1264522b7d', 'MDM_ID', 'MDT-155633548', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633548'
			and pid.personid = '6b9ac1be-2bdf-4dff-8dad-7c1264522b7d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fdc53e3d-800e-4556-8f36-af7c3cdbbe76', 'MDM_ID', 'MDT-155641241', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641241'
			and pid.personid = 'fdc53e3d-800e-4556-8f36-af7c3cdbbe76');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'dc2afcd9-fd8f-4856-822a-d09419b13456', 'MDM_ID', 'MDT-155641240', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641240'
			and pid.personid = 'dc2afcd9-fd8f-4856-822a-d09419b13456');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '471e0b4a-2234-4c8a-814d-fcc513b76e75', 'MDM_ID', 'MDT-155633547', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633547'
			and pid.personid = '471e0b4a-2234-4c8a-814d-fcc513b76e75');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ecb9f079-87ce-4b72-bd03-5d5fbaef5cfe', 'MDM_ID', 'MDT-155641208', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641208'
			and pid.personid = 'ecb9f079-87ce-4b72-bd03-5d5fbaef5cfe');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ccce98f5-b72d-4414-b0d5-732f5818f15f', 'MDM_ID', 'MDT-155641239', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641239'
			and pid.personid = 'ccce98f5-b72d-4414-b0d5-732f5818f15f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '821708de-cd60-4ba2-9df3-f054939dba66', 'MDM_ID', 'MDT-123765356', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-123765356'
			and pid.personid = '821708de-cd60-4ba2-9df3-f054939dba66');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e11ea55e-5f2d-404a-b0ff-f51f2d094e42', 'MDM_ID', 'MDT-155633545', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633545'
			and pid.personid = 'e11ea55e-5f2d-404a-b0ff-f51f2d094e42');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '740eac55-3a11-4fbb-924d-921526cb6c54', 'MDM_ID', 'MDT-155641238', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641238'
			and pid.personid = '740eac55-3a11-4fbb-924d-921526cb6c54');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '891ba1f7-2f7d-4572-bc30-3b64f2003240', 'MDM_ID', 'MDT-155633544', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633544'
			and pid.personid = '891ba1f7-2f7d-4572-bc30-3b64f2003240');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9dc25426-2752-4643-a795-59ead8e90a6f', 'MDM_ID', 'MDT-155641206', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641206'
			and pid.personid = '9dc25426-2752-4643-a795-59ead8e90a6f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f0c364e1-eb92-437c-8f61-139a85bdb95d', 'MDM_ID', 'MDT-155641237', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641237'
			and pid.personid = 'f0c364e1-eb92-437c-8f61-139a85bdb95d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c88953b7-7366-485d-822f-ce78f7c0d8ce', 'MDM_ID', 'MDT-155641236', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641236'
			and pid.personid = 'c88953b7-7366-485d-822f-ce78f7c0d8ce');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c22997e9-4290-4a5e-9975-84ceed42e67a', 'MDM_ID', 'MDT-155641235', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641235'
			and pid.personid = 'c22997e9-4290-4a5e-9975-84ceed42e67a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '889c4e5e-72cc-4672-925a-302464a22a6d', 'MDM_ID', 'MDT-155633506', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633506'
			and pid.personid = '889c4e5e-72cc-4672-925a-302464a22a6d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5c5fdd53-9e20-4416-adb5-06dde136ffb8', 'MDM_ID', 'MDT-155641234', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641234'
			and pid.personid = '5c5fdd53-9e20-4416-adb5-06dde136ffb8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b5dd8885-e948-45aa-ade7-458e1cb8bd3d', 'MDM_ID', 'MDT-155633505', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633505'
			and pid.personid = 'b5dd8885-e948-45aa-ade7-458e1cb8bd3d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '22b7b2f6-efdd-4b35-b5e8-581845148f78', 'MDM_ID', 'MDT-155633504', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633504'
			and pid.personid = '22b7b2f6-efdd-4b35-b5e8-581845148f78');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8f30e09a-0a4a-4aeb-86c0-33638567ea61', 'MDM_ID', 'MDT-155633543', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633543'
			and pid.personid = '8f30e09a-0a4a-4aeb-86c0-33638567ea61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7c51896f-295c-4bc4-8848-bc7359c2ce93', 'MDM_ID', 'MDT-155633542', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633542'
			and pid.personid = '7c51896f-295c-4bc4-8848-bc7359c2ce93');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cbb3288d-829b-44b9-868d-0f1ef90c4414', 'MDM_ID', 'MDT-155633541', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633541'
			and pid.personid = 'cbb3288d-829b-44b9-868d-0f1ef90c4414');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a8ebe558-5795-4be4-b4ca-3c084bf157aa', 'MDM_ID', 'MDT-155641233', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641233'
			and pid.personid = 'a8ebe558-5795-4be4-b4ca-3c084bf157aa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'de89520c-11ca-47f5-b95c-f3c8b0ec2bb5', 'MDM_ID', 'MDT-155641232', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641232'
			and pid.personid = 'de89520c-11ca-47f5-b95c-f3c8b0ec2bb5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd2f32c29-62dd-43d6-aa16-3421d46fb7f8', 'MDM_ID', 'MDT-155641231', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641231'
			and pid.personid = 'd2f32c29-62dd-43d6-aa16-3421d46fb7f8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '45350145-f1ca-498a-81f8-1bb773031bb2', 'MDM_ID', 'MDT-155641230', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641230'
			and pid.personid = '45350145-f1ca-498a-81f8-1bb773031bb2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cc8767df-708b-439c-9c3f-9932c6167226', 'MDM_ID', 'MDT-155633540', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633540'
			and pid.personid = 'cc8767df-708b-439c-9c3f-9932c6167226');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '760f940f-46eb-441d-998b-92d4b2bbb7a2', 'MDM_ID', 'MDT-155633539', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633539'
			and pid.personid = '760f940f-46eb-441d-998b-92d4b2bbb7a2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e45ed80a-a669-445f-81d7-ada9231a1185', 'MDM_ID', 'MDT-155633538', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633538'
			and pid.personid = 'e45ed80a-a669-445f-81d7-ada9231a1185');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '967dc65e-5757-453a-9d38-04267f2bfe21', 'MDM_ID', 'MDT-155641229', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641229'
			and pid.personid = '967dc65e-5757-453a-9d38-04267f2bfe21');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '804c11c0-8c6d-418e-9a20-e9df865856ec', 'MDM_ID', 'MDT-155633537', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633537'
			and pid.personid = '804c11c0-8c6d-418e-9a20-e9df865856ec');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e33099fd-3c55-425e-8b22-be61647de7ad', 'MDM_ID', 'MDT-155641228', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641228'
			and pid.personid = 'e33099fd-3c55-425e-8b22-be61647de7ad');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ab4e9ffa-6e08-446a-b011-e40723e7155e', 'MDM_ID', 'MDT-155633536', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633536'
			and pid.personid = 'ab4e9ffa-6e08-446a-b011-e40723e7155e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '55de933d-0443-4d96-aeed-7c4e1372a8d5', 'MDM_ID', 'MDT-155641227', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641227'
			and pid.personid = '55de933d-0443-4d96-aeed-7c4e1372a8d5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '312dfe25-7e1f-4c5a-b3df-d9748d14d768', 'MDM_ID', 'MDT-155641225', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641225'
			and pid.personid = '312dfe25-7e1f-4c5a-b3df-d9748d14d768');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fd2f1289-e254-4e3e-aab8-828f539a3f76', 'MDM_ID', 'MDT-155641224', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641224'
			and pid.personid = 'fd2f1289-e254-4e3e-aab8-828f539a3f76');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0dfbeee9-4c13-4aca-8fb5-234f60575e38', 'MDM_ID', 'MDT-125411172', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-125411172'
			and pid.personid = '0dfbeee9-4c13-4aca-8fb5-234f60575e38');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6fa665b4-3620-413b-bb0f-c7d3616f335e', 'MDM_ID', 'MDT-155641223', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641223'
			and pid.personid = '6fa665b4-3620-413b-bb0f-c7d3616f335e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6fd762c4-a246-4edf-9323-4558f9a8127e', 'MDM_ID', 'MDT-127312421', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127312421'
			and pid.personid = '6fd762c4-a246-4edf-9323-4558f9a8127e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7e55eadb-c33b-43fa-9fe3-0565860e972d', 'MDM_ID', 'MDT-155633532', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633532'
			and pid.personid = '7e55eadb-c33b-43fa-9fe3-0565860e972d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '08549b61-cf6e-4b70-9502-79a5acc70a67', 'MDM_ID', 'MDT-155641222', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641222'
			and pid.personid = '08549b61-cf6e-4b70-9502-79a5acc70a67');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9d127334-f5ce-4e24-b8be-27592ed47508', 'MDM_ID', 'MDT-155633531', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633531'
			and pid.personid = '9d127334-f5ce-4e24-b8be-27592ed47508');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bf33e1f8-e2b5-43bb-8c13-366b68645bd7', 'MDM_ID', 'MDT-155633503', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633503'
			and pid.personid = 'bf33e1f8-e2b5-43bb-8c13-366b68645bd7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ed993b30-7cc0-498c-a27f-0936fd0a2fa1', 'MDM_ID', 'MDT-155633530', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633530'
			and pid.personid = 'ed993b30-7cc0-498c-a27f-0936fd0a2fa1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7117ceeb-d001-4c1b-8879-6a15621df1f3', 'MDM_ID', 'MDT-155633502', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633502'
			and pid.personid = '7117ceeb-d001-4c1b-8879-6a15621df1f3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e2097060-6c67-491f-8796-3226152103db', 'MDM_ID', 'MDT-155641204', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641204'
			and pid.personid = 'e2097060-6c67-491f-8796-3226152103db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '71019ef3-bb44-4fbe-96d3-a9606b611d5c', 'MDM_ID', 'MDT-155633529', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633529'
			and pid.personid = '71019ef3-bb44-4fbe-96d3-a9606b611d5c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6c1a2471-2cb7-4a47-8078-32ec3a445d78', 'MDM_ID', 'MDT-153552999', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-153552999'
			and pid.personid = '6c1a2471-2cb7-4a47-8078-32ec3a445d78');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8d87b426-28b5-4941-82c1-3dac6d3ea8dd', 'MDM_ID', 'MDT-155633501', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633501'
			and pid.personid = '8d87b426-28b5-4941-82c1-3dac6d3ea8dd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'dcee5803-55ba-4f48-bf24-a30c9566b0f9', 'MDM_ID', 'MDT-155633528', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633528'
			and pid.personid = 'dcee5803-55ba-4f48-bf24-a30c9566b0f9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e781e98a-7498-4083-8544-c01664457b64', 'MDM_ID', 'MDT-155275253', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155275253'
			and pid.personid = 'e781e98a-7498-4083-8544-c01664457b64');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6da9e6ae-243e-45ad-be04-684b3c2c28cf', 'MDM_ID', 'MDT-155641220', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641220'
			and pid.personid = '6da9e6ae-243e-45ad-be04-684b3c2c28cf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '43cc5094-ec57-44ac-bc17-9a8762679403', 'MDM_ID', 'MDT-155633526', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633526'
			and pid.personid = '43cc5094-ec57-44ac-bc17-9a8762679403');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '32898610-9f90-4869-a69d-cc5bc7a1611a', 'MDM_ID', 'MDT-155641219', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641219'
			and pid.personid = '32898610-9f90-4869-a69d-cc5bc7a1611a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7965945b-531f-4178-922b-823341711b3f', 'MDM_ID', 'MDT-155641218', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641218'
			and pid.personid = '7965945b-531f-4178-922b-823341711b3f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '878bfa3f-6d17-436e-8ec1-0711ac1e43a5', 'MDM_ID', 'MDT-155633525', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633525'
			and pid.personid = '878bfa3f-6d17-436e-8ec1-0711ac1e43a5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '40af0e94-7e4f-42ae-8b28-2b250037076e', 'MDM_ID', 'MDT-155641217', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641217'
			and pid.personid = '40af0e94-7e4f-42ae-8b28-2b250037076e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0f67c0ff-d57e-4ade-8b49-74c4a697137a', 'MDM_ID', 'MDT-155641216', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641216'
			and pid.personid = '0f67c0ff-d57e-4ade-8b49-74c4a697137a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1821c4ea-aa9b-411a-ba13-c48574df3ebf', 'MDM_ID', 'MDT-155641215', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641215'
			and pid.personid = '1821c4ea-aa9b-411a-ba13-c48574df3ebf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '63f3ba38-8535-4783-a6be-09757eb57216', 'MDM_ID', 'MDT-155641214', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641214'
			and pid.personid = '63f3ba38-8535-4783-a6be-09757eb57216');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c2f5ed59-7246-4e90-8f07-ea7ae55eb2a7', 'MDM_ID', 'MDT-155641203', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641203'
			and pid.personid = 'c2f5ed59-7246-4e90-8f07-ea7ae55eb2a7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba6ab7b5-9151-496f-9a6e-0fc03ab4ffcb', 'MDM_ID', 'MDT-155633524', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633524'
			and pid.personid = 'ba6ab7b5-9151-496f-9a6e-0fc03ab4ffcb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '066fe01f-fb47-4699-a443-0f9c7acc59f4', 'MDM_ID', 'MDT-155641213', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641213'
			and pid.personid = '066fe01f-fb47-4699-a443-0f9c7acc59f4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2c1214a9-8312-4411-b710-2982b1bd0bc2', 'MDM_ID', 'MDT-125117434', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-125117434'
			and pid.personid = '2c1214a9-8312-4411-b710-2982b1bd0bc2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1f9f2440-c86c-4768-8273-73d03c5618fa', 'MDM_ID', 'MDT-125123282', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-125123282'
			and pid.personid = '1f9f2440-c86c-4768-8273-73d03c5618fa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '77b3f3a1-eb69-4eed-8ae7-b63e956ae99c', 'MDM_ID', 'MDT-155633500', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633500'
			and pid.personid = '77b3f3a1-eb69-4eed-8ae7-b63e956ae99c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ee99b8cd-2551-45d6-8e9d-2b61911ccadd', 'MDM_ID', 'MDT-155633499', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633499'
			and pid.personid = 'ee99b8cd-2551-45d6-8e9d-2b61911ccadd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba3cd77d-59b4-45fd-ae03-abe12f722e40', 'MDM_ID', 'MDT-155633498', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633498'
			and pid.personid = 'ba3cd77d-59b4-45fd-ae03-abe12f722e40');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b0e12704-0bf1-4d76-9920-c7617d1c1c7b', 'MDM_ID', 'MDT-155633521', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633521'
			and pid.personid = 'b0e12704-0bf1-4d76-9920-c7617d1c1c7b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ac989c50-4a16-416c-9248-8d62b7cd6aa3', 'MDM_ID', 'MDT-155641202', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641202'
			and pid.personid = 'ac989c50-4a16-416c-9248-8d62b7cd6aa3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0c268ff2-9b91-467e-92b4-6a99a99ed1f6', 'MDM_ID', 'MDT-155633519', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633519'
			and pid.personid = '0c268ff2-9b91-467e-92b4-6a99a99ed1f6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '148a0856-8758-4bba-b90e-673b0ba09a9e', 'MDM_ID', 'MDT-155641201', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641201'
			and pid.personid = '148a0856-8758-4bba-b90e-673b0ba09a9e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1366adb9-0328-4fd0-bc8e-30c554fa09c6', 'MDM_ID', 'MDT-155633517', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633517'
			and pid.personid = '1366adb9-0328-4fd0-bc8e-30c554fa09c6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef2e31fe-a2e2-4be0-a8a1-927ca09ed95d', 'MDM_ID', 'MDT-155633516', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633516'
			and pid.personid = 'ef2e31fe-a2e2-4be0-a8a1-927ca09ed95d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3aecb37e-00b6-4670-ac76-5ac7819f75cb', 'MDM_ID', 'MDT-155633515', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633515'
			and pid.personid = '3aecb37e-00b6-4670-ac76-5ac7819f75cb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '13e9ee04-cfdb-4710-918b-e48ce37f7f68', 'MDM_ID', 'MDT-155633514', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633514'
			and pid.personid = '13e9ee04-cfdb-4710-918b-e48ce37f7f68');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '10f8543f-93ca-4900-a1ac-3f340e7bca07', 'MDM_ID', 'MDT-155633513', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633513'
			and pid.personid = '10f8543f-93ca-4900-a1ac-3f340e7bca07');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '856b630a-7b0f-46e3-871f-291b86249439', 'MDM_ID', 'MDT-155641211', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641211'
			and pid.personid = '856b630a-7b0f-46e3-871f-291b86249439');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ac5ea611-67ea-4d56-b94b-30a61c9c8da5', 'MDM_ID', 'MDT-155641210', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641210'
			and pid.personid = 'ac5ea611-67ea-4d56-b94b-30a61c9c8da5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0a8077b6-594e-494c-be28-74f76809452f', 'MDM_ID', 'MDT-155641200', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641200'
			and pid.personid = '0a8077b6-594e-494c-be28-74f76809452f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '93ec61c7-1ba0-4658-9dde-3c9f90522a3d', 'MDM_ID', 'MDT-155641209', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641209'
			and pid.personid = '93ec61c7-1ba0-4658-9dde-3c9f90522a3d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7a1d7140-6b28-49d8-8312-a6d978592c28', 'MDM_ID', 'MDT-155633512', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633512'
			and pid.personid = '7a1d7140-6b28-49d8-8312-a6d978592c28');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '657b96d8-d12f-4356-9a5b-3d02b50c4b1b', 'MDM_ID', 'MDT-155633511', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633511'
			and pid.personid = '657b96d8-d12f-4356-9a5b-3d02b50c4b1b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c917efac-1d2d-421c-a024-ffc1aa0fcee5', 'MDM_ID', 'MDT-155633510', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633510'
			and pid.personid = 'c917efac-1d2d-421c-a024-ffc1aa0fcee5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f3198755-30d8-4dc9-b00e-17338c3b0088', 'MDM_ID', 'MDT-155633509', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633509'
			and pid.personid = 'f3198755-30d8-4dc9-b00e-17338c3b0088');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '90915840-fcc1-47f8-8d6d-cc498127188b', 'MDM_ID', 'MDT-155641199', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641199'
			and pid.personid = '90915840-fcc1-47f8-8d6d-cc498127188b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd50e9f85-cfb3-4e48-a7a7-c3b5961f98df', 'MDM_ID', 'MDT-155633508', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633508'
			and pid.personid = 'd50e9f85-cfb3-4e48-a7a7-c3b5961f98df');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b71be5a8-cba1-4f85-86f8-d0c3761912d0', 'MDM_ID', 'MDT-155641198', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641198'
			and pid.personid = 'b71be5a8-cba1-4f85-86f8-d0c3761912d0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '83bafe62-84cb-4762-8b46-3a73c0a96df0', 'MDM_ID', 'MDT-155633497', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633497'
			and pid.personid = '83bafe62-84cb-4762-8b46-3a73c0a96df0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e2fb2618-8a86-49ab-914d-2dfb9be6d687', 'MDM_ID', 'MDT-155633507', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633507'
			and pid.personid = 'e2fb2618-8a86-49ab-914d-2dfb9be6d687');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '266338e4-422c-4b42-b8b6-f8fa054aeaf3', 'MDM_ID', 'MDT-155641197', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641197'
			and pid.personid = '266338e4-422c-4b42-b8b6-f8fa054aeaf3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2ad3b507-d4f3-4846-902f-c6ba06ee11a0', 'MDM_ID', 'MDT-155641166', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641166'
			and pid.personid = '2ad3b507-d4f3-4846-902f-c6ba06ee11a0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fd10c3b0-7d38-4666-9a8f-3ad5e37bf86b', 'MDM_ID', 'MDT-155633496', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633496'
			and pid.personid = 'fd10c3b0-7d38-4666-9a8f-3ad5e37bf86b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '86363bc8-9383-4e4c-bb5d-170d7d57b360', 'MDM_ID', 'MDT-155633495', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633495'
			and pid.personid = '86363bc8-9383-4e4c-bb5d-170d7d57b360');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '83526639-5887-4520-9967-d3ee4f970253', 'MDM_ID', 'MDT-155633465', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633465'
			and pid.personid = '83526639-5887-4520-9967-d3ee4f970253');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '00b1cd83-b51d-4213-a5b8-48a9895d8d78', 'MDM_ID', 'MDT-155641196', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641196'
			and pid.personid = '00b1cd83-b51d-4213-a5b8-48a9895d8d78');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '16038b6c-6e7c-416c-b441-d434f2b52645', 'MDM_ID', 'MDT-155633463', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633463'
			and pid.personid = '16038b6c-6e7c-416c-b441-d434f2b52645');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '89e5a69f-568f-48bd-a151-3ffc4cfd702b', 'MDM_ID', 'MDT-155641159', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641159'
			and pid.personid = '89e5a69f-568f-48bd-a151-3ffc4cfd702b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f85225c2-aa55-4e11-8523-d0b7ffceb39c', 'MDM_ID', 'MDT-125281302', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-125281302'
			and pid.personid = 'f85225c2-aa55-4e11-8523-d0b7ffceb39c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9381547c-4848-48f0-b865-756a84fcb21d', 'MDM_ID', 'MDT-155633461', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633461'
			and pid.personid = '9381547c-4848-48f0-b865-756a84fcb21d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bb0301e0-6ba1-4f30-9bc7-4dfb77892b94', 'MDM_ID', 'MDT-155633494', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633494'
			and pid.personid = 'bb0301e0-6ba1-4f30-9bc7-4dfb77892b94');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '68e75178-7e95-4c3e-a7a5-b741f8df4679', 'MDM_ID', 'MDT-126661193', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-126661193'
			and pid.personid = '68e75178-7e95-4c3e-a7a5-b741f8df4679');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '052a83d4-3483-40a3-9ec8-d250e936a6e7', 'MDM_ID', 'MDT-155633491', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633491'
			and pid.personid = '052a83d4-3483-40a3-9ec8-d250e936a6e7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '85cbc042-7a23-49a3-a024-fee06910b790', 'MDM_ID', 'MDT-155633489', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633489'
			and pid.personid = '85cbc042-7a23-49a3-a024-fee06910b790');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2d36a8b9-2876-43a3-898e-1cbbdc7fe58c', 'MDM_ID', 'MDT-155641194', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641194'
			and pid.personid = '2d36a8b9-2876-43a3-898e-1cbbdc7fe58c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef6e7522-1ed9-44cc-9dd5-5f9641c56792', 'MDM_ID', 'MDT-155641193', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641193'
			and pid.personid = 'ef6e7522-1ed9-44cc-9dd5-5f9641c56792');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e0f5ec2e-52ef-4ab0-9459-407521d7be38', 'MDM_ID', 'MDT-155641155', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641155'
			and pid.personid = 'e0f5ec2e-52ef-4ab0-9459-407521d7be38');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '51ae9e00-7130-4368-bf5c-8221914fd447', 'MDM_ID', 'MDT-155633488', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633488'
			and pid.personid = '51ae9e00-7130-4368-bf5c-8221914fd447');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'afbc405d-b1ca-4737-bd5d-365c1d1ec645', 'MDM_ID', 'MDT-155641192', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641192'
			and pid.personid = 'afbc405d-b1ca-4737-bd5d-365c1d1ec645');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0a685224-1737-49d9-81c8-d08009d37b8e', 'MDM_ID', 'MDT-155633487', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633487'
			and pid.personid = '0a685224-1737-49d9-81c8-d08009d37b8e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4c69b0dc-4812-467e-879e-c2a18c637eea', 'MDM_ID', 'MDT-155633486', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633486'
			and pid.personid = '4c69b0dc-4812-467e-879e-c2a18c637eea');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a1577e5f-0486-481f-957f-9ee554507a1d', 'MDM_ID', 'MDT-155641191', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641191'
			and pid.personid = 'a1577e5f-0486-481f-957f-9ee554507a1d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'dc16f8cd-bdf6-45f3-809e-83d90f9a8279', 'MDM_ID', 'MDT-155633485', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633485'
			and pid.personid = 'dc16f8cd-bdf6-45f3-809e-83d90f9a8279');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '25ff6242-a07e-4cf6-9dce-08d2a1f15693', 'MDM_ID', 'MDT-155641190', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641190'
			and pid.personid = '25ff6242-a07e-4cf6-9dce-08d2a1f15693');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7be6a600-387e-4cf9-b8e9-330871126c95', 'MDM_ID', 'MDT-155641189', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641189'
			and pid.personid = '7be6a600-387e-4cf9-b8e9-330871126c95');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5556bd79-2845-42e4-b5ac-804a889b4cf1', 'MDM_ID', 'MDT-155641188', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641188'
			and pid.personid = '5556bd79-2845-42e4-b5ac-804a889b4cf1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '02021a78-3cba-435e-ad08-d52c77f0dc95', 'MDM_ID', 'MDT-155633452', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633452'
			and pid.personid = '02021a78-3cba-435e-ad08-d52c77f0dc95');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a39cd26d-2d1e-4c21-a783-8639c7e7c34a', 'MDM_ID', 'MDT-155641187', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641187'
			and pid.personid = 'a39cd26d-2d1e-4c21-a783-8639c7e7c34a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bc68bc04-5a52-4097-884e-1fcb1dc08ace', 'MDM_ID', 'MDT-155633484', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633484'
			and pid.personid = 'bc68bc04-5a52-4097-884e-1fcb1dc08ace');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0c01d70d-b5d3-4ff2-bd94-dda02756ad7f', 'MDM_ID', 'MDT-155641186', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641186'
			and pid.personid = '0c01d70d-b5d3-4ff2-bd94-dda02756ad7f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '22df1714-7d7b-4353-a9f2-87966d27cd6e', 'MDM_ID', 'MDT-155641150', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641150'
			and pid.personid = '22df1714-7d7b-4353-a9f2-87966d27cd6e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6b12b030-9851-4ca3-984e-f18809975fc9', 'MDM_ID', 'MDT-155633483', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633483'
			and pid.personid = '6b12b030-9851-4ca3-984e-f18809975fc9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '849292ad-1cad-4b65-a062-f0aaea1bba50', 'MDM_ID', 'MDT-155633482', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633482'
			and pid.personid = '849292ad-1cad-4b65-a062-f0aaea1bba50');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ee10ba0b-ca89-4b09-a011-7c8793d7d395', 'MDM_ID', 'MDT-155439229', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155439229'
			and pid.personid = 'ee10ba0b-ca89-4b09-a011-7c8793d7d395');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fcc9911b-27cd-44a0-ad4a-a890ced1dbbc', 'MDM_ID', 'MDT-155633451', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633451'
			and pid.personid = 'fcc9911b-27cd-44a0-ad4a-a890ced1dbbc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8558da89-075f-4e83-85a4-e1e4a69ffc9d', 'MDM_ID', 'MDT-155641146', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641146'
			and pid.personid = '8558da89-075f-4e83-85a4-e1e4a69ffc9d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '28af24da-5208-40cd-839a-c75549ab71c1', 'MDM_ID', 'MDT-155641184', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641184'
			and pid.personid = '28af24da-5208-40cd-839a-c75549ab71c1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'fdac46cb-4b36-4d59-95cb-c067274438ef', 'MDM_ID', 'MDT-155641183', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641183'
			and pid.personid = 'fdac46cb-4b36-4d59-95cb-c067274438ef');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '12ebdc3f-77bb-483b-93d0-25d48076be59', 'MDM_ID', 'MDT-155633481', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633481'
			and pid.personid = '12ebdc3f-77bb-483b-93d0-25d48076be59');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '6eeaa51d-73d1-4ae7-a32f-46e87ce7806c', 'MDM_ID', 'MDT-155641182', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641182'
			and pid.personid = '6eeaa51d-73d1-4ae7-a32f-46e87ce7806c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '143abefe-01ca-4277-b0b1-de4a494765b6', 'MDM_ID', 'MDT-127748661', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127748661'
			and pid.personid = '143abefe-01ca-4277-b0b1-de4a494765b6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba16efa6-bcba-40d5-b490-0da295756ba6', 'MDM_ID', 'MDT-155633479', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633479'
			and pid.personid = 'ba16efa6-bcba-40d5-b490-0da295756ba6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '25f6dd19-e7b2-451a-a307-4fea7afbd0a0', 'MDM_ID', 'MDT-127714627', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127714627'
			and pid.personid = '25f6dd19-e7b2-451a-a307-4fea7afbd0a0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0f273db1-d86f-4a5c-a57e-29a8b0c7b735', 'MDM_ID', 'MDT-155641181', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641181'
			and pid.personid = '0f273db1-d86f-4a5c-a57e-29a8b0c7b735');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'dd252436-d538-437d-943a-5c4ac33df4cc', 'MDM_ID', 'MDT-155633438', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633438'
			and pid.personid = 'dd252436-d538-437d-943a-5c4ac33df4cc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f4287a9e-cf37-4e93-9ab3-ba347fc05822', 'MDM_ID', 'MDT-155633477', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633477'
			and pid.personid = 'f4287a9e-cf37-4e93-9ab3-ba347fc05822');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c5408454-d559-4efa-9394-4b832d3cafbc', 'MDM_ID', 'MDT-155641138', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641138'
			and pid.personid = 'c5408454-d559-4efa-9394-4b832d3cafbc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3efcafcd-74ce-4bac-9bc7-7d04ae00ddc9', 'MDM_ID', 'MDT-155633476', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633476'
			and pid.personid = '3efcafcd-74ce-4bac-9bc7-7d04ae00ddc9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4f6ee167-96a8-4c72-a935-814afdcb163a', 'MDM_ID', 'MDT-155641179', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641179'
			and pid.personid = '4f6ee167-96a8-4c72-a935-814afdcb163a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9ad1f6f8-5443-428a-a94d-84bb1809e6c3', 'MDM_ID', 'MDT-155641178', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641178'
			and pid.personid = '9ad1f6f8-5443-428a-a94d-84bb1809e6c3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3291bc29-14e2-4573-92f9-5b0c82a3881c', 'MDM_ID', 'MDT-127619331', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127619331'
			and pid.personid = '3291bc29-14e2-4573-92f9-5b0c82a3881c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ef2230b3-8760-48da-8c66-f5c021f8a61c', 'MDM_ID', 'MDT-155641176', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641176'
			and pid.personid = 'ef2230b3-8760-48da-8c66-f5c021f8a61c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '36ca8a01-85ad-4335-a7fd-29c586a99616', 'MDM_ID', 'MDT-155633475', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633475'
			and pid.personid = '36ca8a01-85ad-4335-a7fd-29c586a99616');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'be358f06-fddd-4fd3-93d2-2e5691424908', 'MDM_ID', 'MDT-155641175', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641175'
			and pid.personid = 'be358f06-fddd-4fd3-93d2-2e5691424908');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f319e671-394c-4ca4-833d-b11c0f53c446', 'MDM_ID', 'MDT-155641174', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641174'
			and pid.personid = 'f319e671-394c-4ca4-833d-b11c0f53c446');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8ce394eb-279b-44a5-83c1-7863e42f887f', 'MDM_ID', 'MDT-155641173', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641173'
			and pid.personid = '8ce394eb-279b-44a5-83c1-7863e42f887f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e8b520d3-dcc4-49ac-84d8-b6a0ada8c7fc', 'MDM_ID', 'MDT-155641172', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641172'
			and pid.personid = 'e8b520d3-dcc4-49ac-84d8-b6a0ada8c7fc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8d0b42b6-e504-4798-a118-c72d67898ad8', 'MDM_ID', 'MDT-155633474', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633474'
			and pid.personid = '8d0b42b6-e504-4798-a118-c72d67898ad8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5648e839-61d3-41a7-a75e-e4bec24cf4ba', 'MDM_ID', 'MDT-155633473', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633473'
			and pid.personid = '5648e839-61d3-41a7-a75e-e4bec24cf4ba');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '77796500-270c-4b7f-bdae-6ffeb95a1ac2', 'MDM_ID', 'MDT-155633472', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633472'
			and pid.personid = '77796500-270c-4b7f-bdae-6ffeb95a1ac2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '12f61bcb-a7d2-4769-9737-d0920cc229d4', 'MDM_ID', 'MDT-155641171', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641171'
			and pid.personid = '12f61bcb-a7d2-4769-9737-d0920cc229d4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c067c417-74c4-4b0c-8892-9688a0fbe3d8', 'MDM_ID', 'MDT-155641170', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641170'
			and pid.personid = 'c067c417-74c4-4b0c-8892-9688a0fbe3d8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '743af9b6-7660-4303-931e-b5ce8d8e6430', 'MDM_ID', 'MDT-155641169', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641169'
			and pid.personid = '743af9b6-7660-4303-931e-b5ce8d8e6430');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ea88856a-75dc-481d-800e-75d522e99b97', 'MDM_ID', 'MDT-155641168', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641168'
			and pid.personid = 'ea88856a-75dc-481d-800e-75d522e99b97');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '42f203b0-f3a6-49b8-b344-0b6f263ae284', 'MDM_ID', 'MDT-155641167', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641167'
			and pid.personid = '42f203b0-f3a6-49b8-b344-0b6f263ae284');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9313d5e6-19db-4be9-aed1-fd5ce83a729f', 'MDM_ID', 'MDT-155633470', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633470'
			and pid.personid = '9313d5e6-19db-4be9-aed1-fd5ce83a729f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3eea097b-a3a8-4243-b2bf-2d2225208638', 'MDM_ID', 'MDT-155641165', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641165'
			and pid.personid = '3eea097b-a3a8-4243-b2bf-2d2225208638');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4b822c8e-bf69-45e5-b37f-5e9754e31d44', 'MDM_ID', 'MDT-155641164', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641164'
			and pid.personid = '4b822c8e-bf69-45e5-b37f-5e9754e31d44');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4cafbb49-84dd-4f1d-81a7-e1b01d0ef855', 'MDM_ID', 'MDT-155641163', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641163'
			and pid.personid = '4cafbb49-84dd-4f1d-81a7-e1b01d0ef855');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9adee1b9-c489-4972-8f89-bc36cc7aa314', 'MDM_ID', 'MDT-155641162', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641162'
			and pid.personid = '9adee1b9-c489-4972-8f89-bc36cc7aa314');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '342e3212-42d2-46c6-9ec1-1842c5a539a0', 'MDM_ID', 'MDT-155633469', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633469'
			and pid.personid = '342e3212-42d2-46c6-9ec1-1842c5a539a0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'caebd0ed-c265-4333-b878-b129621db3df', 'MDM_ID', 'MDT-125504964', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-125504964'
			and pid.personid = 'caebd0ed-c265-4333-b878-b129621db3df');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7dc56987-5872-48a7-97f8-1f59bf4322a0', 'MDM_ID', 'MDT-155633467', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633467'
			and pid.personid = '7dc56987-5872-48a7-97f8-1f59bf4322a0');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3ebce46a-2495-4268-8fd6-b1c0b59b8b0b', 'MDM_ID', 'MDT-127276022', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127276022'
			and pid.personid = '3ebce46a-2495-4268-8fd6-b1c0b59b8b0b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3ef144ce-271c-4c78-9cdb-7d929de20e11', 'MDM_ID', 'MDT-155641160', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641160'
			and pid.personid = '3ef144ce-271c-4c78-9cdb-7d929de20e11');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd6b3c6c2-d09b-4139-9581-0f0387d93220', 'MDM_ID', 'MDT-155633464', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633464'
			and pid.personid = 'd6b3c6c2-d09b-4139-9581-0f0387d93220');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b8b3c0e2-d1a4-425b-998c-3ee645356ad8', 'MDM_ID', 'MDT-155641136', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641136'
			and pid.personid = 'b8b3c0e2-d1a4-425b-998c-3ee645356ad8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2a9672aa-91f9-4d63-9d94-0b424fbc5030', 'MDM_ID', 'MDT-155641135', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641135'
			and pid.personid = '2a9672aa-91f9-4d63-9d94-0b424fbc5030');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4d26726f-cf15-41d2-876a-d45787adc33d', 'MDM_ID', 'MDT-155633462', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633462'
			and pid.personid = '4d26726f-cf15-41d2-876a-d45787adc33d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ddceaaa6-7a1e-4a3a-b966-384725ebe898', 'MDM_ID', 'MDT-155641158', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641158'
			and pid.personid = 'ddceaaa6-7a1e-4a3a-b966-384725ebe898');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bb77873e-d25a-4066-a711-41c3579f3277', 'MDM_ID', 'MDT-155641134', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641134'
			and pid.personid = 'bb77873e-d25a-4066-a711-41c3579f3277');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ba22787d-ef65-4c7f-8803-83808e2c04c3', 'MDM_ID', 'MDT-155493143', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155493143'
			and pid.personid = 'ba22787d-ef65-4c7f-8803-83808e2c04c3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1fcb2dfa-9603-4e5b-8ab8-61dfecf7a556', 'MDM_ID', 'MDT-155633460', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633460'
			and pid.personid = '1fcb2dfa-9603-4e5b-8ab8-61dfecf7a556');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '001caaa6-f804-4c3d-a7ac-d1a5c0008af3', 'MDM_ID', 'MDT-155641157', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641157'
			and pid.personid = '001caaa6-f804-4c3d-a7ac-d1a5c0008af3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '84da6ee7-4f22-4f59-a463-61b50d44f452', 'MDM_ID', 'MDT-155641156', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641156'
			and pid.personid = '84da6ee7-4f22-4f59-a463-61b50d44f452');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9fbaa073-f457-4aeb-8289-d2ee82ae5d70', 'MDM_ID', 'MDT-155633459', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633459'
			and pid.personid = '9fbaa073-f457-4aeb-8289-d2ee82ae5d70');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c164f2ae-b1c0-4414-96a4-d51d9a53313b', 'MDM_ID', 'MDT-155641133', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641133'
			and pid.personid = 'c164f2ae-b1c0-4414-96a4-d51d9a53313b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'aa5a1d02-868e-4250-9d91-73155b3d8fee', 'MDM_ID', 'MDT-155633458', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633458'
			and pid.personid = 'aa5a1d02-868e-4250-9d91-73155b3d8fee');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f6a23b58-3404-49fe-a304-988ec7a87000', 'MDM_ID', 'MDT-155633435', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633435'
			and pid.personid = 'f6a23b58-3404-49fe-a304-988ec7a87000');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2c1853fd-5f82-4064-8afb-caef8e529151', 'MDM_ID', 'MDT-124422203', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-124422203'
			and pid.personid = '2c1853fd-5f82-4064-8afb-caef8e529151');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '931ba8e4-106d-4335-995c-cde35d66b48a', 'MDM_ID', 'MDT-155633457', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633457'
			and pid.personid = '931ba8e4-106d-4335-995c-cde35d66b48a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '685cdf80-7e27-46b9-a3b8-29f6791a36f7', 'MDM_ID', 'MDT-155633455', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633455'
			and pid.personid = '685cdf80-7e27-46b9-a3b8-29f6791a36f7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3626427f-1e57-4d7a-adf7-f46e509df5ac', 'MDM_ID', 'MDT-155633454', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633454'
			and pid.personid = '3626427f-1e57-4d7a-adf7-f46e509df5ac');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'df9af9f6-94fc-4389-8209-2730dad37146', 'MDM_ID', 'MDT-155633453', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633453'
			and pid.personid = 'df9af9f6-94fc-4389-8209-2730dad37146');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'de01a3a9-3c1e-4c1c-a1e4-e35ad3d685c8', 'MDM_ID', 'MDT-128258727', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-128258727'
			and pid.personid = 'de01a3a9-3c1e-4c1c-a1e4-e35ad3d685c8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c147e016-4fba-4e67-b84f-82083c2fa4aa', 'MDM_ID', 'MDT-155641152', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641152'
			and pid.personid = 'c147e016-4fba-4e67-b84f-82083c2fa4aa');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '11c500b7-3a49-41d1-a6cc-85913ccce518', 'MDM_ID', 'MDT-155641151', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641151'
			and pid.personid = '11c500b7-3a49-41d1-a6cc-85913ccce518');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'eb7e606f-5b2b-498e-9b66-f0d5e866bf8e', 'MDM_ID', 'MDT-155633434', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633434'
			and pid.personid = 'eb7e606f-5b2b-498e-9b66-f0d5e866bf8e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e4ef0a93-f988-47dd-ac91-3a61b5e1457d', 'MDM_ID', 'MDT-155641149', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641149'
			and pid.personid = 'e4ef0a93-f988-47dd-ac91-3a61b5e1457d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f32fb6c1-2a7d-4793-bf9f-89740638445f', 'MDM_ID', 'MDT-153602436', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-153602436'
			and pid.personid = 'f32fb6c1-2a7d-4793-bf9f-89740638445f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '97a29e77-669c-43fb-b151-4173a80880e6', 'MDM_ID', 'MDT-155641148', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641148'
			and pid.personid = '97a29e77-669c-43fb-b151-4173a80880e6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd2bffd69-fe7b-42c8-bf72-5f7fd0ffc13c', 'MDM_ID', 'MDT-155641147', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641147'
			and pid.personid = 'd2bffd69-fe7b-42c8-bf72-5f7fd0ffc13c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9933be42-7d5b-4c03-8cfa-a3607c2337f9', 'MDM_ID', 'MDT-155633449', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633449'
			and pid.personid = '9933be42-7d5b-4c03-8cfa-a3607c2337f9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '33530c54-fdff-4633-bf43-c2b70b2d619b', 'MDM_ID', 'MDT-155633448', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633448'
			and pid.personid = '33530c54-fdff-4633-bf43-c2b70b2d619b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '268e1fec-850b-4493-94f1-b79f48087c44', 'MDM_ID', 'MDT-155633447', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633447'
			and pid.personid = '268e1fec-850b-4493-94f1-b79f48087c44');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0a8c5c85-b6ab-403d-bfe0-3f15cc843b65', 'MDM_ID', 'MDT-155633446', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633446'
			and pid.personid = '0a8c5c85-b6ab-403d-bfe0-3f15cc843b65');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3fc7d8d4-681f-4809-8e5c-33dbcc3c3b42', 'MDM_ID', 'MDT-124948209', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-124948209'
			and pid.personid = '3fc7d8d4-681f-4809-8e5c-33dbcc3c3b42');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c18192fd-1d16-464c-ac5c-019864493abd', 'MDM_ID', 'MDT-155641132', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641132'
			and pid.personid = 'c18192fd-1d16-464c-ac5c-019864493abd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f44e28bc-a3ad-469f-9024-296947c866da', 'MDM_ID', 'MDT-155641145', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641145'
			and pid.personid = 'f44e28bc-a3ad-469f-9024-296947c866da');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c3ca103b-635c-447b-abe4-db10d16b403e', 'MDM_ID', 'MDT-155633444', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633444'
			and pid.personid = 'c3ca103b-635c-447b-abe4-db10d16b403e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '96005552-031b-402f-916a-4812d93cb924', 'MDM_ID', 'MDT-155641131', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641131'
			and pid.personid = '96005552-031b-402f-916a-4812d93cb924');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'edc0c5f3-8f5e-4c05-8588-c0cfe1180ffe', 'MDM_ID', 'MDT-155633443', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633443'
			and pid.personid = 'edc0c5f3-8f5e-4c05-8588-c0cfe1180ffe');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9dcbdcf7-3ae3-40cc-80e5-70dc0a1ffa93', 'MDM_ID', 'MDT-155641144', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641144'
			and pid.personid = '9dcbdcf7-3ae3-40cc-80e5-70dc0a1ffa93');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f2aedaea-f4bf-46f9-9c31-d28ebf44950b', 'MDM_ID', 'MDT-155633442', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633442'
			and pid.personid = 'f2aedaea-f4bf-46f9-9c31-d28ebf44950b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a7c53b0b-7103-4449-a04a-b7538c66314a', 'MDM_ID', 'MDT-155633441', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633441'
			and pid.personid = 'a7c53b0b-7103-4449-a04a-b7538c66314a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '312df99b-736f-4d22-8db1-50c21690580a', 'MDM_ID', 'MDT-155633433', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633433'
			and pid.personid = '312df99b-736f-4d22-8db1-50c21690580a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '62775efe-0163-44e3-88ae-a03a11420d26', 'MDM_ID', 'MDT-127057730', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127057730'
			and pid.personid = '62775efe-0163-44e3-88ae-a03a11420d26');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '95da2800-7c36-410c-b66d-82376676c4da', 'MDM_ID', 'MDT-155641143', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641143'
			and pid.personid = '95da2800-7c36-410c-b66d-82376676c4da');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a75b7fc3-0abf-4f6c-91eb-31eb76c00a6e', 'MDM_ID', 'MDT-155641142', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641142'
			and pid.personid = 'a75b7fc3-0abf-4f6c-91eb-31eb76c00a6e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '738471ae-a8a3-4273-85ba-a5884f0f02db', 'MDM_ID', 'MDT-155633437', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633437'
			and pid.personid = '738471ae-a8a3-4273-85ba-a5884f0f02db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4dd8f636-959d-48cc-b5bd-3348f36da879', 'MDM_ID', 'MDT-155641141', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641141'
			and pid.personid = '4dd8f636-959d-48cc-b5bd-3348f36da879');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '307d9e6f-13e8-4c06-86f7-62874e6d9737', 'MDM_ID', 'MDT-155641140', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641140'
			and pid.personid = '307d9e6f-13e8-4c06-86f7-62874e6d9737');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '78f00bde-1c22-4f4a-a0fe-04b13bba804d', 'MDM_ID', 'MDT-155641139', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641139'
			and pid.personid = '78f00bde-1c22-4f4a-a0fe-04b13bba804d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '56f9f7f4-a55a-411b-bb68-b7b45791436c', 'MDM_ID', 'MDT-155633436', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633436'
			and pid.personid = '56f9f7f4-a55a-411b-bb68-b7b45791436c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2178bccb-6b65-42e1-9f9b-2e1f9b86be61', 'MDM_ID', 'MDT-155641137', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641137'
			and pid.personid = '2178bccb-6b65-42e1-9f9b-2e1f9b86be61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'feca2a9d-86eb-4390-b66a-e714ce068b34', 'MDM_ID', 'MDT-155641130', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641130'
			and pid.personid = 'feca2a9d-86eb-4390-b66a-e714ce068b34');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd02a53f5-bab3-48a4-bc4c-7ee29ac18ead', 'MDM_ID', 'MDT-129097882', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-129097882'
			and pid.personid = 'd02a53f5-bab3-48a4-bc4c-7ee29ac18ead');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '11eafce9-d2ee-4558-862d-d6739b2cb9b7', 'MDM_ID', 'MDT-155633432', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633432'
			and pid.personid = '11eafce9-d2ee-4558-862d-d6739b2cb9b7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1800d78f-6de0-4a07-b854-a23a6162d9da', 'MDM_ID', 'MDT-123705420', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-123705420'
			and pid.personid = '1800d78f-6de0-4a07-b854-a23a6162d9da');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3ff7e31f-260c-4800-9156-1e1a74e64f00', 'MDM_ID', 'MDT-155633430', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633430'
			and pid.personid = '3ff7e31f-260c-4800-9156-1e1a74e64f00');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '20999e7f-f4a0-4efa-9edd-6b51ebc1f70b', 'MDM_ID', 'MDT-133871374', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-133871374'
			and pid.personid = '20999e7f-f4a0-4efa-9edd-6b51ebc1f70b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '91c36b2d-12db-434a-abaf-e8ef2789495b', 'MDM_ID', 'MDT-155641128', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641128'
			and pid.personid = '91c36b2d-12db-434a-abaf-e8ef2789495b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '859acbec-0b63-4ece-bce8-4c9151260ca4', 'MDM_ID', 'MDT-155195547', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155195547'
			and pid.personid = '859acbec-0b63-4ece-bce8-4c9151260ca4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3da63e87-d09e-452b-812b-7efffcfd9baf', 'MDM_ID', 'MDT-155641106', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641106'
			and pid.personid = '3da63e87-d09e-452b-812b-7efffcfd9baf');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '41af6a08-d9b5-43f4-b68d-555060c7262d', 'MDM_ID', 'MDT-155633427', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633427'
			and pid.personid = '41af6a08-d9b5-43f4-b68d-555060c7262d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '418b4525-0a78-4387-94ab-2248768887e2', 'MDM_ID', 'MDT-127176501', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127176501'
			and pid.personid = '418b4525-0a78-4387-94ab-2248768887e2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '24abfc42-118c-4cec-81b9-4ac848b4597e', 'MDM_ID', 'MDT-155641126', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641126'
			and pid.personid = '24abfc42-118c-4cec-81b9-4ac848b4597e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd7714c10-31ac-4388-9b39-d33789d62808', 'MDM_ID', 'MDT-155633426', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633426'
			and pid.personid = 'd7714c10-31ac-4388-9b39-d33789d62808');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2727d0ea-5642-4d4d-9f16-757e8bb3ef76', 'MDM_ID', 'MDT-155633425', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633425'
			and pid.personid = '2727d0ea-5642-4d4d-9f16-757e8bb3ef76');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c41712f5-76dc-45a7-b244-5f7a1aa4b277', 'MDM_ID', 'MDT-155633424', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633424'
			and pid.personid = 'c41712f5-76dc-45a7-b244-5f7a1aa4b277');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '92adf656-aa13-48b5-9a8b-3d4681757345', 'MDM_ID', 'MDT-155633423', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633423'
			and pid.personid = '92adf656-aa13-48b5-9a8b-3d4681757345');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ce0a3934-ad5b-4327-addf-8faa2b18cb46', 'MDM_ID', 'MDT-155633422', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633422'
			and pid.personid = 'ce0a3934-ad5b-4327-addf-8faa2b18cb46');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '177cd5f2-2bac-4925-8936-805d7fd89346', 'MDM_ID', 'MDT-155641094', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641094'
			and pid.personid = '177cd5f2-2bac-4925-8936-805d7fd89346');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '336556aa-e737-4135-b062-15f7634843e2', 'MDM_ID', 'MDT-155633421', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633421'
			and pid.personid = '336556aa-e737-4135-b062-15f7634843e2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '41c6275c-817d-4778-b840-5490b0eee035', 'MDM_ID', 'MDT-155641125', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641125'
			and pid.personid = '41c6275c-817d-4778-b840-5490b0eee035');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f33814b2-dce4-4a66-ac76-621e358b0960', 'MDM_ID', 'MDT-155641124', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641124'
			and pid.personid = 'f33814b2-dce4-4a66-ac76-621e358b0960');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '19e1c27d-10d0-41f7-8183-7fb4748e4665', 'MDM_ID', 'MDT-124191596', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-124191596'
			and pid.personid = '19e1c27d-10d0-41f7-8183-7fb4748e4665');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '46fa5889-2db8-41c6-9e37-8d0640f67b3d', 'MDM_ID', 'MDT-155641123', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641123'
			and pid.personid = '46fa5889-2db8-41c6-9e37-8d0640f67b3d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7c555152-8772-4487-a0d8-f33bbc446de5', 'MDM_ID', 'MDT-155641122', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641122'
			and pid.personid = '7c555152-8772-4487-a0d8-f33bbc446de5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f9240c81-b783-4b73-b9e5-adb9338f181b', 'MDM_ID', 'MDT-125572751', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-125572751'
			and pid.personid = 'f9240c81-b783-4b73-b9e5-adb9338f181b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3b0f33fe-8a84-47c2-bfb4-e185c6701251', 'MDM_ID', 'MDT-155641091', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641091'
			and pid.personid = '3b0f33fe-8a84-47c2-bfb4-e185c6701251');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1ee193d3-6852-4731-8faf-2754adcda6bd', 'MDM_ID', 'MDT-155633419', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633419'
			and pid.personid = '1ee193d3-6852-4731-8faf-2754adcda6bd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '00153f38-ac8b-4c35-b3a6-6f9c3318564c', 'MDM_ID', 'MDT-155633418', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633418'
			and pid.personid = '00153f38-ac8b-4c35-b3a6-6f9c3318564c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c9a0ea46-c810-48e0-a38a-65e4d71ac5e3', 'MDM_ID', 'MDT-155641120', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641120'
			and pid.personid = 'c9a0ea46-c810-48e0-a38a-65e4d71ac5e3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '43f65065-f9b4-43e2-afcc-31c6409a4a1a', 'MDM_ID', 'MDT-155641119', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641119'
			and pid.personid = '43f65065-f9b4-43e2-afcc-31c6409a4a1a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '237119d2-c01e-4ca2-b7e4-b27d142151cc', 'MDM_ID', 'MDT-155641118', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641118'
			and pid.personid = '237119d2-c01e-4ca2-b7e4-b27d142151cc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd9b5da60-cc4b-4b61-a90b-7cf681393b0c', 'MDM_ID', 'MDT-155633417', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633417'
			and pid.personid = 'd9b5da60-cc4b-4b61-a90b-7cf681393b0c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd227bfcb-3226-4187-9ff2-fc4dc8a5b0e4', 'MDM_ID', 'MDT-128541418', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-128541418'
			and pid.personid = 'd227bfcb-3226-4187-9ff2-fc4dc8a5b0e4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ffb61b68-381e-4fe2-8e47-764e9351af91', 'MDM_ID', 'MDT-155641117', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641117'
			and pid.personid = 'ffb61b68-381e-4fe2-8e47-764e9351af91');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e55a0e3e-b80e-4c8c-9eea-671518cf6e82', 'MDM_ID', 'MDT-155633415', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633415'
			and pid.personid = 'e55a0e3e-b80e-4c8c-9eea-671518cf6e82');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cd192c9b-3722-4209-a70e-84aeb12d93dd', 'MDM_ID', 'MDT-155641116', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641116'
			and pid.personid = 'cd192c9b-3722-4209-a70e-84aeb12d93dd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7a3f9c62-45fc-4402-b763-f5b831a2b726', 'MDM_ID', 'MDT-155641089', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641089'
			and pid.personid = '7a3f9c62-45fc-4402-b763-f5b831a2b726');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7f0eaba4-3056-4496-b6c7-0922c71b98c2', 'MDM_ID', 'MDT-155641088', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641088'
			and pid.personid = '7f0eaba4-3056-4496-b6c7-0922c71b98c2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '79335fc5-c261-4304-8923-4f099ad7a661', 'MDM_ID', 'MDT-155503910', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155503910'
			and pid.personid = '79335fc5-c261-4304-8923-4f099ad7a661');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '37311d89-7c4d-4830-a0c3-6ede5f2f8dc6', 'MDM_ID', 'MDT-155633387', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633387'
			and pid.personid = '37311d89-7c4d-4830-a0c3-6ede5f2f8dc6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ca2dc27c-8a92-4d46-b26b-4f910f73b5d7', 'MDM_ID', 'MDT-155633414', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633414'
			and pid.personid = 'ca2dc27c-8a92-4d46-b26b-4f910f73b5d7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2853b7d7-59ac-4a2f-b226-4cf31e7820c2', 'MDM_ID', 'MDT-155633413', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633413'
			and pid.personid = '2853b7d7-59ac-4a2f-b226-4cf31e7820c2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '26179255-906c-47d5-9ec7-94d170e4afc3', 'MDM_ID', 'MDT-155633385', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633385'
			and pid.personid = '26179255-906c-47d5-9ec7-94d170e4afc3');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd08450ef-627a-4e5d-bdce-0b0f1089563f', 'MDM_ID', 'MDT-155641086', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641086'
			and pid.personid = 'd08450ef-627a-4e5d-bdce-0b0f1089563f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '913c79a0-9e10-4ef7-a4fb-14dca2032f9e', 'MDM_ID', 'MDT-155633384', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633384'
			and pid.personid = '913c79a0-9e10-4ef7-a4fb-14dca2032f9e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a1ec49b1-f9ab-4e70-99fb-224e47ad9d5a', 'MDM_ID', 'MDT-155633383', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633383'
			and pid.personid = 'a1ec49b1-f9ab-4e70-99fb-224e47ad9d5a');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9034c2bc-5f08-4afa-bd2e-9cdd8844742c', 'MDM_ID', 'MDT-155633412', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633412'
			and pid.personid = '9034c2bc-5f08-4afa-bd2e-9cdd8844742c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '82d9f9b6-53da-4d63-a4b4-128f4314f8d9', 'MDM_ID', 'MDT-155641115', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641115'
			and pid.personid = '82d9f9b6-53da-4d63-a4b4-128f4314f8d9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '263ff5f7-4b93-47fd-be05-1bff7fc2671d', 'MDM_ID', 'MDT-155641085', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641085'
			and pid.personid = '263ff5f7-4b93-47fd-be05-1bff7fc2671d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4208780f-be24-4598-b904-dff9418e9114', 'MDM_ID', 'MDT-155641114', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641114'
			and pid.personid = '4208780f-be24-4598-b904-dff9418e9114');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'e5bba008-b9a2-4896-be0e-94e2fa26765e', 'MDM_ID', 'MDT-155641083', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641083'
			and pid.personid = 'e5bba008-b9a2-4896-be0e-94e2fa26765e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0e9b19e5-de4b-464d-9794-48526246cc98', 'MDM_ID', 'MDT-155633411', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633411'
			and pid.personid = '0e9b19e5-de4b-464d-9794-48526246cc98');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd462443c-9b18-4879-bb67-9c74f1618e8c', 'MDM_ID', 'MDT-127277543', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-127277543'
			and pid.personid = 'd462443c-9b18-4879-bb67-9c74f1618e8c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cce821f9-4bbf-4f8b-a00a-62a4e98123e4', 'MDM_ID', 'MDT-155641081', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641081'
			and pid.personid = 'cce821f9-4bbf-4f8b-a00a-62a4e98123e4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd4252b6d-9de4-407c-b201-611352566050', 'MDM_ID', 'MDT-155633410', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633410'
			and pid.personid = 'd4252b6d-9de4-407c-b201-611352566050');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '415f5210-bc9d-47df-9749-c9e03265f0e8', 'MDM_ID', 'MDT-155633378', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633378'
			and pid.personid = '415f5210-bc9d-47df-9749-c9e03265f0e8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a51bb730-530c-4d3a-867b-aabc042c0860', 'MDM_ID', 'MDT-155633409', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633409'
			and pid.personid = 'a51bb730-530c-4d3a-867b-aabc042c0860');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3de9b2ae-1768-45ad-bcad-588d341506fe', 'MDM_ID', 'MDT-155633377', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633377'
			and pid.personid = '3de9b2ae-1768-45ad-bcad-588d341506fe');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2e584ecb-eeaa-4c70-af2d-1b8510c2143d', 'MDM_ID', 'MDT-155641112', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641112'
			and pid.personid = '2e584ecb-eeaa-4c70-af2d-1b8510c2143d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8343d7ba-b665-4520-a908-3911cb882055', 'MDM_ID', 'MDT-155641111', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641111'
			and pid.personid = '8343d7ba-b665-4520-a908-3911cb882055');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '09ee9fc4-911f-4396-85a5-8a50819f8514', 'MDM_ID', 'MDT-155641109', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641109'
			and pid.personid = '09ee9fc4-911f-4396-85a5-8a50819f8514');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a35a4faa-417e-4a26-98f6-ac222af59253', 'MDM_ID', 'MDT-155633408', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633408'
			and pid.personid = 'a35a4faa-417e-4a26-98f6-ac222af59253');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'f94bcefb-ff7b-4103-96ff-592133972ce5', 'MDM_ID', 'MDT-155641108', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641108'
			and pid.personid = 'f94bcefb-ff7b-4103-96ff-592133972ce5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7a9048df-1863-4956-82ad-a290a6d27f98', 'MDM_ID', 'MDT-155641107', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641107'
			and pid.personid = '7a9048df-1863-4956-82ad-a290a6d27f98');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7320a8a1-6c4d-4e47-941e-874f961a06ca', 'MDM_ID', 'MDT-155633407', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633407'
			and pid.personid = '7320a8a1-6c4d-4e47-941e-874f961a06ca');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8303b3d2-3cc7-490b-ab2f-7a99bd0553eb', 'MDM_ID', 'MDT-155633406', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633406'
			and pid.personid = '8303b3d2-3cc7-490b-ab2f-7a99bd0553eb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '41fe19a3-8fdc-47aa-9e84-538d2207c3a5', 'MDM_ID', 'MDT-155633376', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633376'
			and pid.personid = '41fe19a3-8fdc-47aa-9e84-538d2207c3a5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '31ae811e-e52a-4ea5-baa9-94403bcbf19f', 'MDM_ID', 'MDT-155641080', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641080'
			and pid.personid = '31ae811e-e52a-4ea5-baa9-94403bcbf19f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '969a581d-f11b-434b-b6f4-f45654783512', 'MDM_ID', 'MDT-155633375', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633375'
			and pid.personid = '969a581d-f11b-434b-b6f4-f45654783512');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c0dc75be-5361-43f2-bb4c-d128b68a7543', 'MDM_ID', 'MDT-155633374', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633374'
			and pid.personid = 'c0dc75be-5361-43f2-bb4c-d128b68a7543');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '697c1313-9b8e-414b-a367-f3c2dc4cb03e', 'MDM_ID', 'MDT-155641079', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641079'
			and pid.personid = '697c1313-9b8e-414b-a367-f3c2dc4cb03e');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9b1d744a-91c5-416f-95e6-0690174185c6', 'MDM_ID', 'MDT-155641105', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641105'
			and pid.personid = '9b1d744a-91c5-416f-95e6-0690174185c6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '22f33d2f-3985-4fbf-b8c9-e3396f13dade', 'MDM_ID', 'MDT-155633405', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633405'
			and pid.personid = '22f33d2f-3985-4fbf-b8c9-e3396f13dade');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cb9f62a9-f35e-4542-8d7a-16fbc52ae76f', 'MDM_ID', 'MDT-155633404', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633404'
			and pid.personid = 'cb9f62a9-f35e-4542-8d7a-16fbc52ae76f');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd0d1d7b4-db59-4651-ac89-7d35d05ff083', 'MDM_ID', 'MDT-155641104', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641104'
			and pid.personid = 'd0d1d7b4-db59-4651-ac89-7d35d05ff083');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'cff5f2a4-601e-4eac-b709-962a10a42bf4', 'MDM_ID', 'MDT-155641103', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641103'
			and pid.personid = 'cff5f2a4-601e-4eac-b709-962a10a42bf4');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3ed19fc1-2ac3-44c7-b412-6755552e9c5d', 'MDM_ID', 'MDT-155633403', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633403'
			and pid.personid = '3ed19fc1-2ac3-44c7-b412-6755552e9c5d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '0b35014e-7610-4f6b-a6d9-9de712b969b1', 'MDM_ID', 'MDT-155641102', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641102'
			and pid.personid = '0b35014e-7610-4f6b-a6d9-9de712b969b1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '281eafa1-6c56-44a2-bd43-0d346ec67860', 'MDM_ID', 'MDT-155641101', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641101'
			and pid.personid = '281eafa1-6c56-44a2-bd43-0d346ec67860');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5118a1bf-b529-40ff-9d3c-31fa373de03b', 'MDM_ID', 'MDT-155641100', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641100'
			and pid.personid = '5118a1bf-b529-40ff-9d3c-31fa373de03b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8293c566-4c47-4931-963b-fa7f1e5e76dc', 'MDM_ID', 'MDT-155633402', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633402'
			and pid.personid = '8293c566-4c47-4931-963b-fa7f1e5e76dc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5573a0e5-f500-4cf4-854f-4a96461f2237', 'MDM_ID', 'MDT-155633373', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633373'
			and pid.personid = '5573a0e5-f500-4cf4-854f-4a96461f2237');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ed03c6b1-8eee-4dfe-ba3a-d014a7c013a9', 'MDM_ID', 'MDT-155633401', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633401'
			and pid.personid = 'ed03c6b1-8eee-4dfe-ba3a-d014a7c013a9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '5e4f1f9e-bbaf-48c8-8e3b-7b630c24fef1', 'MDM_ID', 'MDT-155641099', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641099'
			and pid.personid = '5e4f1f9e-bbaf-48c8-8e3b-7b630c24fef1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4b8957df-d6ca-4654-ba3c-abdc3fc03fd8', 'MDM_ID', 'MDT-155633400', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633400'
			and pid.personid = '4b8957df-d6ca-4654-ba3c-abdc3fc03fd8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '39c2791f-ecea-403e-aecc-51d7e449d183', 'MDM_ID', 'MDT-155633399', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633399'
			and pid.personid = '39c2791f-ecea-403e-aecc-51d7e449d183');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9bf9891a-ea21-4ea4-8941-22e7b4bb745d', 'MDM_ID', 'MDT-155641078', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641078'
			and pid.personid = '9bf9891a-ea21-4ea4-8941-22e7b4bb745d');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b8ed517a-5ecd-49b4-bcce-51f4a0f34f61', 'MDM_ID', 'MDT-155633398', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633398'
			and pid.personid = 'b8ed517a-5ecd-49b4-bcce-51f4a0f34f61');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7fe79438-ce35-46ce-8834-d3a6274f84c6', 'MDM_ID', 'MDT-129206197', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-129206197'
			and pid.personid = '7fe79438-ce35-46ce-8834-d3a6274f84c6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1a695b78-5e79-4fb0-ad72-b46b14c6e313', 'MDM_ID', 'MDT-155641077', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641077'
			and pid.personid = '1a695b78-5e79-4fb0-ad72-b46b14c6e313');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'eeac2205-36c2-4a17-8813-8dc785458cf5', 'MDM_ID', 'MDT-155641098', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641098'
			and pid.personid = 'eeac2205-36c2-4a17-8813-8dc785458cf5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '429db12a-974b-49b3-b170-95927767cc0c', 'MDM_ID', 'MDT-155633396', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633396'
			and pid.personid = '429db12a-974b-49b3-b170-95927767cc0c');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9374f80e-06dc-4ce5-8d66-f026086b1f43', 'MDM_ID', 'MDT-155633395', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633395'
			and pid.personid = '9374f80e-06dc-4ce5-8d66-f026086b1f43');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '14764862-0970-415f-9492-f932a87ca026', 'MDM_ID', 'MDT-155641097', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641097'
			and pid.personid = '14764862-0970-415f-9492-f932a87ca026');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '752666dc-87eb-4eeb-834b-a8cd32a03cef', 'MDM_ID', 'MDT-155641076', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641076'
			and pid.personid = '752666dc-87eb-4eeb-834b-a8cd32a03cef');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4fe308e5-7f93-465a-a920-c713c9365c5b', 'MDM_ID', 'MDT-155633372', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633372'
			and pid.personid = '4fe308e5-7f93-465a-a920-c713c9365c5b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'a07f3750-5014-453d-b784-bf1d323248cb', 'MDM_ID', 'MDT-155633394', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633394'
			and pid.personid = 'a07f3750-5014-453d-b784-bf1d323248cb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7498e2b8-1708-4871-b37a-9381872a9fb7', 'MDM_ID', 'MDT-155633393', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633393'
			and pid.personid = '7498e2b8-1708-4871-b37a-9381872a9fb7');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '723e7c2b-f7eb-479c-b4b0-ea0dbf963608', 'MDM_ID', 'MDT-155641096', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641096'
			and pid.personid = '723e7c2b-f7eb-479c-b4b0-ea0dbf963608');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b2504972-5df4-42e4-acff-0a93e0948cb8', 'MDM_ID', 'MDT-155633392', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633392'
			and pid.personid = 'b2504972-5df4-42e4-acff-0a93e0948cb8');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '64425adf-3b80-474d-a9bb-e904b55b11fb', 'MDM_ID', 'MDT-155633391', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633391'
			and pid.personid = '64425adf-3b80-474d-a9bb-e904b55b11fb');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bc9b8988-a5ef-4539-871e-cb5e4cb406d6', 'MDM_ID', 'MDT-155641075', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641075'
			and pid.personid = 'bc9b8988-a5ef-4539-871e-cb5e4cb406d6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '4c95741c-54b7-42cb-89cb-4ba46f348ea9', 'MDM_ID', 'MDT-155641095', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641095'
			and pid.personid = '4c95741c-54b7-42cb-89cb-4ba46f348ea9');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'ce678053-79a2-48b3-93c3-a523a5c44551', 'MDM_ID', 'MDT-155633365', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633365'
			and pid.personid = 'ce678053-79a2-48b3-93c3-a523a5c44551');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1227982c-4f80-4453-82ff-5f11abfc5598', 'MDM_ID', 'MDT-155633390', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633390'
			and pid.personid = '1227982c-4f80-4453-82ff-5f11abfc5598');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2635f384-c26f-4aaa-b625-247f8d5403db', 'MDM_ID', 'MDT-155633389', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633389'
			and pid.personid = '2635f384-c26f-4aaa-b625-247f8d5403db');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '56e31ec1-ef8e-4075-8d1a-faf077b628c6', 'MDM_ID', 'MDT-155641069', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641069'
			and pid.personid = '56e31ec1-ef8e-4075-8d1a-faf077b628c6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7c9c31a5-69bb-48f5-8dbe-4bff0d533c10', 'MDM_ID', 'MDT-155633388', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633388'
			and pid.personid = '7c9c31a5-69bb-48f5-8dbe-4bff0d533c10');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '1b24c3f1-4a08-43f6-ab38-e5874add3e65', 'MDM_ID', 'MDT-155633364', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633364'
			and pid.personid = '1b24c3f1-4a08-43f6-ab38-e5874add3e65');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '341cbe7c-4b86-453d-b8ee-db0694fac706', 'MDM_ID', 'MDT-155641093', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641093'
			and pid.personid = '341cbe7c-4b86-453d-b8ee-db0694fac706');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'c18bf9ac-0b64-4a2d-b38f-7464519c0394', 'MDM_ID', 'MDT-155633363', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633363'
			and pid.personid = 'c18bf9ac-0b64-4a2d-b38f-7464519c0394');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '227cfeb4-3d2a-45a4-b3f7-f7942e53f2dc', 'MDM_ID', 'MDT-155633362', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633362'
			and pid.personid = '227cfeb4-3d2a-45a4-b3f7-f7942e53f2dc');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'bcdd3ce5-2fb8-4ee6-a158-9cab82f28f10', 'MDM_ID', 'MDT-155641092', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641092'
			and pid.personid = 'bcdd3ce5-2fb8-4ee6-a158-9cab82f28f10');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '062a93ea-5c11-4f5a-98da-b3d9a01a8417', 'MDM_ID', 'MDT-155633361', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633361'
			and pid.personid = '062a93ea-5c11-4f5a-98da-b3d9a01a8417');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '7bf6ecae-0faa-4344-a040-8595ec6d9ec2', 'MDM_ID', 'MDT-155641068', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641068'
			and pid.personid = '7bf6ecae-0faa-4344-a040-8595ec6d9ec2');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'd16cd0f3-fd1d-4117-9d55-46da3d83170b', 'MDM_ID', 'MDT-155641067', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641067'
			and pid.personid = 'd16cd0f3-fd1d-4117-9d55-46da3d83170b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '2cea5d0e-5b1b-476f-88e3-a7ce9915c0df', 'MDM_ID', 'MDT-155641066', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641066'
			and pid.personid = '2cea5d0e-5b1b-476f-88e3-a7ce9915c0df');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '3469790f-f0fb-444c-a376-4a42682a6090', 'MDM_ID', 'MDT-155641090', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641090'
			and pid.personid = '3469790f-f0fb-444c-a376-4a42682a6090');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '890e262c-e99f-4b22-a29e-0ef7c9fc0c98', 'MDM_ID', 'MDT-155633360', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633360'
			and pid.personid = '890e262c-e99f-4b22-a29e-0ef7c9fc0c98');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '8ab06673-025b-4c6e-b6f7-9c57c9f175c5', 'MDM_ID', 'MDT-155641087', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641087'
			and pid.personid = '8ab06673-025b-4c6e-b6f7-9c57c9f175c5');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b38b77a8-b56f-41ec-be6b-257bdea25ab1', 'MDM_ID', 'MDT-124402444', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-124402444'
			and pid.personid = 'b38b77a8-b56f-41ec-be6b-257bdea25ab1');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '978f29aa-d94b-47ec-b2bf-64952e42b5fd', 'MDM_ID', 'MDT-126217671', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-126217671'
			and pid.personid = '978f29aa-d94b-47ec-b2bf-64952e42b5fd');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '9eff6b8c-5d00-48fd-9616-05da3bd72d72', 'MDM_ID', 'MDT-123481856', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-123481856'
			and pid.personid = '9eff6b8c-5d00-48fd-9616-05da3bd72d72');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b7f2db71-7f58-4938-922b-98f91cc250a6', 'MDM_ID', 'MDT-155641084', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155641084'
			and pid.personid = 'b7f2db71-7f58-4938-922b-98f91cc250a6');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '14a7e32a-f401-4f49-85d5-74bbb31411ba', 'MDM_ID', 'MDT-129125226', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-129125226'
			and pid.personid = '14a7e32a-f401-4f49-85d5-74bbb31411ba');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b5816b89-33e5-403a-bb76-54631e0f4e1b', 'MDM_ID', 'MDT-155633379', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633379'
			and pid.personid = 'b5816b89-33e5-403a-bb76-54631e0f4e1b');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), '361066e4-5c30-43cc-ae17-e63a4442bb48', 'MDM_ID', 'MDT-155633359', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-155633359'
			and pid.personid = '361066e4-5c30-43cc-ae17-e63a4442bb48');
INSERT INTO cjams.personidentifier select cjams.gen_random_uuid(), 'b8b43488-3241-4807-9128-649034d3761d', 'MDM_ID', 'MDT-128816339', 'CIDM-10242', now(), 'CIDM-10242', now(), 1, now(), NULL, NULL, NULL, NULL, NULL  where not exists 
		(select pid.personidentifiervalue
		from personidentifier pid 
		where pid.activeflag = 1
			and pid.personidentifiertypekey = 'MDM_ID' 
			and btrim(pid.personidentifiervalue) = 'MDT-128816339'
			and pid.personid = 'b8b43488-3241-4807-9128-649034d3761d');
