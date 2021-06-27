module MyState where

import Posts ( Posts )

data MyState = MyState
  { msId :: Integer
  , msPosts :: Posts
  }