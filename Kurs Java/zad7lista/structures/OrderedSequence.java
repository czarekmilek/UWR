package structures;

public interface OrderedSequence<T extends Comparable<T>> {
    void insert(T element);
    boolean remove(T element);
    T min();
    T max();
    boolean search(T element);
    T at(int index);
    int index(T element);
    int size();
}
