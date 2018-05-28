main = return ()

data Input i a = In { run :: [i] -> (a, [i]) }

consume :: Input i i
consume = In { run = (\input -> (head input, tail input)) }

instance Functor (Input i) where
  fmap f xi = In { run = (
                    \input -> let(x, input') = (run xi input) in (f x, input') 
                    )}

instance Applicative (Input i) where
  pure x = In { run = ( \input -> (x, input))  }
  fi <*> xi = In{ run = (\input -> let (f, input') = (run fi input)
                                       (x, input'') = (run xi input')
                                   in (f x, input'')
                  )}

instance Monad (Input i) where
  xi >>= f = In{ run = (\input -> let (x, input') = (run xi input)
                                  in run (f x) input')}


primer = do x <- consume
            y <- consume
            return (x + y)
            
            
            
data Output o a = Out { result :: a, output :: o }
                deriving Show
                
rezultat_z_izhodom = Out { result = 42, output = "izhodni niz"}

write = \x -> Out {output = x, result = ()}

instance Functor (Output o) where
  fmap f (Out x out) = Out { output = out, result = f x }
  
instance Monoid o => Applicative (Output o) where
  pure x = Out {output = mempty, result = x}
  Out f o <*> Out x o' = Out{ output = mappend o o', result = f x}
  
instance Monoid o => Monad (Output o) where
  Out x o >>= f = let (Out r o') = f x in Out{result = r, output = mappend o o'} 

primer2 = do write "Hello,"
             xx <- return 10
             write " world"
             yy <- return (xx + 20)
             write "!"
             return (xx * yy)



isPrime 1 = False
isPrime n = all (\k -> mod n k > 0) [2..(n-1)] 

primes n = output (loop 2)
    where loop k | k >= n     = return ()
                 | otherwise  = do if isPrime k then write [k] else return ()
                                   loop (k + 1)
