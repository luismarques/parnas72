module one.circularshifter;

import std.algorithm;
import std.range;
import std.typecons;
import std.utf;
import one.input;

public:

struct ShiftIndexEntry
{
    LineNum lineNum;
    CharNum firstChar;
}

ShiftIndexEntry[] shiftIndex;

void setup()
{
    shiftIndex = iota(lineIndex.length) // 0, 1, 2 ...
        .map!(lineNum => line(lineNum)) // first line, second line, ...
        .enumerate          // (0, first line), (1, second line), ...

        // for each word in each line, get the input address/index of each word
        .map!(a => a.value.byCodeUnit
            .enumerate
            .splitter!(b => b.value == wordSeparator)
            .map!(b => b.front.index + lineIndex[a.index]))

        // create the ShiftIndex entries for each line rotation/1st word
        .enumerate
        .map!(a => a.value
            .map!(b => ShiftIndexEntry(a.index, b)))
        .joiner
        .array;
}

private:

auto line(LineNum lineNum)
{
    auto lineStart = lineIndex[lineNum];
    auto lineEnd = lineNum+1 >= lineIndex.length ? data.length : lineIndex[lineNum+1];

    return data[lineStart .. lineEnd];
}