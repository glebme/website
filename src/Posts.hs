module Posts
  ( Posts
  , listPosts
  , displayPost
  , makeDummyPosts
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
displayPost pid posts =
  case M.lookup pid posts of
    Just post -> ppPost post
    Nothing -> TL.pack "404 Not Found."

makeDummyPosts :: IO Posts
makeDummyPosts = do 
  time <- C.getCurrentTime 
  pure $ 
    M.singleton 
      0 
      ( Post
        { pTime = time
        , pTitle = TL.pack "Dummy title"
        , pAuthor = TL.pack "Dummy author"
        , pContent = TL.pack "bla bla bla..."
        }
      )

ppPost :: Post -> TL.Text
ppPost post = 
  let
    header =
      TL.unwords
        [TL.pack ("[" <> show (pTime post) <> "]")
        , pTitle post
        , TL.pack "by"
        , pAuthor post
        ]
    seperator =
      TL.replicate (TL.length header) $ TL.pack "-"
  in
    TL.unlines 
      [ seperator
      , header
      , seperator
      , pContent post
      , seperator
      ]