import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
public class OrderedList<T extends Comparable<T>> {
    private List<T> list;

    public OrderedList() {
        this.list = new ArrayList<>();
    }

    public void addElement(T elem) {
        list.add(elem);
        Collections.sort(list);
    }

    public T getFirst() {
        if (list.isEmpty()) {
            return null;
        }
        return list.get(0);
    }

    @Override
    public String toString() {
        return list.toString();
    }
}