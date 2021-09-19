import Parsing
import Control.Applicative ( Alternative((<|>)) )

data Hasktype = DInt | DChar | Fun Hasktype Hasktype deriving Show

parseType :: Parser Hasktype
parseType = do b <- base
               do token (string "->")
                  Fun b <$> parseType
                 <|> return b

base :: Parser Hasktype
base = do string "Int"
          return DInt
         <|> do string "Char"
                return DChar