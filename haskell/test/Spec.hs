import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)
import Data.List

import Lib

main :: IO ()
main = hspec $
  describe "someFunc" $ do
    it "greets foo" $
      someFunc "foo" `shouldBe` "Hello foo!"

    it "greets anybody" $
      property $ \name -> name `isInfixOf` someFunc name
