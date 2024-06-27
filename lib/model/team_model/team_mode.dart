class TeamModel {
  final String team_list;

  TeamModel({required this.team_list});

  Map<String, dynamic> toMap() {
    return {
      'team_list': team_list,
    };
  }
}
