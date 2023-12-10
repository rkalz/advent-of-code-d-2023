module day8.part2;

import std.algorithm.iteration;
import std.file;
import std.numeric;
import std.parallelism;
import std.stdio;
import std.string;

void main() {
    string[] lines = readText("input/day8/input.txt").split("\n");

    string steps;
    string[][string] directions;
    string[] allPos;

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

        if (key[2] == 'A') {
            allPos ~= key;
        }
    }

    long[] subSteps;
    foreach (string pos; allPos) {
        long subMoves = 0;
        while (pos[2] != 'Z') {
            char dir = steps[subMoves % steps.length];
            string[] next = directions[pos];
            if (dir == 'L') {
                pos = next[0];
            } else {
                pos = next[1];
            }
            subMoves++;
        }
        subSteps ~= subMoves;
    }

    long sum = reduce!((a, b) => lcm(a, b))(subSteps);
    writeln(sum);
}

bool allPosEnded(string[] allPos) {
    foreach (string s; allPos) {
        if (s[2] != 'Z') {
            return false;
        }
    }
    return true;
}