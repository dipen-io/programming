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
        int number = random.nextInt(10) + 1;
        return number;
    }

    // method that play game 
    public static void playGame(int secretNumber) {

        System.out.println("========Guesing an number between 1 to 10\n");
        Scanner scanner = new Scanner(System.in);
       
        int guess = 0;
        int attempts = 0;


        while( guess != secretNumber) {

            System.out.println("Enter a number ");
            guess = scanner.nextInt();
            attempts ++;

        printFeedback(guess, attempts, secretNumber);

            // if ( guess < secretNumber) {
            //     System.out.println("Too Low");
            // } else if (guess > secretNumber) {
            //     System.out.println("TOO Big");
            // } else {
            //     System.out.println("You guess it right in " + attempts + " attempts");
            // }
        }
        scanner.close();
    }
    public static void printFeedback(int guess, int attempts, int secretNumber) {
         if ( guess < secretNumber) {
                System.out.println("Too Low");
                System.out.println("===================");
            } else if (guess > secretNumber) {
                System.out.println("TOO Big");
                System.out.println("===================");
            } else {
                System.out.println("You guess it right in bro" + attempts + " attempts");
            }
    }
}