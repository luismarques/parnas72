module one.alphabetizer;

import std.algorithm;
import std.math;
import std.range;
import std.typecons;
import std.uni;
import std.utf;
import one.input;
import one.circularshifter;

public:

void setup()
{
    shiftIndex.sort!((a, b) => icmp(line(a), line(b)) < 0);
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
