module day8.part1;

import std.file;
import std.stdio;
import std.string;

void main() {
    string[] lines = readText("input/day8/input.txt").split("\n");

    string steps;
    string[][string] directions;

    foreach (string line; lines) {
        line = line.strip();
        if (steps.length == 0) {
            steps = line.strip();
            continue;
        }
        if (line.length == 0) {
            continue;
        }

        string[] split = line.split(" = ");
        string key = split[0];
        string left = split[1][1..4];
        string right = split[1][6..9];

        directions[key] = [left, right];
    }

    string pos = "AAA";
    int moves = 0;

    while (pos != "ZZZ") {
        char dir = steps[moves % steps.length];
        string[] next = directions[pos];

        if (dir == 'L') {
            pos = next[0];
        } else {
            pos = next[1];
        }
        moves++;
    }

    writeln(moves);
}