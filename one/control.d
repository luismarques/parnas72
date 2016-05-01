module one.control;

import one.input;
import one.circularshifter;
import one.alphabetizer;
import one.output;

public:

void run(string inputFile)
{
    readLines(inputFile);
    one.circularshifter.setup();
    one.alphabetizer.setup();
    printLines();    
}