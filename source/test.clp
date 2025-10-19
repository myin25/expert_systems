(assert (bob 1))
(assert (bob 2))
(assert (bob 3))
(assert (bob 4))


/*
** This rule shows how to match an OR condition within a pattern without using the (OR) operator
*/
(defrule bobORrule "Prints only if the pattern (bob 1) or (bob 2) exists using |"
   (bob ?x & 1 | 2)
=>
   (printout t "bob 1 OR 2 : " ?x crlf)
)