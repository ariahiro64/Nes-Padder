module app;

import std.file;
import std.path;
import core.stdc.stdio : getchar;
import std.stdio : writeln;


void main(string[] args)
{	

	/* Directory info and create missing directories */
	auto appDir = dirName(thisExePath);
	auto prePadDir = appDir ~ "/prePad/";
	auto postPadDir = appDir ~ "/postPad/";
	
	if (!exists(prePadDir)) 
	{	
		writeln("Making directories, Please put your roms in the new prePad directory and run again.");
		mkdir(prePadDir);
	}
	else
	if (dirEmpty(prePadDir))
	{
		writeln("I worry about you sometimes...");
		writeln("Place Your roms in the prePad folder!");
		writeln("Press enter To exit.");
    	int a = getchar();
	}
	if (!exists(postPadDir)) 
	{	
		mkdir(postPadDir);
		writeln("Press enter To exit.");
    	int a = getchar();
	}
	foreach (string name; dirEntries(prePadDir, SpanMode.depth)) {
		/* Load the file */
		auto bin = cast(ubyte[]) read(name);

        /* Init our new Padded file */
        size_t newSize = getPadSize(bin.sizeof);
        auto newBin = bin.dup ~ (new ubyte[newSize-bin.sizeof + 1]);
		
		/* Save the padded file */
		write(postPadDir ~ baseName(name), newBin);
		writeln("sucessfully padded ", name);
	}
}

size_t getPadSize(size_t preSize)
{
    if ((preSize & 0xFFFF) > 0xF)
        return (preSize & 0xFFFF0000) + 0xFFFF;
    else
        return (preSize & 0xFFFF000);
}

bool dirEmpty(string dirname) {
    if (!exists(dirname) || !isDir(dirname))
        throw new Exception("dir not found: " ~ dirname);
    return dirEntries(dirname, SpanMode.shallow).empty;
}