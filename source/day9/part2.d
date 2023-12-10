module day9.part2;

import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
    string[] lines = readText("input/day9/input.txt").split("\n");

    long sum = 0;
    foreach (string line; lines) {
        string[] split = line.strip().split(" ");
        long[][] nums = [ [] ];

        foreach (string s; split) {
            nums[0] ~= to!long(s);
        }

        long baseNum;
        while (!allEqual(nums[nums.length - 1])) {
            long[] lastArr = nums[nums.length - 1];
            long[] newArr;

            for (int i = 1; i < lastArr.length; i++) {
                newArr ~= lastArr[i] - lastArr[i - 1];
            }

            baseNum = newArr[newArr.length - 1];
            nums ~= newArr;
        }

        for (long i = nums.length - 2; i >= 0; i--) {
            baseNum = nums[i][0] - baseNum;
        }

        sum += baseNum;
    }

    writeln(sum);
}

bool allEqual(long[] arr) {
    long a = arr[0];
    for (int i = 1; i < arr.length; i++) {
        if (arr[i] != a) {
            return false;
        }
    }
    return true;
}