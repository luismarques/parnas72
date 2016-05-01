module one.output;

import std.algorithm;
import std.range;
import std.stdio;
import one.input;
import one.circularshifter;

void printLines()
{
    shiftIndex.map!(entry => entry.line).each!writeln;
}

private:

auto line(ShiftIndexEntry entry)
{
    auto a = entry.firstChar;
    auto b = entry.lineNum+1 >= lineIndex.length ? data.length : lineIndex[entry.lineNum+1];
    auto c = lineIndex[entry.lineNum];
    auto d = (entry.firstChar-1).max(0).max(c);

    auto x = data[a .. b];
    auto y = data[c .. d];

    return joiner(only(x, y).filter!(a => !a.empty), " ");
}