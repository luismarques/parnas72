module two.circularshifter;

import std.algorithm;
import std.conv;
import std.range;
import two.linestorage;
import storage = two.linestorage;

public:

enum maxLines = LineNum.max; /// (original name: p4)

alias LineNum = storage.LineNum;
alias WordNum = storage.WordNum;
alias CharNum = storage.CharNum;

/// (original name: CSSTUP)
void setup()
{
    shiftIndex = iota(storage.numLines)
        .map!(a => storage.numWords(a).iota
            .map!(b => ShiftIndexEntry(a, b)))
        .joiner
        .array;
}

/// (original name: CSWORD)
char wordChar(LineNum lineNum, WordNum wordNum, CharNum charNum)
{
    auto entry = shiftIndex[lineNum];

    WordNum storageWordNum = (entry.firstWord + wordNum) %
        storage.numWords(entry.lineNum);

    return storage.wordChar(entry.lineNum, storageWordNum, charNum);
}

/// (original name: CSWRDS)
LineNum numWords(LineNum lineNum)
{
    auto entry = shiftIndex[lineNum];
    return storage.numWords(entry.lineNum);
}

/// (original name: CSLNES)
LineNum numLines()
{
    return shiftIndex.length.to!LineNum;
}

/// (original name: CSCHRS)
CharNum numCharacters(LineNum lineNum, WordNum wordNum)
{
    auto entry = shiftIndex[lineNum];

    WordNum storageWordNum = (entry.firstWord + wordNum) %
        storage.numWords(entry.lineNum);

    return storage.numCharacters(entry.lineNum, storageWordNum);
}

// --

private:

struct ShiftIndexEntry
{
    LineNum lineNum;
    WordNum firstWord;
}

ShiftIndexEntry[] shiftIndex;