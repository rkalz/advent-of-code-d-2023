module day2.part1;

import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
    string[] input = readText("input/day2/input.txt").split("\n");

    int allowedRed = 12;
    int allowedGreen = 13;
    int allowedBlue = 14;

    int sum = 0;
    foreach (string line; input) {
        string[] idToGame = line.split(":");
        int id = to!int(idToGame[0][5..$]);
        bool validRound = true;

        string[] rounds = idToGame[1][1..$].split(";");

        foreach (string round; rounds) {
            string[] counts = round.strip().split(",");
            foreach(string count; counts) {
                string[] ctAndColor = count.strip().split(" ");
                int ct = to!int(ctAndColor[0]);
                string color = ctAndColor[1];

                if (color == "red" && ct > allowedRed) {
                    validRound = false;
                    break;
                } else if (color == "green" && ct > allowedGreen) {
                    validRound = false;
                    break;
                } else if (color == "blue" && ct > allowedBlue) {
                    validRound = false;
                    break;
                }
            }

            if (!validRound) {
                break;
            }
        }

        if (validRound) {
            sum += id;
        }
    }

    writeln(sum);
}