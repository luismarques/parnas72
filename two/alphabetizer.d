module two.alphabetizer;

import std.algorithm;
import std.range;
import std.traits;
import std.uni;
import std.utf;
import two.circularshifter;

public:

/// (original name: ALPH)
void setup()
{
    index = alphabeticIndex;
}

/// (original name: ITH)
LineNum ithLine(LineNum lineNum)
{
    assert(lineNum < index.length);

    return index[lineNum];
}

// The original functions ALPHAC, EQW, ALPHW, EQL and ALPHL are not needed.

LineNum alphac(LineNum lineNum)
{
    assert(false, "not implemented");
}

bool eqw(LineNum l1, LineNum l2, WordNum w1, WordNum w2)
{
    assert(false, "not implemented");
}

bool alphaw(LineNum l1, LineNum l2, WordNum w1, WordNum w2)
{
    assert(false, "not implemented");
}

bool eql(LineNum l1, LineNum l2)
{
    assert(false, "not implemented");
}

bool alphal(LineNum l1, LineNum l2)
{
    assert(false, "not implemented");
}

// --

private:

ReturnType!alphabeticIndex index;

auto alphabeticIndex()
{
    auto indexOffsets = new LineNum[numLines];

    makeIndex!((a, b) => icmp(a, b) < 0)
        (numLines.iota.map!(a => line(a).array), indexOffsets);

    return indexOffsets;
}

auto line(LineNum lineNum)
{
    return numWords(lineNum)
        .iota
        .map!(wordNum => word(lineNum, wordNum))
        .joiner(" ".byCodeUnit);
}

auto word(LineNum lineNum, WordNum wordNum)
{
    return numCharacters(lineNum, wordNum)
        .iota
        .map!(charNum => wordChar(lineNum, wordNum, charNum));
}