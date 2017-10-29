set term ^ ;
create procedure pr_accept_order
       (
       v_id_order integer,
       v_fact_amnt decimal(18,2)              
       )
as
	declare v_ts timestamp;
	declare v_id_debtor integer;
	declare v_id_creditor integer;
	declare v_trm smallint;
	declare v_id_debt integer;
begin
	v_ts=current_timestamp;
	v_id_debt=next value for se_id_debt;
	insert into ta_order_feat
	       (id_order,id_feat,feat_val_ts,ts_start)
	       values
	       (:v_id_order,3,:v_ts,:v_ts);
	insert into ta_order_feat
	       (id_order,id_feat,feat_val_dec,ts_start)
	       values
	       (:v_id_order,8,:v_fact_amnt,:v_ts);
	update ta_orders
	set
		fact_amnt=:v_fact_amnt,
		execution=2
	where
		id_order=:v_id_order;
	for select
		id_debtor,
		id_creditor,
		trm
	from
		ta_orders
	where
		id_order=:v_id_order
	into
		:v_id_debtor,
		:v_id_creditor,
		:v_trm
	do
		insert into ta_debts
		       (id_debt,id_debtor,id_creditor,amnt_initial,amnt_current,ts_initial,trm,gen_id_order)
		       values
		       (:v_id_debt,:v_id_debtor,:v_id_creditor,:v_fact_amnt,:v_fact_amnt,:v_ts,:v_trm,:v_id_order);
	insert into ta_debt_feat
	       (id_debt,id_feat,feat_val_ts,ts_start)
	       values
	       (:v_id_debt,10,:v_ts,:v_ts);
	insert into ta_debt_feat
	       (id_debt,id_feat,feat_val_dec,ts_start)
	       values
	       (:v_id_debt,14,:v_fact_amnt,:v_ts);
end ^
set term ; ^
       

