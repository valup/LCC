import Parsing
import Control.Applicative ( Alternative((<|>)) )

data TypeC = Pnt TypeC | Id String TypeC | Array Int TypeC | End deriving Show
data BaseType = TInt | TChar | TFloat deriving Show

declaration :: Parser (BaseType, TypeC)
declaration = do t <- typeSpecifier
                 d <- declarator
                 symbol ";"
                 return (t, d)

typeSpecifier :: Parser BaseType
typeSpecifier = do symbol "int"
                   return TInt
                  <|> do symbol "char"
                         return TChar
                        <|> do symbol "float"
                               return TFloat
                        
declarator :: Parser TypeC
declarator = do symbol "*"
                Pnt <$> declarator
               <|> do i <- identifier
                      Id i <$> directDeclarator

directDeclarator :: Parser TypeC
directDeclarator = do symbol "("
                      d <- directDeclarator
                      symbol ")"
                      return d
                     <|> do symbol "["
                            i <- int
                            symbol "]"
                            do Array i <$> directDeclarator
                     <|> return End