/*
* Melody Yin
* September 19, 2022
* This program asserts 11 letters and then ATTEMPTS to generate all possible anagrams of them (unique
* by position)
*/

; reset conditions to default
(clear)
(reset)

; create template & assert values
(deftemplate Letter (slot c) (slot p))

(assert (Letter (c A) (p 1)))
(assert (Letter (c B) (p 2)))
(assert (Letter (c C) (p 3)))
(assert (Letter (c D) (p 4)))
/* (assert (Letter (c E) (p 5)))
(assert (Letter (c F) (p 6)))
(assert (Letter (c G) (p 7)))
(assert (Letter (c H) (p 8)))
(assert (Letter (c I) (p 9)))
(assert (Letter (c J) (p 10)))
(assert (Letter (c K) (p 11)))*/

; rule: repeatedly pick a Letter (identified by unique position, not actual character) and then print
;   out the Letters strung together
(defrule rule-2 "Enumerate pairs of unique letters"
   (Letter (c ?c1) (p ?p1))
   (Letter (c ?c2) (p ?p2 &~?p1))
   (Letter (c ?c3) (p ?p3 &~?p1 &~?p2)) 
   (Letter (c ?c4) (p ?p4 &~?p1 &~?p2 &~?p3))
   /*(Letter (c ?c5) (p ?p5 &~?p1 &~?p2 &~?p3 &~?p4))
   (Letter (c ?c6) (p ?p6 &~?p1 &~?p2 &~?p3 &~?p4 &~?p5))
   (Letter (c ?c7) (p ?p7 &~?p1 &~?p2 &~?p3 &~?p4 &~?p5 &~?p6))
   (Letter (c ?c8) (p ?p8 &~?p1 &~?p2 &~?p3 &~?p4 &~?p5 &~?p6 &~?p7))
   (Letter (c ?c9) (p ?p9 &~?p1 &~?p2 &~?p3 &~?p4 &~?p5 &~?p6 &~?p7 &~?p8))
   (Letter (c ?c10) (p ?p10 &~?p1 &~?p2 &~?p3 &~?p4 &~?p5 &~?p6 &~?p7 &~?p8 &~?p9))
   (Letter (c ?c11) (p ?p11 &~?p1 &~?p2 &~?p3 &~?p4 &~?p5 &~?p6 &~?p7 &~?p8 &~?p9 &~?p10))*/
=>
    (printout t ?c1 ?c2 ?c3 ?c4 /*?c5 ?c6 ?c7 ?c8 ?c9 ?c10 ?c11*/" ")
)
