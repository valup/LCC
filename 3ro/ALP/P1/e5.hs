import Parsing
import Control.Applicative ( Alternative((<|>)) )

type Het = Either Int Char

hetList :: Parser [Het]
hetList = do char '['
             elems <- sepBy het (char ',')
             char ']'
             return elems

het :: Parser Het
het = do string "\8217"
         c <- item
         string "\8217"
         return (Right c)
        <|> do Left <$> int
        