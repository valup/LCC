import Parsing
import Control.Applicative ( Alternative((<|>)) )

trans :: Parser a -> Parser a
trans parser = do char '('
                  p <- parser
                  do char ')'
                  return p
                 <|> do parser