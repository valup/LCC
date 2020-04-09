import Data.List

--1.
data Color = Color { rojo :: Float
                   , verde :: Float
                   , azul :: Float
                   } deriving (Show)


mezclar :: Color -> Color -> Color
mezclar x y = Color { rojo = (rojo x + rojo y)/2
                    , verde = (verde x + verde y)/2
                    , azul = (azul x + azul y)/2}

--2.
data Linea = Linea { chars :: String
                   , pos :: Int
                   } deriving (Show)

vacia :: Linea
vacia = Linea { chars = []
              , pos = 0}

moverIzq :: Linea -> Linea
moverIzq l = Linea { chars = chars l
                   , pos = izq l}
                   where izq l = if pos l > 0 then pos l - 1
                                 else pos l

moverDer :: Linea -> Linea
moverDer l = Linea { chars = chars l
                   , pos = der l}
                   where der l = if pos l < length (chars l)
                                 then pos l + 1
                                 else pos l

moverIni :: Linea -> Linea
moverIni l = Linea { chars = chars l
                   , pos = 0}

moverFin :: Linea -> Linea
moverFin l = Linea { chars = chars l
                   , pos = length (chars l)}

insertar :: Linea -> Char -> Linea
insertar l c = Linea { chars = (take (pos l) (chars l)) ++ [c]
                               ++ drop (pos l) (chars l)
                     , pos = pos l + 1}

borrar :: Linea -> Linea
borrar l = Linea { chars = (take (pos l - 1) (chars l))
                           ++ drop (pos l) (chars l)
                 , pos = pos l - 1}

--3.
data CList a = EmptyCL | CUnit a | Consnoc a (CList a) a

--a)
headCL :: CList a -> a
headCL (CUnit x)       = x
headCL (Consnoc x _ _) = x

tailCL :: CList a -> a
tailCL (CUnit x)       = x
tailCL (Consnoc _ _ x) = x

isEmptyCL :: CList a -> Bool
isEmptyCL EmptyCL = True
isEmptyCL _       = False

isCUnit :: CList a -> Bool
isCUnit (CUnit _) = True
isCUnit _         = False

--b)
reverseCL :: CList a -> CList a
reverseCL (Consnoc x y z) = Consnoc z (reverseCL y) x
reverseCL x               = x

--inits? lasts?

--e)
elimHeadCL :: CList a -> CList a
elimHeadCL (Consnoc _ EmptyCL x) = CUnit x
elimHeadCL (Consnoc _ y x)       = Consnoc (headCL y) (elimHeadCL y) x
elimHeadCL _                     = EmptyCL

elimTailCL :: CList a -> CList a
elimTailCL (Consnoc x EmptyCL _) = CUnit x
elimTailCL (Consnoc x y _)       = Consnoc x (elimTailCL y) (tailCL y)
elimTailCL _                     = EmptyCL

conCL :: CList a -> CList a -> CList a
conCL EmptyCL y           = y
conCL x EmptyCL           = x
conCL (CUnit x) (CUnit y) = Consnoc x EmptyCL y
conCL x y                 = Consnoc (headCL x)
                                    (conCL (elimHeadCL x) (elimTailCL y))
                                    (tailCL y)

concatCL :: CList (CList a) -> CList a
concatCL EmptyCL         = EmptyCL
concatCL (CUnit x)       = x
concatCL (Consnoc x y z) = conCL x (conCL (concatCL y) z)

--4.
data Aexp = Num Int | Prod Aexp Aexp | Div Aexp Aexp

--a)
eval :: Aexp -> Int
eval (Num x)    = x
eval (Prod x y) = (eval x) * (eval y)
eval (Div x y)  = div (eval x) (eval y)

--b)
seval :: Aexp -> Maybe Int
seval (Num x)    = Just x
seval (Prod x y) = do x' <- seval x
                      y' <- seval y
                      return (x' * y')
seval (Div _ (Num 0))  = Nothing
seval (Div x y)  = do x' <- seval x
                      y' <- seval y
                      return $ div x' y'

--5.
data BinTree a = EmptyB | NodeB (BinTree a) a (BinTree a)

--a)
completo :: a -> Int -> BinTree a
completo x 0 = NodeB EmptyB x EmptyB
completo x d = NodeB (completo x (d - 1)) x (completo x (d - 1))

balanceado :: a -> Int -> BinTree a
balanceado x 0 = EmptyB
balanceado x 1 = NodeB EmptyB x EmptyB
balanceado x n | mod n 2 == 0 = let m = div n 2 in
                                NodeB (balanceado x m) x
                                      (balanceado x (m - 1))
               | otherwise    = let m = div (n - 1) 2 in
                                NodeB (balanceado x m) x
                                      (balanceado x m)

--6.
data GenTree a = EmptyG | NodeG a [GenTree a]

g2bt :: GenTree a -> BinTree a
g2bt EmptyG      = EmptyB
g2bt (NodeG x y) = NodeB (g2b y) x EmptyB
                   where g2b []   = EmptyB
                         g2b ((NodeG x xs):ys) = NodeB (g2b xs)
                                                        x (g2b ys)

--7.
data BST a = EmptyBST | NodeBST (BST a) a (BST a)

--1.
emptyBST :: BST a -> Bool
emptyBST EmptyBST = True
emptyBST _        = False

maximum' :: Ord a => BST a -> a
maximum' EmptyBST        = error "Arbol vacio"
maximum' (NodeBST _ x y) | emptyBST y = x
                         | otherwise  = maximum' y

--2.
checkMenor :: Ord a => BST a -> a -> Bool
checkMenor EmptyBST _        = True
checkMenor (NodeBST _ x _) y = x <= y

checkMayor :: Ord a => BST a -> a -> Bool
checkMayor EmptyBST _        = True
checkMayor (NodeBST _ x _) y = x >= y

checkBST :: Ord a => BST a -> Bool
checkBST EmptyBST        = True
checkBST (NodeBST x y z) = (checkMenor x y) && (checkMayor z y)
                            && (checkBST x) && (checkBST z)
