import java.util.Scanner;
import java.util.Random;

class GuessingGame {

    public static void main(String [] args) {
        int secretNumber  = generateSecretNumber();
        playGame(secretNumber);
    }

    // Method that generate secret number and return secretNumber
    public static int generateSecretNumber() {
        Random random = new Random();
        int number = random.nextInt(100) + 1;
        return number;
    }

    // method that play game 
    public static void playGame(int secretNumber) {
        Scanner scanner = new Scanner(System.in);
       
        int guess = 0;
        int attempts = 0;

        while( guess != secretNumber) {
            
            System.out.println("Enter a number ");
            guess = scanner.nextInt();
            attempts ++;

            if ( guess < secretNumber) {
                System.out.println("Too Low");
            } else if (guess > secretNumber) {
                System.out.println("TOO Big");
            } else {
                System.out.println("You guess it right in " + attempts + " attempts");
            }
        }
        scanner.close();
    }
}