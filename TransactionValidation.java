package org.java.qa;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;
import java.util.Scanner;

public class TransactionValidation {

    static Set<String> transactionIds = new HashSet<>();

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        BigDecimal balance = new BigDecimal("50000.00");

        System.out.println("=== Transaction Validation ===");

        System.out.print("Enter Transaction ID: ");
        String id = sc.nextLine().trim();

        System.out.print("Enter Account Number: ");
        String account = sc.nextLine().trim();

        System.out.print("Enter Transaction Type (DEPOSIT/WITHDRAWAL): ");
        String type = sc.nextLine().trim().toUpperCase();

        System.out.print("Enter Amount: ");
        String input = sc.nextLine().trim();

        BigDecimal amount;

        try {
            amount = new BigDecimal(input);
        } catch (NumberFormatException e) {
            System.out.println("Invalid amount!");
            sc.close();
            return;
        }

        String error = validate(id, account, type, amount, balance);

        if (error != null) {
            System.out.println("Transaction Failed: " + error);
        } else {
            transactionIds.add(id);

            if (type.equals("DEPOSIT")) {
                balance = balance.add(amount);
            } else {
                balance = balance.subtract(amount);
            }

            System.out.println("\nTransaction Successful!");
            System.out.println("Transaction ID: " + id);
            System.out.println("Transaction Type: " + type);
            System.out.println("Amount: Rs. " + amount);
            System.out.println("Updated Balance: Rs. " + balance);
        }

        sc.close();
    }

    static String validate(String id, String account,
                           String type, BigDecimal amount,
                           BigDecimal balance) {

        if (id.isEmpty()) {
            return "Transaction ID cannot be empty.";
        }

        if (transactionIds.contains(id)) {
            return "Duplicate transaction ID.";
        }

        if (!account.matches("\\d{10,18}")) {
            return "Account number must contain 10-18 digits.";
        }

        if (!type.equals("DEPOSIT")
                && !type.equals("WITHDRAWAL")) {
            return "Invalid transaction type.";
        }

        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            return "Amount must be greater than zero.";
        }

        if (amount.scale() > 2) {
            return "Amount cannot have more than 2 decimal places.";
        }

        if (amount.compareTo(new BigDecimal("100000")) > 0) {
            return "Amount exceeds the maximum limit of Rs. 100000.";
        }

        if (type.equals("WITHDRAWAL")
                && amount.compareTo(balance) > 0) {
            return "Insufficient balance.";
        }

        return null;
    }
}
