---------------------------------------------------------------------------
-- Week 1 exercises for the Logika v računalništvu course at UL FMF      --
-- Lecturer: Andrej Bauer                                                --
-- Teaching Assistant: Danel Ahman                                       --
--                                                                       --
-- Course website: https://ucilnica.fmf.uni-lj.si/course/view.php?id=252 --
-- Lecture notes: http://www.andrej.com/zapiski/ISRM-LOGRAC-2022/        --
---------------------------------------------------------------------------

module Ex1 where

-- dodajam komentar 
-- dela normalno ck cc

----------------
-- Exercise 0 --
----------------

{-
   Begin by loading this Agda file in the editor of your choice (VS
   Code or Emacs, see README.md) using the `C-c C-l` command (to be
   read as pressing the `Ctrl` and `c` keys simultaneously, followed
   by pressing `Ctrl` and `l` keys simultaneously).

   If you have Agda set up correctly, then this should start the
   typechecking process on the given file. If the file loading and
   typechecking succeeds, the syntax should get colour-highlighted,
   and an additional buffer should appear and list the open goals
   (holes in Agda terminology) that need to be filled in this file:

   ?0 : Bool
   ?1 : ℕ
   ?2 : ℕ
   ...
   ?13 : length xs ≡ᴺ length (map f xs)
   ?14 : length xs ≤ length ys
   ?15 : xs ≤ᴸ ys
-}


------------------
-- Exercise 1 --
------------------

{-
   Recall the type of booleans from the lecture.
-}

data Bool : Set where
  true  : Bool
  false : Bool

{-
   Define the XOR operation on booleans by pattern-matching.

   Recall that you can pattern-match on the function arguments by
   writing the name of the corresponding argument in the hole in the
   right-hand side of the definition, and then running the `C-c C-c`
   command with the cursor placed in the given hole.

   Also recall that you can fill and complete a hole with what you
   have written in it by putting the cursor in the hole and then
   running the `C-c C-space` command. If you attempted to fill a
   hole with a term of incorrect type (say using a natural number
   instead of a boolean), Agda will report a typechecking error.
-}

{--
napišeš b ⊕ b' = {}
greš v bracket in cc cc, split on variable
se ti izpišejo vse monosti
greš s kurzorjem v bracket
cc c-space
--}


_⊕_ : Bool → Bool → Bool
{-true ⊕ true = {}
true ⊕ false = {}
false ⊕ true = {}
false ⊕ false = {} -}
true ⊕ true = false
true ⊕ false = true
false ⊕ true = true
false ⊕ false = false

{-
   You can test whether your definition computes correctly by using
   the `C-c C-n` command, which uses Agda's normalisation engine to
   compute the normal form of a given expression. For example, using
   `C-c C-n` on `false ⊕ (true ⊕ false)` should return `true`.

   Feel free to use `C-c C-n` also with other functions on this
   exercise sheet to test whether your solutions compute correctly.
-}

{--če hočeš pognat klikneš cc cn, utipkaš izraz in potem enter--}

----------------
-- Exercise 2 --
----------------

{-
   Recall the type of natural numbers from the lecture.
-}

data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ

