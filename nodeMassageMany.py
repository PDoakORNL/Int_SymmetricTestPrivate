import sys
import os

if __name__ == '__main__':
    accts = {}
    acctcount=0
    print "in nodeMassageMany.py"
    for file in sys.argv[1:]:
        print file
        tracks = []
        count=0
        outfile="fixed_" + os.path.basename(file)
        of = open(outfile, 'w') 
        with open(file,'r') as f:
            of.write("{}".format(f.readline()))
            for line in f.readlines():
                tracks.append(line.split())
        frequency = {}
        for rec in tracks:
            if len(rec) < 3:
                rec.insert(1,[300,300])
            if rec[2] in frequency:
                frequency[rec[2]]+=1
            else:
                frequency[rec[2]]=1

            #fix for missing fields?
            while len(rec) < 4:
                rec.append("Unknown")

            if rec[3] not in accts:
                accts[rec[3]]=acctcount
                acctcount+=1

        previousJob=0
        nodeCount=1
        for rec in tracks:
            if previousJob != rec[2]:
                of.write("{} {} {} {} {} {} {} {}\n".format(nodeCount,
                                                          rec[0],
                                                          rec[1],
                                                          rec[2],
                                                          frequency[rec[2]],
                                                          count,
                                                          rec[3],
                                                          accts[rec[3]]))
#                print nodeCount, rec[0], rec[1], rec[2], frequency[rec[2]],count, rec[3], accts[rec[3]]
                nodeCount+=frequency[rec[2]]
                previousJob = rec[2]
                count+=1
                count = count %10

        of.close()
