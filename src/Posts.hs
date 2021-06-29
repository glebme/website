{-# LANGUAGE OverloadedStrings #-}

module Posts
  ( Posts
  , listPosts
  , displayPost
  , makeDummyPosts
  , Post
  ) where

import qualified Data.Text.Lazy as TL
import qualified Data.Time.Clock as C
import qualified Data.Map as M

data Post = Post
  { pTime :: C.UTCTime
  , pAuthor :: TL.Text
  , pTitle :: TL.Text
  , pContent :: TL.Text
  }

type Posts = M.Map Integer Post

listPosts :: Posts -> TL.Text
listPosts = TL.unlines . map ppPost . M.elems

displayPost :: Integer -> Posts -> TL.Text
displayPost pid posts = maybe "404 Not Found." ppPost $ M.lookup pid posts

makeDummyPosts :: IO Posts
makeDummyPosts = do 
  time <- C.getCurrentTime 
  pure $ 
    M.singleton 
      0 
      ( Post
        { pTime = time
        , pTitle = "Dummy title"
        , pAuthor = "Dummy author"
        , pContent = "bla bla bla..."
        }
      )

ppPost :: Post -> TL.Text
ppPost post = 
  let
    header =
      TL.unwords
        ["[" <> TL.pack (show (pTime post)) <> "]"
        , pTitle post
        , "by"
        , pAuthor post
        ]
    seperator =
      TL.replicate (TL.length header) "-"
  in
    TL.unlines 
      [ seperator
      , header
      , seperator
      , pContent post
      , seperator
      ]