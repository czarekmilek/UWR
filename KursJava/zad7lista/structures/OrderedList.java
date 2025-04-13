package structures;

import java.util.Iterator;
import java.util.NoSuchElementException;

public class OrderedList<T extends Comparable<T>> implements OrderedSequence<T>, Iterable<T> {
    private Node<T> head;
    private int size;

    public OrderedList() {
        this.head = null;
        this.size = 0;
    }

    private class Node<T> {
        T data;
        Node<T> next;

        Node(T data) {
            if (data == null) throw new NullPointerException("Cannot add null value.");
            this.data = data;
            this.next = null;
        }
    }

    @Override
    public void insert(T element) {
        if (element == null) throw new NullPointerException("Cannot add null value.");
        Node<T> newNode = new Node<>(element);

        if (head == null || head.data.compareTo(element) > 0) {
            newNode.next = head;
            head = newNode;
        } else {
            Node<T> current = head;
            while (current.next != null && current.next.data.compareTo(element) < 0) {
                current = current.next;
            }
            if (current.data.compareTo(element) == 0) throw new IllegalArgumentException("Element already exists.");
            newNode.next = current.next;
            current.next = newNode;
        }
        size++;
    }

    @Override
    public boolean remove(T element) {
        if (head == null) return false;
        if (head.data.equals(element)) {
            head = head.next;
            size--;
            return true;
        }
        Node<T> current = head;
        while (current.next != null && !current.next.data.equals(element)) {
            current = current.next;
        }

        if (current.next == null) return false;
        current.next = current.next.next;
        size--;
        return true;
    }

    @Override
    public T min() {
        if (head == null) throw new NoSuchElementException("List is empty.");
        return head.data;
    }

    @Override
    public T max() {
        if (head == null) throw new NoSuchElementException("List is empty.");
        Node<T> current = head;
        while (current.next != null) {
            current = current.next;
        }
        return current.data;
    }

    @Override
    public boolean search(T element) {
        Node<T> current = head;
        while (current != null) {
            if (current.data.equals(element)) return true;
            current = current.next;
        }
        return false;
    }

    @Override
    public T at(int pos) {
        if (pos < 0 || pos >= size) throw new IndexOutOfBoundsException("Invalid index.");
        Node<T> current = head;
        for (int i = 0; i < pos; i++) {
            current = current.next;
        }
        return current.data;
    }

    @Override
    public int index(T element) {
        Node<T> current = head;
        int pos = 0;
        while (current != null) {
            if (current.data.equals(element)) return pos;
            current = current.next;
            pos++;
        }
        throw new NoSuchElementException("Element was not found.");
    }

    @Override
    public int size() {
        return size;
    }

    @Override
    public Iterator<T> iterator() {
        return new OrderedListIterator();
    }

    private class OrderedListIterator implements Iterator<T> {
        private Node<T> current = head;
        private Node<T> lastReturned = null;

        @Override
        public boolean hasNext() {
            return current != null;
        }

        @Override
        public T next() {
            if (!hasNext()) throw new NoSuchElementException("No next element.");
            lastReturned = current;
            T data = current.data;
            current = current.next;
            return data;
        }

        @Override
        public void remove() {
            if (lastReturned == null) throw new IllegalStateException("Cannot delete before next().");
            OrderedList.this.remove(lastReturned.data);
            lastReturned = null;
        }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("[");
        Node<T> current = head;
        while (current != null) {
            sb.append(current.data);
            if (current.next != null) sb.append(", ");
            current = current.next;
        }
        sb.append("]");
        return sb.toString();
    }
}
