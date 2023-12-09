module day5.part2;

import core.sync.mutex;
import std.conv;
import std.format;
import std.file;
import std.parallelism;
import std.stdio;
import std.string;
import std.typecons;

void main() {
    string[] input = readText("input/day5/input.txt").split("\n");

    long[][] seeds;
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
            for (int i = 0; i < seedStr.length; i += 2) {
                seeds ~= [
                    to!long(seedStr[i]),
                    to!long(seedStr[i + 1])
                ];
            }
            continue;
        }
        long[] numLine = stringLineToLong(line);
        stateData[parserState - 1] ~= numLine;
    }

    shared long minVal = long.max;
    auto mutex = new Mutex;
    foreach (long[] seedAndLength; taskPool.parallel(seeds)) {
        long localMinVal = long.max;
        for (long s = 0; s < seedAndLength[1]; s++) {
            long val = seedAndLength[0] + s;
            for (int i = 0; i < stateData.length; i++) {
                long[][] data = stateData[i];
                foreach (ref long[] startsAndRange; data) {
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
            if (val < localMinVal) {
                localMinVal = val;
            }
        }

        mutex.lock();
        if (localMinVal < minVal) {
            minVal = localMinVal;
        }
        mutex.unlock();
    }

    writeln(minVal);
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
