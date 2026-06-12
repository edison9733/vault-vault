# File System

**What it is** - The software layer that translates a raw disk (which is physically just a long sequence of numbered blocks) into the familiar tree of named files and folders. Common file systems include ext4 (Linux), NTFS (Windows), and APFS (macOS).

**Why it matters** - Without a file system, programs would have to track raw block numbers. The file system abstracts this into human-readable names and handles crash recovery via *journaling* — writing intentions before writing data so power loss doesn't corrupt files.

**Example** - Files are stored as [[Inode]]s; the file *name* lives in a directory entry that points to the inode number, not inside the inode itself — which is why you can have multiple filenames pointing to the same underlying file (hard links).

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
