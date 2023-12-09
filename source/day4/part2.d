module day4.part2;

import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
    string[] input = readText("input/day4/input.txt").split("\n");

    int[] matchList = [0];
    int sum = 0;

    foreach(string line; input) {
        string[] splitLine = line.split(": ");

        int gameId = to!int(splitLine[0][5..$].strip());
        string[] game = splitLine[1].split(" | ");

        string[] guessesStr = game[0].strip().split(" ");
        string[] winningStr = game[1].strip().split(" ");

        int[] guesses;
        foreach (string guess; guessesStr) {
            if (guess.strip().length == 0) {
                continue;
            }
            guesses ~= to!int(guess);
        }

        int[] winning;
        foreach (string win; winningStr) {
            if (win.strip().length == 0) {
                continue;
            }
            winning ~= to!int(win);
        }

        int matches = 0;
        foreach (int win; winning) {
            if (contains(win, guesses)) {
                matches++;
            }
        }
        matchList ~= matches;
    }

    int[] cardCount;
    for (int i = 0; i < matchList.length; i++) {
        cardCount ~= 1;
    }

    for (int i = 1; i < cardCount.length; i++) {
        int cards = cardCount[i];

        sum += cards;
        for (int j = 0; j < matchList[i]; j++) {
            cardCount[i + 1 + j] += cards;
        }
    }

    writeln(sum);
}

bool contains(int n, int[] arr) {
    foreach (int i; arr) {
        if (i == n) {
            return true;
        }
    }
    return false;
}