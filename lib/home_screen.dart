import 'package:flutter/material.dart';

import 'game_logic.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String activeplayer = "X";
  bool gameover = false;
  int turn = 0;
  String result = 'xxxxxxxxxxxxxx';
  Game game = Game();

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              title: const Text(
                "Turn on/off two player",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              value: isSwitched,
              onChanged: (newval) {
                setState(() {
                  isSwitched = newval;
                });
              },
            ),
            Text(
              "It's $activeplayer turn".toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 52,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
                crossAxisCount: 3,
                children: List.generate(
                  9,
                  (index) => InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: gameover ? null : () => _onTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).shadowColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          Player.playerx.contains(index)
                              ? "X"
                              : Player.playero.contains(index)
                                  ? "O"
                                  : "",
                          style: TextStyle(
                            color: Player.playerx.contains(index)
                                ? Colors.blue
                                : Colors.red,
                            fontSize: 52,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 42,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  Player.playerx = [];
                  Player.playero = [];
                  activeplayer = "X";
                  gameover = false;
                  turn = 0;
                  result = '';
                });
              },
              icon: const Icon(Icons.replay_rounded),
              label: const Text("Repeat the Game"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).splashColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTap(int index) async{
    if ((Player.playerx.isEmpty || !Player.playerx.contains(index)) &&
        (Player.playero.isEmpty || !Player.playero.contains(index))) {
      game.playGame(index, activeplayer);
      updatestate();

      if(!isSwitched && !gameover){
        await game.autoplay(activeplayer);
        updatestate();
      }
    }
  }

  void updatestate() {
    setState(() {
      activeplayer = (activeplayer == "X") ? "O" : "X";

      String winnerplayer=game.checkwinner();
      if(winnerplayer!=''){
        result="$winnerplayer is the WINNER".toUpperCase();
      }
      else{
        result="It's a Draw!".toUpperCase();
      }
    });
  }
}
