/*
* Melody Yin
* September 30, 2022
* This program asserts a variable number of letters (given by user's input) and then generates
* all possible anagrams of them (unique by position)
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

; function: takes in user input and returns it
(deffunction userInterface ()
   (bind ?input (askline "Please enter a string (under length 11 to not crash JESS): "))
   (return ?input)
); userInterface function

; function: Takes a string as input and returns the string 'exploded' into a list of characters.
; ?input has to be a single string
(deffunction slice$ (?input)
   (bind ?input_aslist (create$)) ; initialize list
   
   ; iterate through each of input's characters and add each to input_aslist
   (for (bind ?i 1) (<= ?i (str-length ?input)) (++ ?i)
      (bind ?input_aslist (append$ ?input_aslist (sub-string ?i ?i ?input)))
   )

   (return ?input_aslist)
); deffunction slice$

; function: calls the assertLetter function for each letter in input
(deffunction assertLetters (?input)
   ; iterate through each character
   (for (bind ?i 1) (<= ?i (length$ ?input)) (++ ?i)
      (assertLetter (nth$ ?i ?input) ?i)
   )

   (return)
); assertLetters function

; function: given a letter and a position, asserts a new Letter with c = letter and p = position
(deffunction assertLetter(?letter ?position)
   (assert (Letter (c ?letter) (p ?position)))
   (return)
); assertLetter function

; function: given a number i, generates and returns an assertion using the Letter template
;    The assertion isn't actually used yet - it's returned as a string.
;    This string will be part of the LHS of rule-2.
;    An example of the structure of the string returned if ?i = 4:
;       (Letter (c ?c4) (p ?p4 &~?p1 &~?p2 &~?p3)).
;    As ?i changes, the values immediately after ?c and ?p will change, along with the number of 
;    conditions following ?pi.
(deffunction iToString1 (?i)
   ; three sections of strings that will always make up the structure of a Letter assertion:
   ;    the beginning of the Letter assertion + the beginning of the character condition, the 
   ;    position requirements, and finally the closing parentheses
   (bind ?cToWrite1 "(Letter (c ?c")
   (bind ?cToWrite2 ") (p ?p")
   (bind ?cToWrite3 "))")

   ; binds "(Letter (c ?ci) (p ?pi" to output
   (bind ?output "")
   (bind ?output (str-cat ?output ?cToWrite1 ?i ?cToWrite2 ?i))

   ; adds in all the other conditions (excluding characters based on their positions)
   (for (bind ?j 1) (< ?j ?i) (++ ?j)
      (bind ?output (str-cat ?output " &~?p" ?j))
   )

   ; adds the ending parentheses
   (bind ?output (str-cat ?output ?cToWrite3))

   (return ?output)
); iToString1

; function: given a value i, generates printout statement.
;    This string will make up the RHS of rule-2. 
;    An example of the structure of the string returned if ?i = 4:
;       (printout t ?c1 ?c2 ?c3 ?c4 " ").
;    As ?i increases, the number of characters getting printed out increases as well, since
;    the input length has to match with the outputted anagrams' lengths.
(deffunction iToString2 (?i)
   ; two sections of strings that will remain constant: the beginning of the command and
   ;    " ", which will print the output with spaces in between each anagram.
   (bind ?cToWrite1 "(printout t")
   (bind ?cToWrite2 " \" \" )")

   ; initialize output as the beginning portion of the printout statement
   (bind ?output "")
   (bind ?output (str-cat ?output ?cToWrite1))

   ; print out each character
   (for (bind ?j 1) (<= ?j ?i) (++ ?j)
      (bind ?output (str-cat ?output " ?c" ?j))
   )

   ; add the closing parentheses
   (bind ?output (str-cat ?output ?cToWrite2))

   (return ?output)
); iToString2

; function: dynamically builds a rule and then executes it, depending on the length of
;    the string input by the user
(deffunction buildRule2 (?i)
   (bind ?rule2 "")
   (bind ?rule2 (str-cat ?rule2 "(defrule rule-2"))

   ; LHS of the rule
   (for (bind ?j 1) (<= ?j ?i) (++ ?j)
      (bind ?rule2 (str-cat ?rule2 (iToString1 ?j)))
   )

   (bind ?rule2 (str-cat ?rule2 " => "))

   ; RHS of the rule
   (bind ?rule2 (str-cat ?rule2 (iToString2 ?i)))

   (bind ?rule2 (str-cat ?rule2 ")"))

   (return ?rule2)
); buildRule2

/**************************************
* rules
*/

; rule: fetches user input, calls helper to assert letters, and then calls on helper function
;    to dynamically build a rule-2 that will generate all anagrams
;    No LHS, so it executes every time (reset) and then (run) is called.
(defrule rule-1 "Enumerate letters"
   =>
   (bind ?input (userInterface))
   (assertLetters (slice$ ?input))
   (build (buildRule2 (str-length ?input)))
); rule-1
