/*
* Melody Yin
* September 19, 2022
* This program asserts 4 letters and then generates all possible anagrams of them (unique
* by position)
*/

; reset conditions to default
(clear)
(reset)

; create template & assert values
(deftemplate Letter (slot c) (slot p))

(assert (Letter (c D) (p 1)))
(assert (Letter (c A) (p 2)))
(assert (Letter (c C) (p 3)))
(assert (Letter (c A) (p 4)))

; rule: repeatedly pick a Letter (identified by unique position, not actual character) and then print
;   out the Letters strung together
(defrule rule-2 "Enumerate pairs of unique letters"
    (Letter (c ?c1) (p ?p1)) (Letter (c ?c2) (p ?p2 &~?p1)) (Letter (c ?c3) (p ?p3 &~?p2 &~?p1)) (Letter (c ?c4) (p ?p4 &~?p3 &~?p2 &~?p1))
=>
    (printout t ?c1 ?c2 ?c3 ?c4 " ")
)
