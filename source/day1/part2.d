module day1.part2;

import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;
import std.typecons;


void main() {
    string[] input = readText("input/day1/input.txt").split("\n");
    int[string] nums = [
        "one": 1, "1": 1,
        "two": 2, "2": 2,
        "three": 3, "3": 3,
        "four": 4, "4": 4,
        "five": 5, "5": 5,
        "six": 6, "6": 6,
        "seven": 7, "7": 7,
        "eight": 8, "8": 8,
        "nine": 9, "9": 9
    ];


    int sum = 0;
    foreach (string str; input) {
        long[][string] numToPosMap;

        foreach(string num; nums.keys) {
            long pos = indexOf(str, num);
            while (pos != -1) {
                if (num !in numToPosMap) {
                    numToPosMap[num] = [];
                }
                numToPosMap[num] ~= pos;
                pos = indexOf(str, num, pos + 1);
            }
        }

        string minString;
        Nullable!long minPos;
        string maxString;
        Nullable!long maxPos;

        foreach(string num; nums.keys) {
            if (num in numToPosMap) {
                foreach(long pos; numToPosMap[num]) {
                    if ((minPos.isNull) || (pos < minPos.get)) {
                        minPos = pos;
                        minString = num;
                    } 

                    if ((maxPos.isNull) || (pos > maxPos.get)) {
                        maxPos = pos;
                        maxString = num;
                    }
                }
            }
        }

        int minNum = nums[minString];
        int maxNum = nums[maxString];

        sum += minNum * 10 + maxNum;
    }
    writeln(sum);
}