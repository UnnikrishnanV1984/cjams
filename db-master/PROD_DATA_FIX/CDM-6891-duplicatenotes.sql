-- Removed duplicate notes
update cjams.progressnote set activeflag = 0, updatedon = now(), updatedby = 'CDM-6891' where progressnoteid in ('7b7a0ad3-d8b0-4ba1-a91a-9126b57b6e5f', '89e88975-5cf6-48c3-8b43-6fabfa4b089d');


