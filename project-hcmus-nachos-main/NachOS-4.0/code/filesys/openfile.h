// openfile.h
//	Data structures for opening, closing, reading and writing to
//	individual files.  The operations supported are similar to
//	the UNIX ones -- type 'man open' to the UNIX prompt.
//
//	There are two implementations.  One is a "STUB" that directly
//	turns the file operations into the underlying UNIX operations.
//	(cf. comment in filesys.h).
//
//	The other is the "real" implementation, that turns these
//	operations into read and write disk sector requests.
//	In this baseline implementation of the file system, we don't
//	worry about concurrent accesses to the file system
//	by different threads.
//
// Copyright (c) 1992-1993 The Regents of the University of California.
// All rights reserved.  See copyright.h for copyright notice and limitation
// of liability and disclaimer of warranty provisions.

#ifndef OPENFILE_H
#define OPENFILE_H

#include "copyright.h"
#include "utility.h"
#include "sysdep.h"

#ifdef FILESYS_STUB 

class OpenFile
{
public:
	int type;
	OpenFile(int f)
	{
		file = f;
		currentOffset = 0;
		type = 0;
	}
	OpenFile(int f, int t)
	{
		file = f;
		currentOffset = 0;
		type = t;
	}
	~OpenFile() { Close(file); }

	int Seek(int pos)
	{
		Lseek(file, pos, 0);
		currentOffset = Tell(file);
		return currentOffset;
	}

	int ReadAt(char *into, int numBytes, int position)
	{
		Lseek(file, position, 0);
		return ReadPartial(file, into, numBytes);
	}
	int WriteAt(char *from, int numBytes, int position)
	{
		Lseek(file, position, 0);
		WriteFile(file, from, numBytes);
		return numBytes;
	}
	int Read(char *into, int numBytes)
	{
		int numRead = ReadAt(into, numBytes, currentOffset);
		currentOffset += numRead;
		return numRead;
	}
	int Write(char *from, int numBytes)
	{
		int numWritten = WriteAt(from, numBytes, currentOffset);
		currentOffset += numWritten;
		return numWritten;
	}

	int Length()
	{
		int len;
		Lseek(file, 0, 2);
		len = Tell(file);
		Lseek(file, currentOffset, 0);
		return len;
	}
	int GetCurrentPos()
	{
		currentOffset = Tell(file);
		return currentOffset;
	}

private:
	int file;
	int currentOffset;
};

#else // FILESYS
class FileHeader;

class OpenFile {
  public:
  	int type; 
    OpenFile(int sector);
    OpenFile(int sector, int type);	
    ~OpenFile();
    void Seek(int position);
    int Read(char *into, int numBytes);
    int Write(char *from, int numBytes);
    int ReadAt(char *into, int numBytes, int position);
    int WriteAt(char *from, int numBytes, int position);
    int Length();
    int GetCurrentPos()
	{
		return seekPosition;
	}
    
  private:
    FileHeader *hdr;
    int seekPosition;
};

#endif // FILESYS

#endif // OPENFILE_H
