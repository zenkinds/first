set term ^ ;
create procedure pr_make_order
       (
       v_id_debtor integer,
       v_id_creditor integer,
       v_claimed_amnt decimal(18,2),
       v_required smallint,
       v_trm smallint
       )
as
	declare v_id_order integer;
	declare v_ts timestamp;
begin
	v_id_order=next value for se_id_order;
	v_ts=current_timestamp;
	insert into ta_orders
	       (id_order,id_debtor,id_creditor,claimed_amnt,required,execution,ts_create,trm)
	       values
	       (:v_id_order,:v_id_debtor,:v_id_creditor,:v_claimed_amnt,:v_required,1,:v_ts,:v_trm);
	insert into ta_order_feat
	       (id_order,id_feat,feat_val_ts,ts_start)
	       values
	       (:v_id_order,2,:v_ts,:v_ts);
	insert into ta_order_feat
	       (id_order,id_feat,feat_val_int,ts_start)
	       values
	       (:v_id_order,9,:v_trm,:v_ts);
	insert into ta_order_feat
	       (id_order,id_feat,feat_val_dec,ts_start)
	       values
	       (:v_id_order,15,:v_claimed_amnt,:v_ts);
end ^
set term ; ^


