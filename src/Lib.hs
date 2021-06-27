{-# language OverloadedStrings #-}

module Lib
    ( startApp
    ) where

import Posts ( Posts, Post, listPosts, displayPost, makeDummyPosts )
import MyState
import qualified Web.Scotty as S
import qualified Data.Map as M
import qualified Network.HTTP.Types as HTTP
import qualified Control.Concurrent.STM as STM
import qualified Control.Monad.IO.Class (liftIO)

startApp :: IO ()
startApp = do
  posts <- makeDummyPosts
  mystateVar <- STM.newTVarIO MyState{msId = 1, msPosts = posts}
  S.scotty 3000 (myApp mystateVar)

myApp :: STM.TVar MyState  -> S.ScottyM ()
myApp mystateVar = do
  -- Our main page, which will display all of the bulletins
  S.get "/" $ do
    posts <- liftIO $ msPosts <$> STM.readTVarIO mystateVar
    S.text $ listPosts posts

  -- A page for a specific post
  S.get "/post/:id" $ do
    pid <- S.param "id"
    posts <- liftIO $ msPosts <$> STM.readTVarIO mystateVar
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
  S.post "/post/:id/delete" $ do
    pid <- S.param "id"
    exists <- liftIO $ STM.atomically  $ do
      mystate <- STM.readTVar  mystateVar
      case M.lookup pid (msPosts mystate) of
        Just{} -> do
          STM.writeTVar mystateVar ( mystate {msPosts = M.delete pid (msPosts mystate)})
          pure True
        Nothing ->
          pure False
    if exists
      then 
        S.redirect "/"

      else do
        S.status HTTP.notFound404
        S.text  "404 Not Found."

newPost :: Post -> STM.TVar MyState -> IO Integer
newPost post mystateVar = do
  STM.atomically $ do
    mystate <- STM.readTVar mystateVar
    STM.writeTVar 
      mystateVar 
      ( mystate
        { msId = msId mystate + 1
        , msPosts = M.insert (msId mystate) post (msPosts mystate)
        }
      )
    pure (msId mystate)