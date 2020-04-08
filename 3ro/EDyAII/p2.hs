import Data.Char

--1.

test :: (Eq a, Num a) => (a -> a) -> a -> Bool
test f x = f x == x + 2

esMenor :: Ord a => a -> a -> Bool
esMenor y z = y < z

eq :: Eq a => a -> a -> Bool
eq a b = a == b

showVal :: Show a => a -> String
showVal x = "Valor: " ++ show x

--2.

--(+5) :: Num a => a -> a
--Toma un numero y le suma 5

--(0<) :: (Num a, Ord a) => a -> Bool
--Toma un numero y dice si es mayor a 0 o no

--('a':) :: String -> String
--Toma una cadena y agrega 'a' al principio

--(++"\n") :: String -> String
--Toma una cadena y le agrega un salto de linea

--filter(==7) :: (Num a , Eq a) => [a] -> [a]
--Toma una lista de numeros y elimina los elementos que no son 7

--map(++[1]) :: Num a => [[a]] -> [[a]]
--Toma una lista de listas de numeros y les agrega 1 al final

--3.

a1 :: (Int -> Int) -> Int
a1 f = f 2

a2 :: (Int -> Int) -> Int
a2 f = 2 * a1 f

b1 :: Int -> (Int -> Int)
b1 x = (*x)

b2 :: Int -> (Int -> Int)
b2 x = (x-)

c1 :: (Int -> Int) -> (Int -> Int)
c1 f = (*2) . f

c2 :: (Int -> Int) -> (Int -> Int)
c2 f = f . negate

d1 :: Int -> Bool
d1 x = even x

d2 :: Int -> Bool
d2 x = odd x

e1 :: Bool -> (Bool -> Bool)
e1 b = (==b)

e2 :: Bool -> (Bool -> Bool)
e2 True = (==True)
e2 False = not

f1 :: (Int, Char) -> Bool
f1 (n, c) = ord c == n

f2 :: (Int, Char) -> Bool
f2 (n, c) = n == 0

g1 :: (Int, Int) -> Int
g1 (x, y) = x + y

g2 :: (Int, Int) -> Int
g2 (x, y) = max x y

h1 :: Int -> (Int, Int)
h1 x = (x-1, x+1)

h2 :: Int -> (Int, Int)
h2 x = (x, -x)

i1 :: a -> Bool
i1 x = True

i2 :: a -> Bool
i2 x = False

j1 :: a -> a
j1 x = x

--4.
e4a = if true then false else true where false=True; true=False --False

--b) sintactico

e4c = False == (5 >= 4) --False

--d) de tipos (nose pueden usar dos < en la misma expr)

e4e = 1 + if ('a' < 'z') then -1 else 0 --0

--f) de tipos (devuelve tipos diferentes)

e4g = if fst p then fst p else snd p where p = (True, False) --True

--5.

e5a x = x

greater (x, y) = x > y

e5c (x, y) = x

--6.

--smallest = \x y z -> min x (min y z)
smallest :: Ord a => a -> a -> a -> a
smallest = \x y z -> if x <= y && x <= z then x
                     else if y <= x && y <= z then y
                     else z

second = \_ -> (\x -> x)

andThen = \b y -> if b then y else False

twice = \f x -> f (f x)

flip' = \f x y -> f y x

inc = \x -> x + 1

--7.

iff x y | x = not y
        | otherwise = y

alpha x = x

--8.
--h :: a -> b -> d
--h x = f.(g x)
--los otros dan error de tipos

-- . :: (a -> b) -> (b -> c) -> (a -> c)

zip3' :: [a] -> [b] -> [c] -> [(a, b, c)]
zip3' [] [] []       = []
zip3' (x:xs) (y:ys) (z:zs) = (x, y, z) : (zip3 xs ys zs)



zip3'' :: [a] -> [b] -> [c] -> [(a, b, c)]
zip3'' xs ys zs = unir $ (zip xs (zip ys zs))
                  where unir []             = []
                        unir ((x, (y, z)):xs) = (x, y, z) : unir xs

--10.
--a) a d) tienen sentido suponiendo que xs es lista de listas
--[[]] ++ xs = []:xs (c)
--e) a h) tienen sentido para cualquier tipo de lista xs
--[[]] ++ [xs] = [[],xs] (e)
--[] ++ xs = xs (h)
--i) y j) tienen sentido para cualquier tipo de dato xs
--[xs] ++ [] = [xs] (i)
--[xs] ++ [xs] = [xs, xs] (j)

--11.
modulus :: Floating a => [a] -> a
modulus = sqrt . sum . map (^2)

vmod :: Floating a => [[a]] -> [a]
vmod []     = []
vmod (v:vs) = modulus v : vmod vs

--12.
type NumBin = [Bool]

mas1 :: NumBin -> NumBin --aux para sumBin
mas1 []     = [True]
mas1 (x:xs) = if x then False : mas1 xs else True:xs

sumBin :: NumBin -> NumBin -> NumBin
sumBin xs []         = xs
sumBin [] ys         = ys
sumBin (x:xs) (y:ys) | x && y = False : sumBin xs (mas1 ys)
                     | not x = y : sumBin xs ys
                     | otherwise = False : sumBin xs ys

prodBin :: NumBin -> NumBin -> NumBin
prodBin _ []      = [False]
prodBin xs [y]    = if y then xs else [False]
prodBin xs (y:ys) = if y then sumBin xs z else z
                    where z = prodBin (False:xs) ys

coc2 :: NumBin -> NumBin
coc2 [_]    = [False]
coc2 (_:xs) = xs

resto2 :: NumBin -> NumBin
resto2 []   = []
resto2 (x:xs) = [x]

--13. y 14. lab.hs
