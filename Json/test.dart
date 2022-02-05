import 'dart:io';
import 'dart:convert';

List<Player> players = [];

void main() async{
	print("hello world");
	final File file = File('D:/Sadi/FlutterProjects/id_project/lib/test.json');
	await readPlayerData(file);
	//print(players);
	Player newPlayer = Player(
      'Samy Brook',
      '31',
      'cooking'
      );

  players.add(newPlayer);

  print(players.length);

  players
      .map(
        (player) => player.toJson(),
      )
      .toList();
	  
	file.writeAsStringSync(json.encode(players));
}

Future<void> readPlayerData (File file) async { //<PlayerList>
  
    
    String contents = await file.readAsString();
    var jsonResponse = jsonDecode(contents);
	//List<Player> players = [];
	for(var p in jsonResponse){
		print(p["name"]);
		print(88);
		Player player = Player(p['name'],p['age'],p['hobby']);
		players.add(player);
	}
	
	print(players[0].name);
	
	//return players; 
    //final playerList = PlayerList.fromJson(jsonResponse);
	//print(jsonResponse);
    //return playerList;
  
}

class Player {
  late String name;
  late String age;
  late String hobby;
  

  Player(
     this.name,
     this.age,
    this.hobby,
  
  );

  Player.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    hobby = json['hobby'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['hobby'] = this.hobby;
    
    return data;
  }
  
}
