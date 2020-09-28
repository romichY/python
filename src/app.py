# src/app.py
from flask import Flask, jsonify, request
from .postgre.db import cur_data


def create_app(env_name):
    app = Flask(__name__)

    app.config.from_object(env_name)

    @app.route('/revenue/api/v1/totalwins', methods=['GET'])
    def get_total_win():
        member_id = request.args.get('member_id')
        game_id = request.args.get('game_id')
        activity_year_month = request.args.get('activity_year_month')
        return jsonify(cur_data({'member_id': member_id, 'game_id': game_id, 'activity_year_month': activity_year_month}, 'win'))

    @app.route('/revenue/api/v1/totalwagers', methods=['GET'])
    def get_total_wager():
        member_id = request.args.get('member_id')
        game_id = request.args.get('game_id')
        activity_year_month = request.args.get('activity_year_month')
        return jsonify(cur_data({'member_id': member_id, 'game_id': game_id, 'activity_year_month': activity_year_month}, 'wager'))

    @app.route('/revenue/api/v1/totalnumbers', methods=['GET'])
    def get_total_number():
        member_id = request.args.get('member_id')
        game_id = request.args.get('game_id')
        activity_year_month = request.args.get('activity_year_month')
        return jsonify(cur_data({'member_id': member_id, 'game_id': game_id, 'activity_year_month': activity_year_month}, 'number'))

    return app
