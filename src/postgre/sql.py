# dictionary

d = dict(win='SELECT array(SELECT row_to_json(row) FROM (SELECT sum(ra.win_amount) , ra.member_id '
             ' FROM '
             'revenue_analysis ra '
             'WHERE '
             'ra.member_id = %(member_id)s and ra.game_id = coalesce(%(game_id)s, ra.game_id) and '
             'ra.activity_year_month = coalesce(%(activity_year_month)s, ra.activity_year_month) group by ra.member_id) row) ',
         wager='SELECT array(SELECT row_to_json(row) FROM (SELECT sum(ra.wager_amount) , ra.member_id '
             ' FROM '
             'revenue_analysis ra '
             'WHERE '
             'ra.member_id = %(member_id)s and ra.game_id = coalesce(%(game_id)s, ra.game_id) and '
             'ra.activity_year_month = coalesce(%(activity_year_month)s, ra.activity_year_month) group by ra.member_id) row) ',
         number='SELECT array(SELECT row_to_json(row) FROM (SELECT sum(ra.number_of_wagers) , ra.member_id '
             ' FROM '
             'revenue_analysis ra '
             'WHERE '
             'ra.member_id = %(member_id)s and ra.game_id = coalesce(%(game_id)s, ra.game_id) and '
             'ra.activity_year_month = coalesce(%(activity_year_month)s, ra.activity_year_month) group by ra.member_id) row) ',
         )
