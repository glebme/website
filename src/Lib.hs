{-# language OverloadedStrings #-}

module Lib
    ( myApp
    ) where

import qualified Web.Scotty as S
import Posts
import qualified Network.HTTP.Types as HTTP

myApp :: Posts -> S.ScottyM ()
myApp posts = do
  -- Our main page, which will display all of the bulletins
  S.get "/" $ 
    S.text $ listPosts posts

  -- A page for a specific post
  S.get "/post/:id" $ do
    pid <- S.param "id"
    let
       response = displayPost pid posts
    case response of
        "404 Not Found" -> do
          S.status HTTP.notFound404
          S.text response
        _ -> S.text response

  -- A page for creating a new post
  S.get "/new" $
    error "not yet implemented"

  -- A request to submit a new page
  S.post "/new" $
    error "not yet implemented"

  -- A request to delete a specific post
  S.post "/post/:id/delete" $
    error "not yet implemented"