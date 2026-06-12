# Inode

**What it is** - Short for *index node* — the data structure a [[File System]] uses to represent a file. It stores metadata (size, permissions, timestamps, owner) and a pointer to the actual data blocks on disk. Importantly, it does *not* store the file name.

**Why it matters** - Separating the name from the inode is what enables hard links (multiple names pointing to the same inode), and means you can rename a file without touching any data blocks — just update the directory entry.

**Example** - When you run `ls -i` on Linux you see inode numbers. Two filenames with the same inode number are hard links to the same underlying data; deleting one does not delete the data until the last link is removed.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
