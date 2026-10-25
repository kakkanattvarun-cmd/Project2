package org.java.qa;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

/** DR704 Part C: Array, String, ArrayList, HashSet, and HashMap practice. */
public class ProjectCoreJava {
    public static void main(String[] args) {
        // ARRAY: store and print five numbers; find the largest.
        int[] numbers = {18, 42, 7, 96, 31};
        System.out.println("=== Array ===");
        System.out.println("Numbers: " + Arrays.toString(numbers));
        int largest = numbers[0];
        for (int number : numbers) {
            if (number > largest) largest = number;
        }
        System.out.println("Largest number: " + largest);

        // STRING: full name length and whether it contains "Java".
        System.out.println("\n=== String ===");
        String fullName = "Aarav Sharma";
        String topic = "Learning Java for QA";
        System.out.println("Full name: " + fullName);
        System.out.println("Length of full name: " + fullName.length());
        System.out.println("Does topic contain Java? " + topic.contains("Java"));

        // ARRAYLIST: add five names, print, remove one, print updated list.
        System.out.println("\n=== ArrayList ===");
        ArrayList<String> students = new ArrayList<>(Arrays.asList(
                "Aditi", "Rahul", "Neha", "Arjun", "Priya"));
        System.out.println("Student names: " + students);
        students.remove("Neha");
        System.out.println("After removing Neha: " + students);

        // HASHSET: add five cities, then add a duplicate.
        System.out.println("\n=== HashSet ===");
        HashSet<String> cities = new HashSet<>(Arrays.asList(
                "Mumbai", "Pune", "Delhi", "Kochi", "Jaipur"));
        System.out.println("Cities: " + cities);
        cities.add("Mumbai");
        System.out.println("After adding duplicate Mumbai: " + cities);
        System.out.println("Note: HashSet stores unique values; iteration order is not guaranteed.");

        // HASHMAP: map five student IDs to names and look up one ID.
        System.out.println("\n=== HashMap ===");
        Map<Integer, String> studentById = new HashMap<>();
        studentById.put(1001, "Aditi");
        studentById.put(1002, "Rahul");
        studentById.put(1003, "Neha");
        studentById.put(1004, "Arjun");
        studentById.put(1005, "Priya");
        System.out.println("Student ID map: " + studentById);
        int searchId = 1003;
        System.out.println("Name for ID " + searchId + ": " + studentById.get(searchId));
    }
}


