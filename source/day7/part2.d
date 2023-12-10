module day7.part2;

import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;
import std.traits;

void main() {
    string[] lines = readText("input/day7/input.txt").split("\n");

    Hand[][HandType] map;
    foreach (string line; lines) {
        string[] split = line.split(" ");
        string cards = split[0].strip();
        int bid = to!int(split[1].strip());
        
        HandType ht = getHandType(cards);
        if (ht !in map) {
            map[ht] = [];
        }
        map[ht] ~= new Hand(cards, bid);
    }

    int[] rankedBids;
    foreach (handType; [EnumMembers!HandType]) {
        if (handType == HandType.Invalid) {
            continue;
        }

        if (handType in map) {
            Hand[] hands = map[handType];
            sort!sortHands(hands);

            foreach(h; hands) {
                rankedBids ~= h.bid;
            }
        }
    }
    
    int score = 0;
    for (int i = 0; i < rankedBids.length; i++) {
        score += rankedBids[i] * (i + 1);
    }

    writeln(score);
}

class Hand {
    string cards;
    int bid;

    this(string c, int b) {
        this.cards = c;
        this.bid = b;
    }
}

enum HandType : int {
    Invalid,
    HighCard,
    OnePair,
    TwoPair,
    ThreeOfAKind,
    FullHouse,
    FourOfAKind,
    FiveOfAKind
}

HandType getHandType(string cards) {
    cards = replaceJokerWithMaxCard(cards);
    int[char] map;
    foreach (char c; cards) {
        if (c !in map) {
            map[c] = 0;
        }
        map[c] += 1;
    }

    if (map.length == 1) {
        return HandType.FiveOfAKind;
    } 
    int max = getMaxValInMap(map);

    if (map.length == 2) {
        if (max == 4) {
            return HandType.FourOfAKind;
        } if (max == 3) {
            return HandType.FullHouse;
        }
    } if (map.length == 3) {
        if (max == 3) {
            return HandType.ThreeOfAKind;
        } if (max == 2) {
            return HandType.TwoPair;
        }
    } if (map.length == 4) {
        if (max == 2) {
            return HandType.OnePair;
        }
    } if (map.length == 5) {
        return HandType.HighCard;
    }

    return HandType.Invalid;
}

int getMaxValInMap(int[char] map) {
    int max = 0;
    foreach (_, val; map) {
        if (val > max) {
            max = val;
        }
    }
    return max;
}

bool sortHands(Hand a, Hand b) {
    for (int i = 0; i < 5; i++) {
        if (a.cards[i] == b.cards[i]) {
            continue;
        }

        int aRank = cardValue(a.cards[i]);
        int bRank = cardValue(b.cards[i]);
        
        if (aRank < bRank) {
            return true;
        } 
        break;
    }

    return false;
}

int cardValue(char c) {
    string cardOrder = "J23456789TQKA";
    for (int i = 0; i < cardOrder.length; i++) {
        if (cardOrder[i] == c) {
            return i;
        }
    }
    return -1;
}

string replaceJokerWithMaxCard(string cards) {
    int[char] map;
    foreach (char c; cards) {
        if (c != 'J') {
            if (c !in map) {
                map[c] = 0;
            }
            map[c]++;
        }
    }

    char maxCard;
    int maxVal = int.min;
    foreach(ch, ct; map) {
        if (ct > maxVal) {
            maxCard = ch;
            maxVal = ct;
        }
    }

    char[] newCards;
    for (int i = 0; i < 5; i++) {
        if (cards[i] == 'J') {
            newCards ~= maxCard;
        } else {
            newCards ~= cards[i];
        }
    }

    return to!string(newCards);
}