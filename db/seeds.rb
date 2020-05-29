User.create(username: "juancobian", email: "juancobian@gmail.com", password: "password")
Team.create(name: "Dallas Cowboys", team_record: "1-5", news: "Is this current streak the end of the Dallas Cowboys' season?")
Comment.create(content: "They are on a horrible streak and I believe they are out of the playoffs", user_id: 1)
UserTeam.create(user_id: 1, team_id: 1)
