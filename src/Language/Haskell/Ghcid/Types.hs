{-# LANGUAGE DeriveDataTypeable #-}

-- | The types types that we use in Ghcid
module Language.Haskell.Ghcid.Types(
    GhciError(..),
    Stream(..),
    Load(..), Severity(..), isMessage, isLoading
    ) where

import Data.Data
import Control.Exception.Base (Exception)

-- | GHCi shut down
data GhciError = UnexpectedExit String String
    deriving (Show,Eq,Ord,Typeable,Data)

-- | Make GhciError an exception
instance Exception GhciError

-- | The stream Ghci is talking over.
data Stream = Stdout | Stderr
    deriving (Show,Eq,Ord,Bounded,Enum,Read,Typeable,Data)

-- | Severity of messages
data Severity = Warning | Error
    deriving (Show,Eq,Ord,Bounded,Enum,Read,Typeable,Data)

-- | Load messages
data Load
    = Loading
        {loadModule :: String
        ,loadFile :: FilePath
        }
    | Message
        {loadSeverity :: Severity
        ,loadFile :: FilePath
        ,loadFilePos :: (Int,Int)
        ,loadMessage :: [String]
        }
    deriving (Show, Eq, Ord)

-- | Is a Load a message with severity?
isMessage :: Load -> Bool
isMessage Message{} = True
isMessage _ = False

-- | Is a Load a module and filename?
isLoading :: Load -> Bool
isLoading Loading{} = True
isLoading _ = False
