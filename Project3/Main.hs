import Prelude hiding (Word)
import Data.Char
import Data.List
type Word = String
type Sentence = [Word]
type CharCounts = [(Char, Int)]

wordCharCounts :: Word -> CharCounts
wordCharCounts = map (\x -> (head x,length x)) . group . sort . toLowerWord
	where
		toLowerWord ::  Word -> Word
		toLowerWord  = map toLower 
		