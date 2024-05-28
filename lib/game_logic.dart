import 'dart:math';

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = " ";

  static List<int> playerx = [];
  static List<int> playero = [];
}

extension ContainAll on List {
  bool containAll(int x, int y, {z}) {
    if (z == null)
      return contains(x) && contains(y);
    else
      return contains(x) && contains(y) && contains(z);
  }
}

class Game {
  void playGame(int index, String activeplayer) {
    if (activeplayer == "X") {
      Player.playerx.add(index);
    } else {
      Player.playero.add(index);
    }
  }

  String checkwinner() {
    String winner = '';
    if (Player.playerx.containAll(0, 1, z: 2) ||
        Player.playerx.containAll(3, 4, z: 5) ||
        Player.playerx.containAll(6, 7, z: 8) ||
        Player.playerx.containAll(0, 3, z: 6) ||
        Player.playerx.containAll(1, 4, z: 7) ||
        Player.playerx.containAll(2, 5, z: 8) ||
        Player.playerx.containAll(1, 4, z: 8) ||
        Player.playerx.containAll(2, 4, z: 6)) {
      winner = "X";
    }
      if (Player.playero.containAll(0, 1, z: 2) ||
        Player.playero.containAll(3, 4, z: 5) ||
        Player.playero.containAll(6, 7, z: 8) ||
        Player.playero.containAll(0, 3, z: 6) ||
        Player.playero.containAll(1, 4, z: 7) ||
        Player.playero.containAll(2, 5, z: 8) ||
        Player.playero.containAll(1, 4, z: 8) ||
        Player.playero.containAll(2, 4, z: 6)) {
      winner = "O";
    }
    else{
      winner="";
    }
    return winner;
  }

  Future<void> autoplay(activeplayer) async {
    int index = 0;

    List<int> emptycells = [];

    for (var i = 0; i < 9; i++) {
      if (!(Player.playerx.contains(i) || Player.playero.contains(i)))
        emptycells.add(i);
    }
    Random random = Random();
    int randomindex = random.nextInt(emptycells.length);

    index = emptycells[randomindex];

    playGame(index, activeplayer);
  }
}
