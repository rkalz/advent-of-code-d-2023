module day6.part1;

import std.array;
import std.conv;
import std.file;
import std.format;
import std.stdio;
import std.string;
import std.uni;

void main() {
    string[] lines = readText("input/day6/input.txt").split("\n");
    int[] times = lineToNums(lines[0].split(":")[1]);
    int[] records = lineToNums(lines[1].split(":")[1]);

    int product = 1;

    for (int i = 0; i < times.length; i++) {
        int raceTime = times[i];
        int recordDistance = records[i];

        int wins = 0;
        for (int holdTime = 0; holdTime <= raceTime; holdTime++) {
            int timeRemaining = raceTime - holdTime;
            int distanceTraveled = holdTime * timeRemaining;
            if (distanceTraveled > recordDistance) {
                wins++;
            }
        }
        if (wins > 0) {
            product *= wins;
        }
    }

    writeln(product);
}

bool isDigit(char c) {
    return c >= '0' && c <= '9';
}

int[] lineToNums(string s) {
    int[] arr;
    int scratch = 0;

    foreach (char c; s) {
        if (isDigit(c)) {
            int digit = c - '0';
            if (scratch == 0) {
                scratch = digit;
            } else {
                scratch = scratch * 10 + digit;
            }
        } else if (scratch != 0) {
            arr ~= scratch;
            scratch = 0;
        }
    }

    if (scratch != 0) {
        arr ~= scratch;
    }

    return arr;
}