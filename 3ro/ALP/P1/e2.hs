import Parsing ( char, int, Parser )
import Control.Applicative ( Alternative((<|>)) )

expr :: Parser Int
expr = do t <- term
          do char '+'
             e <- expr
             return $ t + e
            <|> do char '-'
                   e <- expr
                   return $ t - e
                  <|> return t

term :: Parser Int
term = do f <- factor
          do char '*'
             t <- term
             return $ f * t
            <|> do char '/'
                   div f <$> term
                  <|> return f

factor :: Parser Int
factor = do int
           <|> do char '('
                  e <- expr
                  char ')'
                  return e