module day5.part1;

import std.conv;
import std.format;
import std.file;
import std.stdio;
import std.string;
import std.typecons;

void main() {
    string[] input = readText("input/day5/test.txt").split("\n");

    long[] seeds;
    long[][][7] stateData;

    int parserState = 0;
    foreach(string line; input) {
        line = line.strip();
        if (line.length == 0) {
            parserState++;
            continue;
        } else if (parserState > 0 && !isDigit(line[0])) {
            continue;
        }

        if (parserState == 0) {
            string[] seedStr = line.split(": ")[1].split(" ");
            foreach(string ss; seedStr) {
                seeds ~= to!long(ss);
            }
            continue;
        }
        long[] numLine = stringLineToLong(line);
        stateData[parserState - 1] ~= numLine;
    }

    Nullable!long minLoc;
    foreach (long seed; seeds) {
        long val = seed;
        for (int i = 0; i < stateData.length; i++) {
            long[][] data = stateData[i];
            foreach (long[] startsAndRange; data) {
                long keyStart = startsAndRange[0];
                long valStart = startsAndRange[1];
                long keyEnd = keyStart + startsAndRange[2] - 1;

                if (val >= keyStart && val <= keyEnd) {
                    long offset = val - keyStart;
                    val = valStart + offset;
                    break;
                }
            }
        }
        if (minLoc.isNull || val < minLoc.get) {
            minLoc = val;
        }
    }

    writeln(minLoc.get);
}

bool isDigit(char c) {
    return c >= '0' && c <= '9';
}

long[] stringLineToLong(string s) {
    string[] interList = s.split(" ");
    return [
            to!long(interList[1].strip()),
            to!long(interList[0].strip()),
            to!long(interList[2].strip())
    ];
}
