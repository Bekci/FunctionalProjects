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

--removeCard :: [Card] -> Card -> [Card]
--removeCard list current = removeCard' list current False
--    where
--        removeCard' :: [Card] -> Card -> Bool -> [Card]
--        removeCard'

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


main :: IO ()
main = return ()
