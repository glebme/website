module Main where

import Lib
import Posts
import qualified Web.Scotty as S

main :: IO ()
main = do
    dummyPosts <- makeDummyPosts
    S.scotty 3000 (myApp dummyPosts)
