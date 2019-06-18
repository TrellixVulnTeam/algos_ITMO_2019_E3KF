def heappush(heap, item):
    heap.append(item)
    siftdown(heap, 0, len(heap)-1)

def heappop(heap):
    """Pop the smallest item off the heap, maintaining the heap invariant."""
    lastelt = heap.pop()    # raises appropriate IndexError if heap is empty
    if heap:
        returnitem = heap[0]
        heap[0] = lastelt
        siftup(heap, 0)
        return returnitem
    return lastelt

def siftup(heap, pos):
    endpos = len(heap)
    startpos = pos
    newitem = heap[pos]
    # Bubble up the smaller child until hitting a leaf.
    childpos = 2*pos + 1    # leftmost child position
    while childpos < endpos:
        # Set childpos to index of smaller child.
        rightpos = childpos + 1
        if rightpos < endpos and not heap[childpos] < heap[rightpos]:
            childpos = rightpos
        # Move the smaller child up.
        heap[pos] = heap[childpos]
        pos = childpos
        childpos = 2*pos + 1
    # The leaf at pos is empty now.  Put newitem there, and bubble it up
    # to its final resting place (by sifting its parents down).
    heap[pos] = newitem
    siftdown(heap, startpos, pos)

def siftdown(heap, startpos, pos):
    newitem = heap[pos]
    # Follow the path to the root, moving parents down until finding a place
    # newitem fits.
    while pos > startpos:
        parentpos = (pos - 1) >> 1
        parent = heap[parentpos]
        if newitem < parent:
            heap[pos] = parent
            pos = parentpos
            continue
        break
    heap[pos] = newitem

def main():
    heap = []
    fo= open("output.txt","w")
    fi = open('input.txt', 'r')
    n = int(fi.readline())
    arr = [0]*(10**6)
    for i in range(0, n):
        inp = fi.readline().split()
        if inp[0] == 'A':
            p = int(inp[1])
            heappush(heap, p)
            arr[i] = p
        elif inp[0] == 'X':
            if len(heap)==0:
                fo.write("*\n")
                continue
            pop = heappop(heap)
            # fo.writeln(str(pop))
            fo.write(str(pop))
            fo.write("\n")
            # TODO
        elif inp[0] == 'D':
            p = int(inp[1])
            oldNum = arr[p-1]
            newNum = int(inp[2])
            arr[p-1] = newNum
            ind = heap.index(oldNum)
            heap[ind] = newNum
            # heapq._siftdown(heap, 0, ind)
            # heapq._siftup(heap, ind)
            siftdown(heap, 0, ind)
        else:
            print(inp)

if __name__ == "__main__":
    main()