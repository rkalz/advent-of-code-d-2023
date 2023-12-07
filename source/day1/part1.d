module day1.part1;

import std.array;
import std.ascii;
import std.file;
import std.stdio;


void main() {
    string[] input = readText("input/day1/input.txt").split("\n");

    int sum = 0;
    foreach (string str; input) {
        int firstDigit = -1;
        int lastDigit = -1;
        foreach (char ch; str) {
            if (isDigit(ch)) {
                if (firstDigit == -1) {
                    firstDigit = ch - '0';
                } 
                lastDigit = ch - '0';
            }
        }
        sum += firstDigit * 10 + lastDigit;
    }
    writeln(sum);
}