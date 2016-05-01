module one.input;

import std.algorithm;
import std.conv;
import std.file;
import std.range;
import std.string;
import std.uni;
import std.utf;

public:

// change these definitions, for different performance/capability trade-offs:

alias LineNum = ptrdiff_t;
alias WordNum = ptrdiff_t;
alias CharNum = ptrdiff_t;

enum wordSeparator = ' ';

string data;
CharNum[] lineIndex;

// Reads the lines from the input medium, and stores each word separated by a
// `wordSeparator` character constant. The Lines are stored without a separator,
// and a separate index of where the lines start is kept in `lineIndex`.
void readLines(string filename)
{
    size_t lineStart;

    data = readText(filename)
        .lineSplitter

        // normalize the spacing between words
        .map!(line => line
            .splitter!(c => c.isWhite)
            .filter!(c => !c.empty)
            .joiner([wordSeparator]))

        // remove empty lines 
        .filter!(line => !line.empty)

        // keep an index of where each line starts
        .tee!((line) {
            lineIndex ~= lineStart;
            lineStart += line.byChar.walkLength;
        })

        // join the lines
        .joiner
        .to!string;
}