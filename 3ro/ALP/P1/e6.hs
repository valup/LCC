import Parsing
import Control.Applicative ( Alternative((<|>)) )

data Basetype = DInt | DChar | DFloat deriving Show
type Hasktype = [Basetype]

parseType :: Parser Hasktype
parseType = do sepBy base (token (string "->"))

base :: Parser Basetype
base = do string "Int"
          return DInt
         <|> do string "Char"
                return DChar
               <|> do string "Float"
                      return DFloat