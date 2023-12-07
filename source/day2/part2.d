module day2.part2;

import std.conv;
import std.file;
import std.stdio;
import std.string;
import std.typecons;

void main() {
    string[] input = readText("input/day2/input.txt").split("\n");

    long sum = 0;
    foreach (string line; input) {
        string[] idToGame = line.split(":");
        string[] rounds = idToGame[1][1..$].split(";");

        Nullable!long maxRed;
        Nullable!long maxGreen;
        Nullable!long maxBlue;

        foreach (string round; rounds) {
            string[] counts = round.strip().split(",");
            foreach(string count; counts) {
                string[] ctAndColor = count.strip().split(" ");
                long ct = to!long(ctAndColor[0]);
                string color = ctAndColor[1];

                if (color == "red" && (maxRed.isNull || ct > maxRed.get)) {
                    maxRed = ct;
                } else if (color == "green" && (maxGreen.isNull || ct > maxGreen.get)) {
                    maxGreen = ct;
                } else if (color == "blue" && (maxBlue.isNull || ct > maxBlue.get)) {
                    maxBlue = ct;
                }
            }
        }
        sum += (maxRed.get * maxGreen.get * maxBlue.get);
    }

    writeln(sum);
}