{-# BUILTIN NATURAL ℕ #-}

{-
   Define a function that increments the given number by one.
-}

incr : ℕ → ℕ
incr n = suc n

{-
   Define a function that decrements a number by one. Give the definition
   using pattern-matching. Decrementing the number zero should return zero.
-}

decr : ℕ → ℕ
decr zero = zero
decr (suc n) = n

{-
   Define a function that triples the value of a given number.
   Your definition should use both pattern-matching and recursion.
-}

triple : ℕ → ℕ
triple zero = zero
triple (suc zero) = suc (suc (suc zero))
triple (suc n) = suc (suc (suc (triple n)))


----------------
-- Exercise 3 --
----------------

{-
   Recall the defintions of `+` and `*` from the lecture.
-}

_+_ : ℕ → ℕ → ℕ
zero    + n = n
(suc m) + n = suc (m + n)

_*_ : ℕ → ℕ → ℕ
zero    * n  =  zero
(suc m) * n  =  n + (m * n)

{-# BUILTIN NATPLUS _+_ #-}
{-# BUILTIN NATTIMES _*_ #-}

infixl 6  _+_
infixl 7  _*_

{-
   Define exponentiation m^n using pattern-matching, recursion,
   and the operations on natural numbers defined above.
-}

_^_ : ℕ → ℕ → ℕ
m ^ zero = suc zero
m ^ suc n = (m ^ n) * m

infixl 8  _^_


----------------
-- Exercise 4 --
----------------

{-
   In addition to the unary representation of natural numbers
   given above and in the lecture (the ℕ type), one can represent
   natural numbers more compactly and more efficiently in binary
   format as bitstrings, defined as the following datatype Bin.

   For example, in Agda one represents the binary number 1010₂
   (which stands for the natural number 10) as `⟨⟩ I O I O`.

   You get the unicode symbol `⟨` by entering either `\<` or `\langle`,
   and the unicode symbol `⟩` by entering either `\>` or `\rangle`.
-}

data Bin : Set where
  ⟨⟩ : Bin
  _O : Bin → Bin
  _I : Bin → Bin

infixl 20 _O
infixl 20 _I

{-
   Define the increment function on such binary numbers, e.g., 
   such that you have `b-incr (⟨⟩ I O I I) ≡ ⟨⟩ I I O O`.
-}

b-incr : Bin → Bin
b-incr ⟨⟩ = ⟨⟩ I
b-incr (b O) = b I
b-incr (b I) = (b-incr b) O -- b-incr (b1 b2 b3 ... bn 1) = 


----------------
-- Exercise 5 --
----------------

{-
   Define functions `to` and `from` that translate unary numbers
   to binary numbers and vice versa. If needed for the solution,
   don't be afraid of defining and using new auxiliary functions
   (either using a `where` clause or by defining these auxiliary
   functions at the top level before the function where you
   want to use them).
-}

to : ℕ → Bin
to zero = ⟨⟩ O
to (suc n) = b-incr (to n)

from : Bin → ℕ
 {-from ⟨⟩ = {!   !}
from (b O) = {!   !}
from (b I) = {!   !} -}
from b = from-aux b 0 
   where
   from-aux : Bin → ℕ → ℕ 
   from-aux ⟨⟩ n = 0
   from-aux (b O) n = from-aux b (suc n)
   from-aux (b I) n = from-aux b (suc n) + 2 ^ n  

{--
postulate (if you want to check if functions are equal)

from-equal : (b : Bin) → (from b) ≡n (from' b)
-}

----------------
-- Exercise 6 --
----------------

{-
   Recall the "is even" predicate for unary numbers.
-}

data Even : ℕ → Set where
  even-z : Even zero
  even-ss : {n : ℕ} → Even n → Even (suc (suc n))

{-
   Define an analogous "is even" predicate for binary numbers.
-}

data Even₂ : Bin → Set where
   even₂ : {b : Bin} → Even₂ (b O)
  {- EXERCISE: add the constructors for this inductive predicate here -}


----------------
-- Exercise 7 --
----------------

{-
   Prove that the `to` function translates evens to evens. Again, 
   if needed, do not be afraid to define auxiliary functions/proofs.
-}

to-even : {n : ℕ} → Even n → Even₂ (to n) --read: if n is even then (to n) is even
to-even even-z = even₂    -- p = even-z, P : Even n, zero-z : Even zero ==> agda can deduce that n = zero
                                 -- now we just have to prove that zero is even
                                 -- cc ca ti da rešitev, če probaš karkol druzga in cc cspace ne bo šlo 
-- to-even {zero} even-z = even₂     
to-even (even-ss {n} p) = b-incr-incr-even (to-even p)
   where
      b-incr-incr-even : {b : Bin} → Even₂ b → Even₂ (b-incr (b-incr b))
      b-incr-incr-even even₂ = even₂



----------------
-- Exercise 8 --
----------------

{-
   Observe that for the simplicity and uniformity of its definition,
   the type Bin has redundant elements---in your above solutions, you
   likely treated both `⟨⟩` and `⟨⟩ O` both as the unary number 0.

   Define a unary inductive predicate NonEmptyBin to classify those
   binary numbers that are non-empty in the sense that `⟨⟩` is not a
   non-empty binary number on its own---it can only terminate a
   sequence of Os and Is from the left. In other words, the type
   `NonEmptyBin (⟨⟩ I O I I)` should be inhabited while the type
   `NonEmptyBin ⟨⟩` should not be inhabited.
-}

data NonEmptyBin : Bin → Set where
  {- EXERCISE: add the constructors for this inductive predicate here -}
   neO : {b : Bin} → NonEmptyBin (b O)
   neI : {b : Bin} → NonEmptyBin (b I)
{-
   To verify that `NonEmptyBin ⟨⟩` is indeed not inhabited as intended,
   show that you can define a function from it to Agda's empty type
   (an inductive type with no constructors, hence with no inhabitants).
-}

data ⊥ : Set where

⟨⟩-empty : NonEmptyBin ⟨⟩ → ⊥
⟨⟩-empty ()

----------------
-- Exercise 9 --
----------------

{-
   Using the non-empty binary numbers predicate, rewrite the `from`
   function so that it takes an additional proof argument that
   witnesses that the given binary number argument is non-empty.
   
   Due to this additional proof argument, your solution will not 
   need a case for the binary number argument being `⟨⟩` any more.
-}

from-ne : (b : Bin) → NonEmptyBin b → ℕ
from-ne (⟨⟩ O) neO = zero
from-ne (b O O) neO = 2 * (from-ne (b O) neO)
from-ne (b I O) neO = 2 * (from-ne (b I) neI)
from-ne (⟨⟩ I) neI = 1
from-ne (b O I) neI = 1 + 2 * (from-ne (b O) neO)
from-ne (b I I) neI = 1 + 2 * (from-ne (b I) neI)

-----------------
-- Exercise 10 --
-----------------

{-
   Another common inductive data structure you will often see in
   functional programming and in Agda is that of lists (holding
   elements of some type `A`), given by constructors for the empty
   list and for concatenating a new element to a given list.

   For example, the sequence of numbers 0, 1, 2 would be expressed in
   Agda as a list as the expression `0 ∷ 1 ∷ 2 ∷ []` of type `List ℕ`.
-}

data List (A : Set) : Set where
  []  : List A
  _∷_ : A → List A → List A

infixr 5 _∷_

{-# BUILTIN LIST List #-}

{-
   Define the `map` function on lists that applies a given function
   of type `A → B` to every element of a given list of type `List A`
   and returns a list of type `List B`. In other words, the application
   `map f (0 ∷ 1 ∷ 2 ∷ [])` should return `f 0 ∷ f 1 ∷ f 2 ∷ []`.
-}

map : {A B : Set} → (A → B) → List A → List B
map f [] = []
map f (x ∷ xs) = f x ∷ map f xs


-----------------
-- Exercise 11 --
-----------------

{-
   Define the `length` function that computes the length of a given list.
-}

length : {A : Set} → List A → ℕ
length [] = 0
length (x ∷ xs) = 1 + length xs

-----------------
-- Exercise 12 --
-----------------

{-
   Recall the (observational) equality relation for unary numbers.
-}

infix 4 _≡ᴺ_

data _≡ᴺ_ : ℕ → ℕ → Set where
  z≡ᴺz : zero ≡ᴺ zero
  s≡ᴺs : {m n : ℕ} → m ≡ᴺ n → suc m ≡ᴺ suc n

{-
   Prove that the `map` function preserves the length of the given list.
-}

map-≡ᴺ : {A B : Set} {f : A → B} → (xs : List A) → length xs ≡ᴺ length (map f xs)
map-≡ᴺ [] = z≡ᴺz
map-≡ᴺ (x ∷ xs) = s≡ᴺs (map-≡ᴺ xs)


-----------------
-- Exercise 13 --
-----------------

{-
   Recall the "less than or equal" relation on unary numbers.
-}

data _≤_ : ℕ → ℕ → Set where
  z≤n : {n : ℕ} → zero ≤ n
  s≤s : {m n : ℕ} → m ≤ n → suc m ≤ suc n

infix 4 _≤_

{-
   Define an analogous inductive binary relation `≤ᴸ` for lists
   based on their lengths,  e.g., `[]` should be less than or
   equal (using `≤ᴸ`) to the lists `[]` and `[ 42 ]`.
-}

data _≤ᴸ_ {A : Set} : List A → List A → Set where
  {- EXERCISE: add the constructors for this inductive relation here -}
   []≤ᴸxs : {xs : List A} → [] ≤ᴸ xs
   ∷≤ᴸ∷   : {x y : A} → {xs ys : List A} → xs ≤ᴸ ys → x ∷ xs ≤ᴸ y ∷ ys


infix 4 _≤ᴸ_


-----------------
-- Exercise 14 --
-----------------

{-
   Prove that the lengths of two lists related by `≤ᴸ` are related
   by the `≤` relation, and vice versa.
-}

length-≤ᴸ-≦ : {A : Set} {xs ys : List A} → xs ≤ᴸ ys → length xs ≤ length ys
length-≤ᴸ-≦ []≤ᴸxs = z≤n
length-≤ᴸ-≦ (∷≤ᴸ∷ p) = s≤s (length-≤ᴸ-≦ p)

length-≤-≦ᴸ : {A : Set} (xs ys : List A) → length xs ≤ length ys → xs ≤ᴸ ys
length-≤-≦ᴸ [] ys z≤n = []≤ᴸxs
length-≤-≦ᴸ (x ∷ xs) (x₁ ∷ ys) (s≤s p) = ∷≤ᴸ∷ (length-≤-≦ᴸ xs ys p)


-----------------
-- Exercise 14 --
-----------------

{-
   If you have solved all the above exercises, then as extra, more
   challening problems, you can try to equip the binary numbers with
   operations and relations we have defined for the unary numbers: 
   - addition
   - multiplication
   - (observational) equality
   - "less than or equal" order
   - show that `from` takes even numbers to even numbers
<<<<<<< HEAD
-}
 
=======
-}
>>>>>>> 4d122a171c5f7fd5bbb7b08602aa3e37d55c8a25
