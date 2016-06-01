--  Copyright 2015 Abid Hasan Mujtaba
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
--
--
-- This module contains ALL Unit Tests for this project.
-- It exports a single 'main' function that runs all of the tests defined here-in
--
-- Source for HUnit usage: https://wiki.haskell.org/HUnit_1.0_User's_Guide


module UnitTests.Main (main)
    where

import Prelude hiding ((^))     -- This allows us to use the ^ operator defined in CAS without collision with Prelude.^

import Test.HUnit
import CAS

import UnitTests.Base
import qualified UnitTests.Multiplication



main :: IO Counts
main = do                -- This IO Action runs only the unit tests
            runTestTT tests



-- We add a label to the TestCase by using the TestLabel constructor.
-- The assertions are grouped together as a single TestCase
-- Since the assertions are IO () we use the 'do' keyword to group together a sequence of them
-- The first assertion that fails causes the entire TestCase to fail and the subsequent assertions are not tested
-- Each assertEqual call takes the format: aE <failure message> <expected value> <actual/tested value>

tests :: Test
tests = TestList $
            UnitTests.Multiplication.tests
        ++
        [                                              -- We create a list of TestCases

            TestLabel "Adding similar products" $
                TestCase $ do

                    let e = x + y

                    aE "test1" (2 * e) (e + e)
                    aE "test2" (5 * e) ((2 * e) + (3 * e))
                    aE "test3" (3 * e) ((-2 * e) + (5 * e))
                    aE "test4" (-7 * e) ((-3 * e) + (4 * (-e)))
            ,

            TestLabel "Adding element to product of same element" $
                TestCase $ do

                    aE "test1" (3 * x) (x + (2 * x))
                    aE "test2" (-2 * x) (x + (-3 * x))
                    aE "test3" (3 * x * y) ((x * y) + (2 * x * y))
                    aE "test4" (3 * x^2) (x^2 + (2 * x^2))
            ,

            TestLabel "Subtracting equal expressions" $
                TestCase $ do

                    let e1 = -1 + x
--                    let e2 = 2 * (-x) / y
                    let e3 = -y + (2 * x * y)
                    let e4 = x + y
                    let e5 = -1 + e4
                    let e6 = e5 + z

                    aE "test2" 0 (x - x)
                    aE "test3" 0 (e1 - e1)
--                    aE "test4" 0 (e2 - e2)
                    aE "test5" 0 (e3 - e3)
                    aE "test6" 0 (e4 - e4)
                    aE "test7" 0 (e5 - e5)
                    aE "test8" 0 (e6 - e6)
            ,

            TestLabel "Order of Product Elements" $
                TestCase $ do

                    aE "test1" "(x * y)" $ show (x * y)
                    aE "test2" "(2 * x)" $ show (x * 2)
                    aE "test3" "(2 * x^2 * y)" $ show (2 * y * x^2)
                    aE "test4" "-(2 * x * y^2)" $ show (x * (-2) * y^2)
                    aE "test5" "(x * y * (y + z))" $ show (x * y * (y + z))
                    aE "test6" "(x * z^2 * (x + y))" $ show ((x + y) * z^2 * x)
                    aE "test7" "(x * z^2 * (x + y) * (y + z))" $ show ((y + z) * z^2 * (x + y) * x)
                    aE "test8" "(x * y^2 * (y + z)^3)" $ show ((y + z)^2 * y^2 * (y + z) * x)
                    aE "test9" "((y + z) * ((x * y) + 1))" $ show ((x * y + 1) * (y + z))
            ,

            TestLabel "Graded Reversed Lexical Order" $
                TestCase $ do

                    aE "test1"  EQ $ compare x x
                    aE "test2"  LT $ compare 2 x
                    aE "test3"  GT $ compare x y
                    aE "test4"  GT $ compare (x^2) x
                    aE "test5"  LT $ compare x (y^2)
                    aE "test6"  GT $ compare x (2 * y)
                    aE "test7"  LT $ compare (2 * y) (3 * x)
                    aE "test8"  EQ $ compare (2 * x) (2 * x)
                    aE "test9"  GT $ compare (x * y) (y * z)
                    aE "test10" LT $ compare (x * y) (x^2)
                    aE "test11" GT $ compare (x * y^2 * z) (x * y * z^2)
                    aE "test12" GT $ compare (x * y * z) (x * z^2)
                    aE "test13" EQ $ compare (x * y * z) (x * y * z)
                    aE "test14" EQ $ compare (x * y^2 * z) (x * y^2 * z)
                    aE "test15" LT $ compare x (2 * x)
                    aE "test16" GT $ compare (3 * x) x
                    aE "test17" LT $ compare x (-2 * x)             -- Negative constants shouldn't impact the order of terms
            ,

            TestLabel "Order of Added Elements" $
                TestCase $ do

                    aE "test1" "(x + 2)" $ show (x + 2)
                    aE "test2" "(x + y)" $ show (x + y)
                    aE "test3" "(x^2 + y)" $ show (x^2 + y)
                    aE "test4" "(y^2 + x)" $ show (x + y^2)
                    aE "test5" "(y + (2 * z) + 1)" $ show $ y + (1 + 2 * z)
                    aE "test6" "(x - y)" $ show (x - y)
                    aE "test7" "(x - y)" $ show (-y + x)
                    aE "test8" "(x/y + 1)" $ show (1 + x/y)
                    aE "test9" "(x + x/y)" $ show (x + x/y)
                    aE "test10" "(1/x + 1/y)" $ show (1/x + 1/y)
                    aE "test11" "(x/y + y/z)" $ show (x/y + y/z)
                    aE "test12" "(x/y + z/y)" $ show (x/y + z/y)
                    aE "test13" "(x^2/y + z^2/x)" $ show (x^2/y + z^2/x)
            ,

            TestLabel "Comparing expressions" $
                TestCase $ do

                    aE "test1" EQ $ compare x x
                    aE "test2" GT $ compare x y
                    aE "test3" LT $ compare y x
                    aE "test4" EQ $ compare (x + y) (y + x)
                    aE "test5" GT $ compare (x + y) (y + z)
                    aE "test6" GT $ compare (x - z - 2) (1 - y)
                    aE "test7" GT $ compare (x^2 + y^2) (z^2)
                    aE "test8" GT $ compare y (2*z)
                    aE "test9" LT $ compare z (3*y)
                    aE "test10" GT $ compare (x + 1) (y + 2)
                    aE "test11" GT $ compare x (-x)
                    aE "test12" GT $ compare (z + 1) (-z + 1)
                    aE "test13" GT $ compare (z^2) ((z + 1)^2)
            ,

            TestLabel "Additive Commutation" $
                TestCase $ do

                    let e2 = (1 + 2 * y)
                    let e3 = (2 + y)
                    let e4 = (1 + 2 * z)

                    let e5 = 9 * y * z^2
                    let e6 = z * (z + 1)^2

                    aE "test1" (x + y) (y + x)
                    aE "test2" (x + e2) (e2 + x)
                    aE "test3" (e3 + e4) (e4 + e3)
                    aE "test4" (e5 + e6) (e6 + e5)
        ]
