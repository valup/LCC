import Parsing
import Control.Applicative ( Alternative((<|>)) )

data Expr = Num Int | BinOp Op Expr Expr deriving Show
data Op = Add | Mul | Min | Div deriving Show

expr :: Parser Expr
expr = do t <- term
          do char '+'
             BinOp Add t <$> expr
            <|> do char '-'
                   BinOp Min t <$> expr
                  <|> return t

term :: Parser Expr
term = do f <- factor
          do char '*'
             BinOp Mul f <$> term
            <|> do char '/'
                   BinOp Div f <$> term
                  <|> return f

factor :: Parser Expr
factor = do Num <$> int
           <|> do char '('
                  e <- expr
                  char ')'
                  return e