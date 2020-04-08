import Data.List

data Color = Color { rojo :: Float
                   , verde :: Float
                   , azul :: Float
                   } deriving (Show)


mezclar :: Color -> Color -> Color
mezclar x y = Color { rojo = (rojo x + rojo y)/2
                    , verde = (verde x + verde y)/2
                    , azul = (azul x + azul y)/2}

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
