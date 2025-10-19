/*
* Melody Yin
* September 22, 2022
* This program asserts 5 letters (given by user's input) and then generates all possible 
* anagrams of them (unique by position)
*/

; reset conditions to default
(clear)
(reset)

; import utilities
(batch "utilities_v4.clp")

; create template for asserting values
(deftemplate Letter (slot c) (slot p))


/**************************************
* functions
*/

; function: takes in user input of fixed length 5 and returns it as a list
(deffunction userInterface ()
   (bind ?input (askline "Please enter a string of length 5: "))
   
   (return ?input)
); userInterface function

; function: validates user input (checks to see if the input length is exactly 5)
(deffunction validateInput (?input)
   (return (= (str-length ?input) 5))
)

; function: Takes a string as input and returns the string 'exploded' into a list of characters.
; ?input has to be a single string, returns a list of characters
(deffunction slice$ (?input)
   (bind ?input_aslist (create$)) ; initialize list
   
   ; iterate through input and add each character to input_aslist
   (for (bind ?i 1) (<= ?i (str-length ?input)) (++ ?i)
      (bind ?input_aslist (append$ ?input_aslist (sub-string ?i ?i ?input)))
   )

   (return ?input_aslist)
); deffunction slice$

; function: calls the assertLetter function for each letter in input
(deffunction assertLetters (?input)
   ; iterate through each character
   (for (bind ?i 1) (<= ?i 5) (++ ?i)
      (assertLetter (nth$ ?i ?input) ?i)
   )

   (return)
); assertLetters function

; function: given a letter and a position, asserts a new Letter with c = letter and p = position
(deffunction assertLetter(?letter ?position)
   (assert (Letter (c ?letter) (p ?position)))
   (return)
); assertLetter function


/**************************************
* rules
*/

; rule: fetches user input and calls helper to assert letters
(defrule rule-1 "Enumerate letters"
   =>
   (bind ?input (userInterface))
   (if (validateInput ?input) then (assertLetters (slice$ ?input))
    else (printline "Input not length 5"))
); rule-1

; rule: repeatedly pick a Letter (identified by unique position, not actual character) and then print
;   out the Letters strung together
(defrule rule-2 "Enumerate pairs of unique letters"
   (Letter (c ?c1) (p ?p1))
   (Letter (c ?c2) (p ?p2 &~?p1))
   (Letter (c ?c3) (p ?p3 &~?p1 &~?p2)) 
   (Letter (c ?c4) (p ?p4 &~?p1 &~?p2 &~?p3))
   (Letter (c ?c5) (p ?p5 &~?p1 &~?p2 &~?p3 &~?p4))
=>
    (printout t ?c1 ?c2 ?c3 ?c4 ?c5 " ")
); rule-2
