main = return ()

factorial :: Integer -> Integer
factorial n 
  | n <= 1 = 1
  | otherwise = n * factorial(n-1)
  
fib :: Integer -> Integer
fib n
  | n <= 1 = 1
  | otherwise = fib (n-2) + fib (n-1)

member :: Int -> [Int] -> Bool
member x [] = False
member x (y:ys) 
  | x == y = True
  | otherwise = member x ys
  
above :: Int -> [Int] -> Bool
above x [] = True
above x (y:ys)
  | x >= y = above x ys
  | otherwise = False
  
  
prvih_dvajset = [1..20]
soda = [n | n <- prvih_dvajset, n `mod` 2 == 0]
fibonaccijeva_stevila = [fib n | n <- prvih_dvajset]

pari :: Int -> [(Int, Int)]
pari n = [(i, j) | i <- [1..n], j <- [1..n], i < j]


-- problem dam, again
type Square = (Int, Int)
type Queen = Square

board :: Int -> [Square]
board n = [(i, j) | i <- [1..n], j <- [1..n]]

attacks :: Square -> Square -> Bool
attacks (i1, j1) (i2, j2)
  | i1 == i2 || j1 == j2 = True
  | i1 + j1 == i2 + j2 || i1 - j1 == i2 - j2 = True
  | otherwise = False

attack :: [Queen] -> Square -> Bool
attack [] _ = False
attack (q:qs) s = attacks q s || attack qs s 

place1 :: Int -> Int -> [Queen] -> [Queen]
place1 n x qs = [(x, y)| y <- [1..n], not(attack qs (x, y))]

queens :: Int -> [[Queen]]
queens n = place 1 []
  where
    place x qs 
      | x > n = [qs]
      | otherwise = concat [place (x+1) (q:qs) | q <- (place1 n x qs)]