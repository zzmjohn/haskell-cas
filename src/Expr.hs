-- | The Expr module defines the Expr type-class and consequently forms the core of the CAS module
module Expr
    where

-- | The Expr type forms the core of the Computer Algebra System.
--   Its strength lies in its recursive definition of what an expression can be.
--   For instance an Expr of type Sum is simply a list of other Expr objects which can be of any type (including Sum).
data Expr a =                               -- B.1, B.2
              Const a                       -- B.3
            | Sum [Expr a]                  -- B.4
            | Prod [Expr a]
            | Neg (Expr a)
            | Frac (Expr a) (Expr a)        -- B.5
            | Exp (Expr a) Int              -- B.6
            | Symbol String                 -- B.7
            deriving (Eq)                   -- B.8
