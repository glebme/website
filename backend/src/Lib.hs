{-# language OverloadedStrings #-}

module Lib
    ( startApp
    ) where

import qualified Web.Scotty as S

startApp :: IO ()
startApp = do
  S.scotty 3000 myApp

myApp :: S.ScottyM ()
myApp = do
  -- Main page
  S.get "/" $ 
    S.text "not yet implemented"

  S.get"/about" $
    S.text "not yet implemented"

  S.get"/experiences" $
    S.text "not yet implemented"

  S.get"/contact" $
    S.text "not yet implemented"
