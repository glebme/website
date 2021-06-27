module Main where

import Lib
import qualified Web.Scotty as S

main :: IO ()
main = do
    S.scotty 3000 myApp
