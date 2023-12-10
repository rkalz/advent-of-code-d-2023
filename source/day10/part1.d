module day10.part1;

import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
    string[] lines = readText("input/day10/input.txt").split("\n");

    char[][] map;
    foreach(string s; lines) {
        map ~= to!(char[])(s);
    }

    long[][] distance;
    long startX;
    long startY;

    for (long i = 0; i < map.length; i++) {
        distance ~= [ [] ];
        for (long j = 0; j < map[i].length; j++) {
            if (map[i][j] == 'S') {
                startX = i;
                startY = j;
                distance[i] ~= 0;
            } else {
                distance[i] ~= long.max;
            }
        }
    }

    if (startX != 0) {
        char c = map[startX - 1][startY];
        if (c == '|' || c == '7' || c == 'F') {
            traverse(map, distance, startX - 1, startY, 0);
        }
    }
    if (startX != map.length - 1) {
        char c = map[startX + 1][startY];
        if (c == '|' || c == 'L' || c == 'J') {
            traverse(map, distance, startX + 1, startY, 0);
        }
    }
    if (startY != 0) {
        char c = map[startX][startY - 1];
        if (c == '-' || c == 'L' || c == 'F') {
            traverse(map, distance, startX, startY - 1, 0);
        }
    }
    if (startY != map[startX].length - 1) {
        char c = map[startX][startY + 1];
        if (c == '-' || c == 'J' || c == '7') {
            traverse(map, distance, startX, startY + 1, 0);
        }
    }

    long maxDistance = long.min;
    for (long i = 0; i < distance.length; i++) {
        for (long j = 0; j < distance[i].length; j++) {
            long d = distance[i][j];
            if (d != long.max && d > maxDistance) {
                maxDistance = d;
            }
        }
    }
    writeln(maxDistance);
}

void traverse(ref char[][] map, ref long[][] distance, long i, long j, long prevDistance) {
    if (i < 0 || i >= map.length || j < 0 || j >= map[i].length) {
        return;
    }
    char c = map[i][j];
    if (c == '.') {
        return;
    }

    long newDist = prevDistance + 1;
    if (distance[i][j] < newDist) {
        return;
    }
    distance[i][j] = newDist;

    if (c == '|') {
        traverse(map, distance, i - 1, j, newDist);
        traverse(map, distance, i + 1, j, newDist);
    } else if (c == '-') {
        traverse(map, distance, i, j - 1, newDist);
        traverse(map, distance, i, j + 1, newDist);
    } else if (c == 'L') {
        traverse(map, distance, i - 1, j, newDist);
        traverse(map, distance, i, j + 1, newDist);
    } else if (c == 'J') {
        traverse(map, distance, i - 1, j, newDist);
        traverse(map, distance, i, j - 1, newDist);
    } else if (c == '7') {
        traverse(map, distance, i + 1, j, newDist);
        traverse(map, distance, i, j - 1, newDist);
    } else if (c == 'F') {
        traverse(map, distance, i + 1, j, newDist);
        traverse(map, distance, i, j + 1, newDist);
    }
}