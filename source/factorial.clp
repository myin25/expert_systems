/*
* Melody Yin
* August 25, 2022
* This file implements factorial in two functions and also a user interface that asks for a number 
* from a user.
*/

(batch "utilities_v2.clp") ; import utilities to interact with user

/*
* This helper function recursively calculates the factorial of a given number num by calling itself with
* num - 1 as input and multiplying that with num.
* Argument requirements: The variable num must be a non-negative integer.
*/
(deffunction fact (?num) 
   (if (<= ?num 1) then (return 1)         ; if num = 0 or it reaches 1, return its value 
    else (return (* ?num (fact (-- ?num)))) ; return num * fact(num - 1)
   ); if num <= 1
); definition of fact(?num)


/*
* This 'front end' function acts as the user interface by asking the user for input and then feeding it into
* the fact function to calculate the factorial.
*/
(deffunction factorial ()
   (bind ?num (askQuestion "What is your number")) ; ask for user's number, bind to 'num'

   (if (numberp ?num) then                     ; check if num is a number
      (if (= (integer ?num) ?num) then         ; check if num is an integer
         (if (>= ?num 0) then                  ; check if num is >= 0
            (bind ?result (fact (long (integer ?num))))
          else (printline "num < 0")
         ) ; if num > 0

       else (printline "that isn't an integer")
      ); if num is integer

    else (printline "not a number")
   ); if num is a number

   (return)

); definition of factorial()
