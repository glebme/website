module Posts
    ( Posts
    ) where

import qualified Data.Text.Lazy as TL
import qualified Data.Time.Clock as C
import qualified Data.Map as M
import qualified Network.HTTP.Types as HTTP

data Post = Post
    { pTime :: C.UTCTime
    , pAuthor :: TL.Text
    , pTitle :: TL.Text
    , pContent :: TL.Text
    }

type Posts = M.Map Integer Post