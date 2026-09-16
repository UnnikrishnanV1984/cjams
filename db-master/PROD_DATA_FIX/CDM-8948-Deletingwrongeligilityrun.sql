-- Deleting eligibility Review Period as per user CDM-8948
delete from tb_eligibility_period tep where eligibility_id = 159879 and sqnm_sw = 'R3' and delete_sw = 'N';