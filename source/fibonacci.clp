/*
* Melody Yin
* August 26, 2022
* This is an implementation of the Fibonacci sequence, where the user inputs the number of Fibonacci
* number to be generated.
*/

(batch "utilities_v3.clp") ; import utilities to interact with user

/*
* This function generates a list of Fibonacci numbers with length num where num is a function
* parameter.
* Argument requirements: The variable num must be a non-negative integer.
*/

(deffunction fibo (?num)
   (bind ?fibnums (create$)) ; initialize empty list for numbers
   (bind ?fib1 1L)            ; initialize fib1/fib2
   (bind ?fib2 1L)
   
   ; for loop that repeatedly adds fib1 to fibnums & updates fib1/fib2
   (for (bind ?i 0) (< ?i ?num) (++ ?i)
      (bind ?fibnums (insert$ ?fibnums (+ 1 (length$ ?fibnums)) ?fib1)) ; insert fib1
      
      ; fib2 set to be the next fib num and fib1 set to equal fib2 
      (bind ?fib2 (+ ?fib1 ?fib2))
      (bind ?fib1 (- ?fib2 ?fib1))

   ) ; for i in [0, num)

   (return ?fibnums)

) ; def of fibo

/*
* This function takes the input and validates it (checks if it is a non-negative integer). If the
* input is valid, it will return TRUE. Otherwise, it will return FALSE.
*/

(deffunction validateinput (?input)
   (if (numberp ?input) then                     ; check if it's a number
      (if (= (integer ?input) ?input) then       ; check if it's an integer
         (if (>= ?input 0) then                  ; check if it's nonnegative
            (return TRUE)
         ); if input > 0

      ); if input is integer

   ); if input is a number

   (return FALSE)

); def of validateinput

/*
* This function uses the validateinput/fibo functions. Given num as a parameter, it will
* return FALSE if the input is not a non-negative integer. Otherwise, it will evaluate and return
* the first num Fibonacci numbers.
*/

(deffunction fibonacci (?num)

   (if (validateinput ?num) then (return (fibo ?num)) ; if valid input, calculate fib series
      else (return FALSE)                             ; else, return false
   )

   (return)

); def of fibonacci

/*
* This function combines fibo/validateinput/fibonacci. It prompts the user for an input and then
* calls and prints the output of fibonacci.
* The user should not be inputting any number that will result in the Fibonacci numbers exceeding
* the max short representation of a number.
*/

(deffunction fib ()
   (bind ?input (askQuestion "What is your number")) ; get user input

   (if (eq (fibonacci ?input) FALSE) then (printline "invalid input! try again.") ; validate input
      else (printline (fibonacci ?input))                                         ; print fib series
   )

   (return)

); def of fibonacci