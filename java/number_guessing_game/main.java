import java.util.Scanner;
import java.util.Random;

class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();

        int secretNumber = random.nextInt(100) + 1; // 1 to 100
        int guess = 0;
        int attempts = 0;

        System.out.println("I'm thinking  of a number between 1 and 100!");

        while(guess != secretNumber) {
            System.out.print("Enter your guess: ");
            guess = scanner.nextInt();
            attempts++;
        

            if(guess < secretNumber) {
                System.out.println("Too low!");
            } else if(guess > secretNumber) {
                System.out.println("Too high!");
            } else {
                System.out.println("You got it in " + attempts + " attempts");
            }
        }
        scanner.close();
    }
}