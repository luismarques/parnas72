module two.linestorage;

import std.algorithm;
import std.range;
import std.utf;

public:

// change these definitions, for different performance/capability trade-offs:

alias LineNum = ptrdiff_t;
alias WordNum = ptrdiff_t;
alias CharNum = ptrdiff_t;

enum maxLines = LineNum.max;        /// (original name: p1)
enum maxWordsPerLine = WordNum.max; /// (original name: p2)
enum maxCharsPerWord = CharNum.max; /// (original name: p3)


/// Returns one character from a given word at a given line number.
/// (original name: WORD)
char wordChar(LineNum lineNum, WordNum wordNum, CharNum charNum)
{
    assert(lineNum >= 0 && lineNum < maxLines);
    assert(lineNum < numLines);
    assert(wordNum >= 0 && wordNum < maxWordsPerLine);
    assert(wordNum < numWords(lineNum));
    assert(charNum >= 0 && charNum < maxCharsPerWord);
    assert(charNum < numCharacters(lineNum, wordNum));

    return wordsForLine(lineNum)
        .dropExactly(wordNum)
        .front
        .dropExactly(charNum)
        .front;
}

/// Sets the next character for the current or the next word.
/// The current word is the last word present at the last line.
/// (original name: SETWRD)
void setWordChar(LineNum lineNum, WordNum wordNum, CharNum charNum, char charValue)
{
    assert(lineNum >= 0 && lineNum < maxLines);
    assert(lineNum == numLines-1 || lineNum == numLines);
    assert(wordNum >= 0 && wordNum < maxWordsPerLine);
    assert(charNum >= 0 && charNum < maxCharsPerWord);

    if(lineNum < numLines)
    {
        auto nw = numWords(lineNum);
        assert(wordNum == nw-1 || wordNum == nw);

        if(wordNum < nw)
        {
            assert(charNum == numCharacters(lineNum, wordNum));
        }
    }
    
    if(lineNum == numLines)
    {
        lineIndex ~= data.length;
    }
    else
    {
        if(wordNum == numWords(lineNum))
        {
            data ~= wordSeparator;
        }    
    }
    
    data ~= charValue;
}

/// Returns the number of lines currently being stored in memory.
/// (original name: LINES)
LineNum numLines()
{
    return lineIndex.length;
}

/// Returns the number of words currently being stored in memory.
/// (original name: WORDS)
LineNum numWords(LineNum lineNum)
{
    assert(lineNum >= 0 && lineNum < maxLines);
    assert(lineNum < numLines);

    return wordsForLine(lineNum).walkLength;
}

/// Returns the number of characters in a word.
/// (original name: CHARS)
CharNum numCharacters(LineNum lineNum, WordNum wordNum)
{
    assert(lineNum >= 0 && lineNum < numLines);
    assert(wordNum >= 0 && wordNum < numWords(lineNum));

    return wordsForLine(lineNum).drop(wordNum).front.length;
}

/// Removes a word from a line
/// (original name: DELWRD)
void removeWord(LineNum lineNum, WordNum wordNum)
{
    assert(lineNum >= 0 && lineNum < numLines);
    assert(wordNum >= 0 && wordNum < numWords(lineNum));
    assert(numWords(lineNum) != 1);
    
    assert(false, "not implemented");
}

/// Removes a line
/// (original name: DELINE)
void removeLine(LineNum lineNum)
{
    assert(lineNum >= 0 && lineNum < numLines);

    assert(false, "not implemented");
}

// --

private:

enum wordSeparator = ' ';

char[] data;
CharNum[] lineIndex;

auto line(LineNum lineNum)
{
    auto lineStart = lineIndex[lineNum];
    auto lineEnd = lineNum+1 >= lineIndex.length ? data.length : lineIndex[lineNum+1];

    return data[lineStart .. lineEnd].byCodeUnit;
}

/// Returns a range of words for a given line
auto wordsForLine(LineNum lineNum)
{
    return line(lineNum).splitter(wordSeparator);
}