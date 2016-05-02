module idiomatic;

import std.algorithm;
import std.file;
import std.range;
import std.stdio;
import std.string;
import std.uni;

public:

void run(string inputFile)
{                           // Original module:
    readText(inputFile)     // input
        .asWordLists        // input
        .withCircularShifts // circular shifter
        .alphabetized       // alphabetizer
        .each!writeln;      // output
}

// --

private:

/// Performs "foo bar \n baz" -> [["foo", "bar"], ["baz"]]
auto asWordLists(Range)(Range range)
{
    return range
        .lineSplitter
        .map!(line => line
            .splitter!isWhite
            .filter!(word => !word.empty));
}

/// Performs [["foo", "bar"], ["baz"]] -> [["foo", "bar"], ["bar", "foo"], ["baz"]]
auto withCircularShifts(Range)(Range range)
{
    return range
        .map!(line => line.rotations)
        .joiner;
}

/// Performs ["foo", "bar"] -> [["foo", "bar"], ["bar", "foo"]]
auto rotations(Range)(Range range)
{
    auto len = range.walkLength;
    
    return range
        .repeat(len)
        .enumerate
        .map!(item => item.value.cycle.drop(item.index).take(len));
}

/// Performs [["foo", "bar"], ["baz"]] -> ["baz", "foo bar"]
auto alphabetized(Range)(Range range)
{
    return range
        .map!(line => line.joiner(" "))
        .array
        .sort!((a, b) => icmp(a, b) < 0);
}