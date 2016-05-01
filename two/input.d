module two.input;

import std.stdio;
import std.uni;
import two.linestorage;

public:

void readLines(string inputFile)
{
    LineNum lineNum;

    foreach(line; File(inputFile).byLine)
    {
        WordNum wordNum;
        CharNum charNum;
        bool incWordNum;
        bool incLineNum;

        foreach(c; line)
        {
            if(c.isWhite)
            {
                incWordNum = true;
            }
            else
            {
                if(incWordNum)
                {
                    wordNum++;
                    charNum = 0;
                    incWordNum = false;
                }

                setWordChar(lineNum, wordNum, charNum, c); 
                charNum++;
                incLineNum = true;
            }
        }

        if(incLineNum)
        {
            lineNum++;
            incLineNum = false;
        }
    }
}