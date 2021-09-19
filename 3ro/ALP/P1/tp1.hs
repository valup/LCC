{-# LANGUAGE GADTs #-}
{-# LANGUAGE StandaloneDeriving #-}
import Parsing
import Control.Applicative ( Alternative((<|>)) )
import Text.ParserCombinators.Parsec.Token (GenTokenParser(comma))

type Variable = String

data Exp a where
    Const :: Int -> Exp Int
    Var :: Variable -> Exp Int
    UMinus :: Exp Int -> Exp Int
    Plus :: Exp Int -> Exp Int -> Exp Int
    Minus :: Exp Int -> Exp Int -> Exp Int
    Times :: Exp Int -> Exp Int -> Exp Int
    Div :: Exp Int -> Exp Int -> Exp Int
    BTrue :: Exp Bool
    BFalse :: Exp Bool
    Lt :: Exp Int -> Exp Int -> Exp Bool
    Gt :: Exp Int -> Exp Int -> Exp Bool
    And :: Exp Bool -> Exp Bool -> Exp Bool
    Or :: Exp Bool -> Exp Bool -> Exp Bool
    Not :: Exp Bool -> Exp Bool
    Eq :: Exp Int -> Exp Int -> Exp Bool
    NEq :: Exp Int -> Exp Int -> Exp Bool

deriving instance Show (Exp a)
deriving instance Eq (Exp a)

data Comm = Skip
          | Let Variable (Exp Int)
          | Seq Comm Comm
          | IfThenElse (Exp Bool) Comm Comm
          | Repeat Comm (Exp Bool)
          | ES ESeq
          deriving Show

data ESeq = S EAssgn ESeq | Ret (Exp Int) deriving Show

type EAssgn = (Variable, Exp Int)

sec :: Parser Comm
sec = do ES <$> eseq
        <|> do c <- comm
               do symbol ";"
                  Seq c <$> sec
                 <|> return c

eseq :: Parser ESeq
eseq = do v <- identifier
          symbol "="
          i <- intexp
          symbol ","
          S (v, i) <$> eseq
         <|> do Ret <$> intexp

comm :: Parser Comm
comm = do symbol "if"
          b <- boolexp
          symbol "{"
          ct <- comm
          symbol "}"
          symbol "else"
          symbol "{"
          cf <- comm
          symbol "}"
          return (IfThenElse b ct cf)
         <|> do symbol "repeat"
                c <- comm
                symbol "until"
                b <- boolexp
                symbol "end"
                return (Repeat c b)
         <|> do v <- identifier
                symbol "="
                Let v <$> intexp
         <|> return Skip

boolexp :: Parser (Exp Bool)
boolexp = do b <- bool1
             do symbol "||"
                Or b <$> boolexp
               <|> return b

bool1 :: Parser (Exp Bool)
bool1 = do b <- bool2
           do symbol "&&"
              Or b <$> bool1
             <|> return b

bool2 :: Parser (Exp Bool)
bool2 = do b <- bool3
           do symbol "!"
              return (Not b)
             <|> return b

bool3 :: Parser (Exp Bool)
bool3 = do symbol "true"
           return BTrue
          <|> do symbol "false"
                 return BFalse
          <|> do symbol "("
                 b <- boolexp
                 symbol ")"
                 return b
          <|> do i <- intexp
                 do symbol "=="
                    Eq i <$> intexp
                   <|> do symbol "!="
                          NEq i <$> intexp
                   <|> do symbol "<"
                          Lt i <$> intexp
                   <|> do symbol ">"
                          Gt i <$> intexp

intexp :: Parser (Exp Int)
intexp = do t <- term
            do symbol "+"
               Plus t <$> intexp
              <|> do symbol "-"
                     Minus t <$> intexp
              <|> return t

term :: Parser (Exp Int)
term = do f <- factor
          do symbol "*"
             Times f <$> term
            <|> do symbol "/"
                   Div f <$> term
            <|> return f

factor :: Parser (Exp Int)
factor = do symbol "-"
            UMinus <$> factor
           <|> do Const <$> int
           <|> do symbol "("
                  e <- intexp
                  symbol ")"
                  return e
           <|> do Var <$> identifier