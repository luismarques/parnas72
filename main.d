import std.stdio;

enum inputFile = "data.txt";

void main()
{
    decomposition1();

    writeln();
    decomposition2();

    writeln();
    idiomaticDecomposition();
}

void decomposition1()
{
    import one.control;
    run(inputFile);
}

void decomposition2()
{
    import two.control;
    run(inputFile);
}

void idiomaticDecomposition()
{
    import idiomatic;
    run(inputFile);
}