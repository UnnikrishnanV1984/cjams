-- CDM-10841 - Remove GAP annual review

update gapannualreview set activeflag=0, updatedby='CDM-10841', updatedon = now() where gapannualreviewid='2425cfeb-273a-45af-849e-a192353f8ce6' and activeflag=1;
update routing set activeflag=0, updatedby='CDM-10841', updatedon = now() where routingid='a04e2867-4a6b-400b-9825-7442fa1ec430' and activeflag=1;