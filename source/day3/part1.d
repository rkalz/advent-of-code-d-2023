module day3.part1;

import std.array;
import std.file;
import std.format;
import std.stdio;

void main() {
    string[] lines = readText("input/day3/input.txt").split("\n");
    char[][] input;

    foreach (string line; lines) {
        char[] splitLine;
        foreach(char c; line) {
            splitLine ~= c;
        }
        input ~= splitLine;
    }

    ulong rows = input.length;
    ulong cols = input[0].length;

    int sum = 0;

    int currNum = 0;
    int startPos = 0;
    int endPos = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            char c = input[i][j];
            if (isDigit(c)) {
                int digit = c - '0';
                if (currNum == 0) {
                    currNum = digit;
                    startPos = j;
                } else {
                    currNum = 10 * currNum + digit;
                }
                endPos = j;
            } else if (currNum != 0) {
                if (isPartNumber(input, i, startPos, endPos)) {
                    sum += currNum;
                }
                currNum = 0;
            }
        }
        if (currNum != 0) {
            if (isPartNumber(input, i, startPos, endPos)) {
                sum += currNum;
            }
            currNum = 0;
        }
    }

    writeln(sum);
}

bool isDigit(char c) {
    return c >= '0' && c <= '9';
}

bool isPartNumber(char[][] input, int row, int leftCol, int rightCol) {
    for (int i = row - 1; i <= row + 1; i++) {
        if (i == 0 || i >= input.length) {
            continue;
        }
        for (int j = leftCol - 1; j <= rightCol + 1; j++) {
            if (j < 0 || j >= input[i].length) {
                continue;
            }

            char c = input[i][j];
            if (!isDigit(c) && c != '.') {
                return true;
            }
        }
    }

    return false;
}