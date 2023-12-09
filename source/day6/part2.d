module day6.part2;

import std.array;
import std.conv;
import std.file;
import std.format;
import std.stdio;
import std.string;
import std.uni;

void main() {
    string[] lines = readText("input/day6/input.txt").split("\n");
    long raceTime = lineToNum(lines[0].split(":")[1]);
    long recordDistance = lineToNum(lines[1].split(":")[1]);

    long wins = 0;

    for (long holdTime = 0; holdTime <= raceTime; holdTime++) {
        long timeRemaining = raceTime - holdTime;
        long distanceTraveled = timeRemaining * holdTime;
        if (distanceTraveled > recordDistance) {
            wins++;
        }
    }

    writeln(wins);
}

bool isDigit(char c) {
    return c >= '0' && c <= '9';
}

long lineToNum(string s) {
    long n = 0;
    foreach (char c; s) {
        if (isDigit(c)) {
            long digit = c - '0';
            n = n * 10 + digit;
        }
    }
    return n;
}