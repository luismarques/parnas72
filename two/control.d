module two.control;

import two.input;
import two.circularshifter;
import two.alphabetizer;
import two.output;

public:

void run(string inputFile)
{
    readLines(inputFile);
    two.circularshifter.setup();
    two.alphabetizer.setup();
    printLines();
}