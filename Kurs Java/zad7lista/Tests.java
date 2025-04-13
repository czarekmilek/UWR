import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import structures.OrderedList;

import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

public class Tests {

    OrderedList<Integer> intList;
    OrderedList<String> stringList;
    OrderedList<Date> dateList;

    @BeforeEach
    public void setUp() {
        intList = new OrderedList<>();
        stringList = new OrderedList<>();
        dateList = new OrderedList<>();
    }

    @Test
    public void testIntegerList() {
        intList.insert(10);
        intList.insert(5);
        intList.insert(20);

        // Test size
        assertEquals(3, intList.size(), "Size should be 3");

        // Test insertion order
        assertEquals("[5, 10, 20]", intList.toString(), "List should be [5, 10, 20]");

        // Test min and max
        assertEquals(5, intList.min(), "Min should be 5");
        assertEquals(20, intList.max(), "Max should be 20");

        // Test search
        assertTrue(intList.search(10), "10 should be in the list");
        assertFalse(intList.search(15), "15 should not be in the list");

        // Test remove
        assertTrue(intList.remove(5), "10 should be removed");
        assertFalse(intList.remove(15), "15 is not in the list, so it cannot be removed");
        assertEquals("[10, 20]", intList.toString(), "List should be [5, 20] after removing 10");

        // Test at
        assertEquals(10, intList.at(0), "Element at position 0 should be 5");
        assertEquals(20, intList.at(1), "Element at position 1 should be 20");

        // Test index
        assertEquals(1, intList.index(20), "Index of 20 should be 1");

        // Test iterator
        StringBuilder iterated = new StringBuilder();
        for (Integer i : intList) {
            iterated.append(i).append(" ");
        }
        assertEquals("10 20", iterated.toString().trim(), "Iteration should produce '5 20'");
    }

    @Test
    public void testStringList() {
        stringList.insert("banana");
        stringList.insert("apple");
        stringList.insert("cherry");

        // Test size
        assertEquals(3, stringList.size(), "Size should be 3");

        // Test insertion order
        assertEquals("[apple, banana, cherry]", stringList.toString(), "List should be [apple, banana, cherry]");

        // Test min and max
        assertEquals("apple", stringList.min(), "Min should be 'apple'");
        assertEquals("cherry", stringList.max(), "Max should be 'cherry'");

        // Test search
        assertTrue(stringList.search("banana"), "'banana' should be in the list");
        assertFalse(stringList.search("date"), "'date' should not be in the list");

        // Test remove
        assertTrue(stringList.remove("banana"), "'banana' should be removed");
        assertEquals("[apple, cherry]", stringList.toString(), "List should be [apple, cherry] after removing 'banana'");
    }

    @Test
    public void testDateList() {
        Date now = new Date();
        Date yesterday = new Date(System.currentTimeMillis() - 86400000); // 1 day ago
        Date tomorrow = new Date(System.currentTimeMillis() + 86400000); // 1 day later

        dateList.insert(now);
        dateList.insert(yesterday);
        dateList.insert(tomorrow);

        // Test size
        assertEquals(3, dateList.size(), "Size should be 3");

        // Test insertion order
        assertEquals("[" + yesterday + ", " + now + ", " + tomorrow + "]",
                dateList.toString(), "List should be [" + yesterday + ", " + now + ", " + tomorrow + "]");

        // Test min and max
        assertEquals(yesterday, dateList.min(), "Min should be yesterday's date");
        assertEquals(tomorrow, dateList.max(), "Max should be tomorrow's date");

        // Test iterator
        int count = 0;
        for (Date _ : dateList) {
            count++;
        }
        assertEquals(3, count, "Iterator should iterate through all 3 elements");
    }
}
