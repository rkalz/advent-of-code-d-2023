module day3.part2;

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

    int[][] gearPos;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            char c = input[i][j];
            if (c == '*') {
                gearPos ~= [i, j];
            }
        }
    }

    int sum = 0;
    foreach(int[] gear; gearPos) {
        int[] nums;

        int r = gear[0];
        int c = gear[1];

        for (int i = r - 1; i <= r + 1; i++) {
            for (int j = c - 1; j <= c + 1; j++) {
                if (i == r && j == c) {
                    continue;
                }

                char ch = input[i][j];
                if (isDigit(ch)) {
                    int num = charToInt(ch);
                    int factor = 10;
                    for (int pos = j - 1; pos >= 0; pos--) {
                        char d = input[i][pos];
                        if (isDigit(d)) {
                            num = (charToInt(d) * factor) + num;
                            factor *= 10;
                        } else {
                            break;
                        }
                    }
                    for (int pos = j + 1; pos < input[i].length; pos++) {
                        char d = input[i][pos];
                        if (isDigit(d)) {
                            num = (10 * num) + charToInt(d);
                        } else {
                            break;
                        }
                    }

                    bool exists = false;
                    foreach (int key; nums) {
                        if (key == num) {
                            exists = true;
                            break;
                        }
                    }

                    if (!exists) {
                        nums ~= num;
                    }
                }
            }
        }

        if (nums.length == 2) {
            sum += nums[0] * nums[1];
        }
    }

    writeln(sum);
}

bool isDigit(char c) {
    return c >= '0' && c <= '9';
}

int charToInt(char c) {
    return c - '0';
}