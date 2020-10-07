CREATE OR REPLACE VIEW public.v_pl_total
AS WITH clients AS (
         SELECT DISTINCT ra.member_id,
            c_1.calendar_date,
            c_1.calendar_year,
            c_1.calendar_month_number,
            c_1.calendar_month_name,
            c_1.calendar_day_of_month,
            c_1.calendar_day_of_week,
            c_1.calendar_day_name,
            c_1.calendar_year_month
           FROM revenue_analysis ra,
            calendar c_1
        ), cal_cl AS (
         SELECT clients.member_id,
            clients.calendar_date,
            clients.calendar_year,
            clients.calendar_month_number,
            clients.calendar_month_name,
            clients.calendar_day_of_month,
            clients.calendar_day_of_week,
            clients.calendar_day_name,
            clients.calendar_year_month,
            r.activity_year_month,
            r.bank_type_id,
            r.game_id,
            r.number_of_wagers,
            r.wager_amount,
            r.win_amount
           FROM clients
             LEFT JOIN revenue_analysis r ON r.activity_date = clients.calendar_date AND r.member_id = clients.member_id
        ), prev_calc AS (
         SELECT cl.member_id,
            cl.calendar_date,
            cl.calendar_year,
            cl.calendar_month_number,
            cl.calendar_month_name,
            cl.calendar_day_of_month,
            cl.calendar_day_of_week,
            cl.calendar_day_name,
            cl.calendar_year_month,
            cl.activity_year_month,
            cl.bank_type_id,
            cl.game_id,
            cl.number_of_wagers,
            cl.wager_amount,
            cl.win_amount,
            count(cl.number_of_wagers) OVER (PARTITION BY cl.member_id ORDER BY cl.calendar_year_month RANGE UNBOUNDED PRECEDING) AS cnt_total
           FROM cal_cl cl
        ), prev_aggr AS (
         SELECT s.member_id,
            s.calendar_year_month,
            s.cnt_total,
            count(s.number_of_wagers) AS cnt
           FROM prev_calc s
          GROUP BY s.member_id, s.calendar_year_month, s.cnt_total
        ), calc_st AS (
         SELECT p.member_id,
            p.calendar_year_month,
                CASE
                    WHEN p.cnt_total > 0 AND lag(p.cnt_total) OVER (PARTITION BY p.member_id ORDER BY p.calendar_year_month) = 0 THEN 'New'::text
                    WHEN lag(p.cnt) OVER (PARTITION BY p.member_id ORDER BY p.calendar_year_month) > 0 AND p.cnt > 0 THEN 'Retained'::text
                    WHEN lag(p.cnt) OVER (PARTITION BY p.member_id ORDER BY p.calendar_year_month) > 0 AND p.cnt = 0 THEN 'Unretained'::text
                    WHEN lag(p.cnt) OVER (PARTITION BY p.member_id ORDER BY p.calendar_year_month) = 0 AND p.cnt > 0 THEN 'Reactivated'::text
                    WHEN lag(p.cnt) OVER (PARTITION BY p.member_id ORDER BY p.calendar_year_month) = 0 AND p.cnt = 0 AND p.cnt_total > 0 THEN 'Lapsed'::text
                    ELSE 'Unknown'::text
                END AS member_lifecycle_status
           FROM prev_aggr p
        )
 SELECT c.member_id,
    c.calendar_year_month,
    c.member_lifecycle_status,
    count(
        CASE
            WHEN c.member_lifecycle_status = 'Lapsed'::text THEN 1
            ELSE NULL::integer
        END) OVER (PARTITION BY c.member_id, c.member_lifecycle_status ORDER BY c.calendar_year_month RANGE UNBOUNDED PRECEDING) AS lapsed_months
   FROM calc_st c;