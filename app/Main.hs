module Main where

import Network.Wai.Handler.Warp (run)
import Rsched

main :: IO ()
main = run 3000 app
