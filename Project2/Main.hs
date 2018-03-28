import Data.Char (isDigit,digitToInt)
data Color = Red | Black
            deriving (Eq,Show)

data Suit = Clubs | Diamonds | Hearts | Spades
            deriving (Eq,Show)

data Move = Draw | Discard Card
            deriving (Eq,Show)

data Rank = Num Int | Jack | Queen | King | Ace
            deriving (Eq,Show)

data Card = Card { suit :: Suit, rank :: Rank }
            deriving (Eq,Show)


cardColor :: Card -> Color
cardColor card = if suit card == Spades || suit card == Clubs then Black else Red

cardValue :: Card -> Int
cardValue card = case rank card of
    Num value -> value
    Ace       -> 10
    _         -> 11

removeCard :: [Card] -> Card -> [Card]
removeCard (x:xs) c = if c == x then xs else x : removeCard xs c

allSameColor :: [Card] -> Bool
allSameColor [x]        = True
allSameColor [x1,x2]    = if cardColor x1 == cardColor x2 then True else False
allSameColor (x1:x2:xs) = if cardColor x1 == cardColor x2 then allSameColor (x2:xs) else False

sumCards :: [Card] -> Int
sumCards list = sumCards' list 0
    where
        sumCards' :: [Card] -> Int -> Int
        sumCards' [] acc = acc
        sumCards' (x:xs) acc = sumCards' xs (acc + cardValue x)

score :: [Card] -> Int -> Int
score held goal
    | sum > goal = if allSameColor held then div (3*(sum-goal)) 2 else 3*(sum - goal)
    | otherwise  = if allSameColor held then div (goal-sum)     2 else goal-sum
        where
            sum:: Int
            sum = sumCards held

convertSuit :: Char -> Suit
convertSuit card
    | elem card ['c','C'] = Clubs
    | elem card ['d','D'] = Diamonds
    | elem card ['h','H'] = Hearts
    | elem card ['s','S'] = Spades
    | otherwise = error "Suit is unknown!"

convertRank :: Char -> Rank
convertRank card
    | elem card ['j','J'] = Jack
    | elem card ['q','Q'] = Queen
    | elem card ['k','K'] = King
    | elem card ['t','T'] = (Num 10)
    | card == '1' = Ace
    | isDigit card = (Num (digitToInt card))
    | otherwise = error "Rank is unknown!"

convertCard :: Char -> Char -> Card
convertCard suit rank = Card (convertSuit suit) (convertRank rank)

readCards :: IO [Card]
readCards  = do
    line <- getLine
    if line == "."
        then  return []
        else do
            let currentCard   = (convertCard (head line) (head (tail line)))
            recursiveList <- readCards
            return (currentCard:recursiveList)

convertMove :: Char -> Char -> Char -> Move
convertMove move suit rank
    | elem move ['d','D'] = Draw
    | elem move ['r','R'] = Discard (Card (convertSuit suit) (convertRank rank))
    | otherwise = error "Unknown move!"

readMoves :: IO [Move]
readMoves  = do
    line <- getLine
    if line == "."
        then  return []
        else if length line == 3 || length line == 1
            then do
            let currentMove  = (convertMove (head line) (head (tail line)) (head (tail (tail line)) ))
            recursiveList <- readMoves
            return (currentMove:recursiveList)
        else error "Move is not valid." 

main :: IO ()
main = return ()
