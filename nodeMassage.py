import sys

if __name__ == '__main__':
    tracks = []
    with open(sys.argv[1],'r') as f:
        for line in f.readlines():
            tracks.append(line.split())
    frequency = {}
    accts = {}
    acctcount=0
    for rec in tracks:
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
    count=0
    for rec in tracks:
        if previousJob != rec[2]:
            print nodeCount, rec[0], rec[1], rec[2], frequency[rec[2]],count, rec[3], accts[rec[3]]
            nodeCount+=frequency[rec[2]]
            previousJob = rec[2]
            count+=1
            count = count %10
