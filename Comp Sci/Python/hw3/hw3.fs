// Problem 1
let rec sumEven list =
     match list with
     | [] -> 0
     | hd :: tl -> 
        if ( hd % 2 = 0) then 
            hd + sumEven tl 
        else 
            sumEven tl
        
// Problem 2
let isValidTable constraints assignments =

    let rec exist f = function
        | [] -> false
        | h::t -> f h || exist f t

    let rec loop constr assignment =
        match constr with
        | [] -> true
        | hd :: tl -> 
            if ((exist (fun elem -> elem = (fst hd)) assignment) && (exist (fun elem -> elem = (snd hd)) assignment)) then false
            else
                loop tl assignment

    if ((assignments = [] || constraints = [] || loop constraints assignments = false)) then
        if (assignments = [] || constraints = []) then
            true
        else
            false
    else
        true

// Problem 3
let rec getClosestPair coordinates =

    let zCalc x y = (x**2.0 + y**2.0)**0.5 
    match coordinates with
    | [] -> (infinity, infinity)
    | hd :: tl -> 
        let minVal = getClosestPair tl
        if (zCalc (fst hd) (snd hd)) < (zCalc (fst (getClosestPair  tl)) (snd (getClosestPair  tl))) then
            hd
        else
            minVal
    

getClosestPair [];;

