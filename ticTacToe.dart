import 'dart:io';

List<String> board = List.filled(9, ' ');
String currentPlayer = 'X';

void main() async {
  print('Welcome to Tic-Tac-Toe!\n');

  // Game loop
  while (true) {
    displayBoard();
    await getPlayerMove();

    if (checkWin() || checkDraw()) {
      break;
    }

    // Switch player
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }
}

// Function to display the Tic-Tac-Toe board
void displayBoard() {
  print(' ${board[0]} | ${board[1]} | ${board[2]} ');
  print('-----------');
  print(' ${board[3]} | ${board[4]} | ${board[5]} ');
  print('-----------');
  print(' ${board[6]} | ${board[7]} | ${board[8]} ');
  print('\n');
}

// Function to get the player's move
Future<void> getPlayerMove() async {
  while (true) {
    print('Player $currentPlayer, enter your move (1-9):');
    String? input = await stdin.readLineSync();
    int? move = int.tryParse(input ?? '');

    if (move != null && move >= 1 && move <= 9 && board[move - 1] == ' ') {
      // Valid move
      board[move - 1] = currentPlayer;
      break;
    } else {
      // Invalid move
      print('Invalid move. Please try again.\n');
    }
  }
}

// Function to check for a win
bool checkWin() {
  // Check rows, columns, and diagonals
  for (int i = 0; i < 3; i++) {
    if (board[i * 3] == currentPlayer &&
        board[i * 3 + 1] == currentPlayer &&
        board[i * 3 + 2] == currentPlayer) {
      declareWinner();
      return true;
    }

    if (board[i] == currentPlayer &&
        board[i + 3] == currentPlayer &&
        board[i + 6] == currentPlayer) {
      declareWinner();
      return true;
    }
  }

  if ((board[0] == currentPlayer &&
          board[4] == currentPlayer &&
          board[8] == currentPlayer) ||
      (board[2] == currentPlayer &&
          board[4] == currentPlayer &&
          board[6] == currentPlayer)) {
    declareWinner();
    return true;
  }

  return false;
}

// Function to check for a draw
bool checkDraw() {
  if (!board.contains(' ')) {
    print('It\'s a draw!');
    restartGame();
    return true;
  }
  return false;
}

// Function to declare the winner
void declareWinner() {
  displayBoard();
  print('Player $currentPlayer wins!\n');
  restartGame();
}

// Function to restart the game
void restartGame() {
  print('Do you want to play again? (y/n):');
  String? input = stdin.readLineSync()?.toLowerCase() ?? '';

  if (input == 'y') {
    // Reset the board and start a new game
    board = List.filled(9, ' ');
    currentPlayer = 'X';
    print('\nNew game started!\n');
  } else {
    // Exit the game
    print('\nThanks for playing! Goodbye!');
    exit(0);
  }
}
