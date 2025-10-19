/*
* Melody Yin
* September 7, 2022
* This program counts the number of times each letter of the alphabet is used in a paragraph of ASCII
* text, independent of upper/lowercase, and prints out the results in alphabetical order.
* The following methods are in this module:
*    histo() - acts as the user interface
*    slice$(?input) - 'explodes' ?input into a list of characters
*    generate_histo(?input) - takes a list of characters and returns alphabetic histogram
*/

(batch "utilities_v4.clp") ; import utilities

/*
* This function provides a user interface that asks for a string/paragraph, calls a helper function
* (slice$) to calculate the alphabetic histogram, and then prints out the result in a readable format
* for the user.
*/
(deffunction histo ()
   (bind ?input (askline "Please enter a string: ")) ; get user input
   (bind ?result (generate_histo (slice$ ?input)))   ; call on helper functions to process string
   
   ; print out the histogram in a user readable format
   (for (bind ?i 1) (<= ?i (length$ ?result)) (++ ?i)
      (printline (str-cat (asciiToChar (+ 96 ?i)) " - "(nth$ ?i ?result)))
   )
   
   (return)
); deffunction histo

/*
* Takes a string as input and returns the string 'exploded' into a list of characters.
* ?input has to be a single string, returns a list of characters
*/
(deffunction slice$ (?input)
   (bind ?input_aslist (create$)) ; initialize list
   
   ; iterate through input and add each character to input_aslist
   (for (bind ?i 1) (<= ?i (str-length ?input)) (++ ?i)
      (bind ?input_aslist (append$ ?input_aslist (sub-string ?i ?i ?input)))
   )

   (return ?input_aslist)
); deffunction slice$


/*
* Takes a list of characters and then generates & returns an alphabetical histogram.
* ?input has to be a list of characters, returns a list consisting of the number of times a character
* appears
*/
(deffunction generate_histo (?input)
   (bind ?ascii (create$)) ; list for tallying up ASCII characters' appearances

   ; initialize ascii as a list of length 255 (the total number of ASCII characters)
   (for (bind ?i 1) (<= ?i 256) (++ ?i)
      (bind ?ascii (append$ ?ascii 0))
   )
   
   ; iterate through input and tally up appearances in ascii
   (for (bind ?i 1) (<= ?i (length$ ?input)) (++ ?i)
      ; calculate ASCII val of character converted to lowercase
      (bind ?temp (asc (lowcase (nth$ ?i ?input))))

      ; increment the number representing the character
      (bind ?ascii (replace$ ?ascii ?temp ?temp (+ 1 (nth$ ?temp ?ascii))))
   ) ; for i in range(1, length of input)

   ; only the part of alphabet that contains a-z is important, so remove everything else
   (bind ?ascii (subseq$ ?ascii (asc a) (asc z)))

   (return ?ascii)
); deffunction generate_histo
