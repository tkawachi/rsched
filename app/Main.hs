module Main where

import Network.Wai.Handler.Warp (run)
import Network.Wai.Middleware.RequestLogger (logStdoutDev, logStdout)
import Rsched

main :: IO ()
main = run 3000 $ logStdout app
