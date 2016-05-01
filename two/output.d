module two.output;

import std.algorithm;
import std.range;
import std.stdio;
import std.utf;
import two.circularshifter;
import two.alphabetizer;

public:

void printLines()
{
    numLines
        .iota
        .map!(lineNum => lineNum
            .ithLine
            .line)
        .each!writeln;
}

// --

private:

auto line(LineNum lineNum)
{
    return numWords(lineNum)
        .iota
        .map!(wordNum => word(lineNum, wordNum))
        .joiner(" ");
}

auto word(LineNum lineNum, WordNum wordNum)
{
    return numCharacters(lineNum, wordNum)
        .iota
        .map!(charNum => wordChar(lineNum, wordNum, charNum))
        .byDchar;
}