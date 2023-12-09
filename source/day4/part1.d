module day4.part1;

import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
    string[] input = readText("input/day4/input.txt").split("\n");

    int sum = 0;
    foreach(string line; input) {
        string[] game = line.split(": ")[1].split(" | ");
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

        int score = 0;
        foreach (int win; winning) {
            if (contains(win, guesses)) {
                if (score == 0) {
                    score = 1;
                } else {
                    score *= 2;
                }
            }
        }
        sum += score;
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